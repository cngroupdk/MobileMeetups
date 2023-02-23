package dk.cngroup.pokedex.shared.presentation.viewModel

import dk.cngroup.pokedex.shared.data.model.Pokemon
import dk.cngroup.pokedex.shared.platform.BaseViewModel
import dk.cngroup.pokedex.shared.platform.ioDispatcher
import dk.cngroup.pokedex.shared.platform.unaccent
import dk.cngroup.pokedex.shared.service.PokedexRepository
import kotlinx.collections.immutable.ImmutableList
import kotlinx.collections.immutable.persistentListOf
import kotlinx.collections.immutable.toImmutableList
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

class PokemonListViewModel(
    private val repository: PokedexRepository
) : BaseViewModel() {

    // Original pokemon list
    private var originalPokemonList: List<Pokemon> = listOf()

    // Flow for pokemon list
    private val _pokemonListFlow = MutableStateFlow<ImmutableList<Pokemon>>(persistentListOf())
    val pokemonListFlow: StateFlow<ImmutableList<Pokemon>> = _pokemonListFlow.asStateFlow()

    // Flow for searchbar
    private val _searchBarFlow = MutableStateFlow("")
    val searchBarFlow: StateFlow<String> = _searchBarFlow

    init {
        // Fetch data when the ViewModel was initialized
        scope.launch(ioDispatcher) {
            originalPokemonList = repository.getPokemonAll()
            _pokemonListFlow.value = originalPokemonList.toImmutableList()
        }
    }

    fun updateSearchBarText(newText: String) {
        val normalizedTerm = newText.trim().unaccent()
        _searchBarFlow.value = newText
        _pokemonListFlow.value = originalPokemonList.filter {
            it.name.unaccent().contains(normalizedTerm, true)
        }.toImmutableList()
    }
}
