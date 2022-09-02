package dk.cngroup.pokedex.view.screen

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.skydoves.landscapist.glide.GlideImage
import dk.cngroup.pokedex.R
import dk.cngroup.pokedex.common.PokemonDetail
import dk.cngroup.pokedex.common.Type
import dk.cngroup.pokedex.view.theme.PokedexTheme
import dk.cngroup.pokedex.view_model.PokemonDetailViewModel

@Composable
fun PokemonDetailScreen(
    pokemonId: Int,
    viewModel: PokemonDetailViewModel = viewModel()
) {
    val data: PokemonDetail? = viewModel.also {
        it.getPokemonDetail(pokemonId)
    }.stateFlow.collectAsState(null).value

    Column {
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(300.dp)
                .background(color = MaterialTheme.colorScheme.secondary),
            contentAlignment = Alignment.Center
        ) {
            GlideImage(
                modifier = Modifier.fillMaxSize(0.7f),
                imageModel = data?.imageUrl,
                previewPlaceholder = R.drawable.bulbasaur
            )
        }
        Column(modifier = Modifier.padding(20.dp)) {
            Text(
                text = "#${data?.id} ${data?.name}",
                fontSize = 32.sp,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.fillMaxWidth(),
                textAlign = TextAlign.Center
            )

            PokemonTypes(
                modifier = Modifier.padding(vertical = 8.dp),
                types = data?.types ?: emptyList()
            )

            DetailListItem(title = "Base Experience", value = data?.baseExperience?.toString())
            DetailListItem(title = "Weight", value = data?.weight?.toString())
            DetailListItem(title = "Height", value = data?.height?.toString())
        }
    }
}

@Composable
private fun PokemonTypes(
    modifier: Modifier = Modifier,
    types: List<Type>
) {
    if (types.isNotEmpty()) {
        Row(
            modifier = modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.Center
        ) {
            types.forEach {
                Box(
                    modifier = Modifier
                        .padding(4.dp)
                        .background(
                            shape = RoundedCornerShape(4.dp),
                            color = MaterialTheme.colorScheme.primaryContainer
                        )
                        .padding(4.dp)
                ) {
                    Text(text = it.type.name)
                }
            }
        }
    }
}

@Composable
private fun DetailListItem(
    title: String,
    value: String?
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 8.dp),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Text(
            text = title,
            color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.6f)
        )
        Text(
            text = value ?: "",
            fontWeight = FontWeight.Bold
        )
    }
}

@Preview
@Composable
private fun PokemonDetailScreenPreview() {
    PokedexTheme {
        PokemonDetailScreen(
            pokemonId = 1,
            viewModel = PokemonDetailViewModel()
        )
    }
}

@Preview
@Composable
private fun DetailListItemPreview() {
    PokedexTheme {
        DetailListItem(title = "Base Experience", value = "64")
    }
}