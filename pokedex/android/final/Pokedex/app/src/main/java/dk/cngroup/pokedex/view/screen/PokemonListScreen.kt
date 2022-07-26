@file:OptIn(ExperimentalMaterial3Api::class)

package dk.cngroup.pokedex.view.screen

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.skydoves.landscapist.glide.GlideImage
import dk.cngroup.pokedex.R
import dk.cngroup.pokedex.common.Pokemon
import dk.cngroup.pokedex.view.theme.PokedexTheme
import dk.cngroup.pokedex.view_model.PokemonListViewModel

@Composable
fun PokemonListScreen(
    viewModel: PokemonListViewModel = viewModel(),
    navigateToPokemonDetail: (pokemonId: Int) -> Unit
) {
    val pokemonList: List<Pokemon>? =
        viewModel.pokemonListFlow.collectAsState(initial = emptyList()).value
    val searchBar: String = viewModel.searchBarFlow.collectAsState(initial = "").value

    Column(
        modifier = Modifier.padding(horizontal = 12.dp)
    ) {
        Text(
            text = "Pokémon",
            fontSize = 48.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        TextField(
            modifier = Modifier.fillMaxWidth(),
            value = searchBar,
            onValueChange = {
                viewModel.updateSearchBarText(it)
            },
            placeholder = {
                Text(text = "Look for pokémon...")
            }
        )

        LazyVerticalGrid(
            columns = GridCells.Fixed(2),
            modifier = Modifier.fillMaxSize(),
            contentPadding = PaddingValues(vertical = 8.dp),
            verticalArrangement = Arrangement.spacedBy(10.dp),
            horizontalArrangement = Arrangement.spacedBy(10.dp)
        ) {
            items(
                items = pokemonList ?: emptyList(),
                key = { it.id },
            ) {
                PokemonItem(
                    pokemon = it,
                    onClick = navigateToPokemonDetail
                )
            }
        }
    }
}

@Composable
private fun PokemonItem(
    pokemon: Pokemon,
    onClick: (pokemonId: Int) -> Unit
) {
    Box(
        modifier = Modifier
            .fillMaxSize()
            .clip(shape = RoundedCornerShape(12.dp))
            .background(
                color = MaterialTheme.colorScheme.primary.copy(alpha = 0.1f)
            )
            .clickable {
                onClick(pokemon.id)
            }
            .padding(8.dp)
    ) {
        Column {
            Text(
                text = pokemon.name,
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
            )
            Text(
                modifier = Modifier
                    .background(
                        shape = RoundedCornerShape(6.dp),
                        color = MaterialTheme.colorScheme.primary.copy(alpha = 0.2f)
                    )
                    .padding(2.dp),
                fontSize = 12.sp,
                text = "#${pokemon.id}"
            )
        }
        GlideImage(
            modifier = Modifier
                .size(80.dp)
                .align(Alignment.BottomEnd),
            imageModel = pokemon.imageUrl,
            contentScale = ContentScale.Fit,
            previewPlaceholder = R.drawable.bulbasaur
        )
    }
}

@Preview
@Composable
private fun PokemonListScreenPreview() {
    PokedexTheme {
        PokemonListScreen(
            viewModel = PokemonListViewModel(),
            navigateToPokemonDetail = { }
        )
    }
}

@Preview
@Composable
private fun PokemonItemPreview() {
    PokedexTheme {
        PokemonItem(
            pokemon = Pokemon(
                id = 1,
                name = "bulbasaur",
                imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png"
            ),
            onClick = { }
        )
    }
}