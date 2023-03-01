package dk.cngroup.pokedex.shared.presentation.viewModel

import dk.cngroup.pokedex.shared.data.model.Pokemon
import dk.cngroup.pokedex.shared.platform.BaseViewModel
import dk.cngroup.pokedex.shared.platform.ioDispatcher
import dk.cngroup.pokedex.shared.platform.unaccent
import dk.cngroup.pokedex.shared.service.PokedexRepository
import kotlinx.collections.immutable.ImmutableList
import kotlinx.collections.immutable.persistentListOf
import kotlinx.collections.immutable.toImmutableList
import kotlinx.coroutines.Job
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

    // Flow for search query
    private val _searchQueryFlow = MutableStateFlow("")
    val searchQueryFlow: StateFlow<String> = _searchQueryFlow

    private var searchingJob: Job? = null

    init {
        scope.launch(ioDispatcher) {
            try {
                originalPokemonList = repository.getPokemonAll()
                _pokemonListFlow.value = originalPokemonList.toImmutableList()
            } catch (e: Throwable) {

            }
        }
    }

    fun searchPokemon(term: String) {
        _searchQueryFlow.value = term

        searchingJob?.cancel()
        searchingJob = scope.launch(ioDispatcher) {
            val normalizedTerm = term.trim().unaccent()
            val newPokemonList = if (normalizedTerm.isEmpty()) {
                originalPokemonList
            } else {
                originalPokemonList.filter {
                    it.name.unaccent().contains(normalizedTerm, true)
                }
            }
            _pokemonListFlow.value = newPokemonList.toImmutableList()
        }
    }
}
