package dk.cngroup.pokedex.android.ui.screen

import android.content.res.Configuration
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.skydoves.landscapist.ImageOptions
import com.skydoves.landscapist.glide.GlideImage
import dk.cngroup.pokedex.android.ui.component.template.DetailListItem
import dk.cngroup.pokedex.android.ui.component.template.PokemonTypes
import dk.cngroup.pokedex.android.ui.theme.PokedexTheme
import dk.cngroup.pokedex.shared.presentation.viewModel.PokemonDetailViewModel
import dk.cngroup.pokedex.shared.service.MockPokedexRepository
import dk.cngroup.pokedex.sharedresources.MR
import dk.cngroup.pokedex.sharedresources.Resources
import dk.cngroup.pokedex.sharedresources.localized

@Composable
fun PokemonDetailScreen(
    viewModel: PokemonDetailViewModel
) {
    val data = viewModel.pokemonDetailFlow.collectAsState().value

    Column {
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(300.dp)
                .background(color = MaterialTheme.colorScheme.secondary),
            contentAlignment = Alignment.Center
        ) {
            GlideImage(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(16.dp),
                imageModel = { data?.imageUrl },
                imageOptions = ImageOptions(contentScale = ContentScale.Fit)
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

            DetailListItem(
                title = MR.strings.pokemonDetail_baseExperience.localized(),
                value = data?.baseExperience?.toString()
            )
            DetailListItem(
                title = MR.strings.pokemonDetail_weight.localized(),
                value = data?.weight?.toString()
            )
            DetailListItem(
                title = MR.strings.pokemonDetail_height.localized(),
                value = data?.height?.toString()
            )
        }
    }
}

@Preview(name = "Light Mode", showBackground = true)
@Preview(name = "Dark Mode", uiMode = Configuration.UI_MODE_NIGHT_YES, showBackground = true)
@Composable
private fun PokemonDetailScreenPreview() {
    Resources.appContext = LocalContext.current
    PokedexTheme {
        PokemonDetailScreen(
            viewModel = PokemonDetailViewModel(
                repository = MockPokedexRepository(),
                pokemonId = "1"
            )
        )
    }
}
