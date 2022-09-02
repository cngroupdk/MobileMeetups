package dk.cngroup.pokedex.view.screen

import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.lifecycle.viewmodel.compose.viewModel
import dk.cngroup.pokedex.common.PokemonDetail
import dk.cngroup.pokedex.view_model.PokemonDetailViewModel

@Composable
fun PokemonDetailScreen(
    pokemonId: Int,
    viewModel: PokemonDetailViewModel = viewModel()
) {
//    val data: PokemonDetail? = viewModel.also {
//        it.getPokemonDetail(pokemonId)
//    }.stateFlow.collectAsState(null).value

//    Text(text = "#${data?.id} ${data?.name}")
}