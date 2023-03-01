package dk.cngroup.pokedex.shared.presentation.viewModel

import dk.cngroup.pokedex.shared.data.model.PokemonDetail
import dk.cngroup.pokedex.shared.platform.BaseViewModel
import dk.cngroup.pokedex.shared.platform.ioDispatcher
import dk.cngroup.pokedex.shared.service.PokedexRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

class PokemonDetailViewModel(
    private val repository: PokedexRepository,
    pokemonId: String
) : BaseViewModel() {

    // Flow for data propagation
    private val _pokemonDetailFlow = MutableStateFlow<PokemonDetail?>(value = null)
    val pokemonDetailFlow: StateFlow<PokemonDetail?> = _pokemonDetailFlow.asStateFlow()

    init {
        scope.launch(ioDispatcher) {
            try {
                _pokemonDetailFlow.value = repository.getPokemonDetail(id = pokemonId.toInt())
            } catch (e: Throwable) {
                
            }
        }
    }
}
