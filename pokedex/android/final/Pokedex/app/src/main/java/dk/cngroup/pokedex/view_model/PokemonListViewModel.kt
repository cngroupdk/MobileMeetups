package dk.cngroup.pokedex.view_model

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dk.cngroup.pokedex.common.Pokemon
import dk.cngroup.pokedex.model.PokedexRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

class PokemonListViewModel : ViewModel() {

    // Repository for fetching data
    private val pokedexRepository: PokedexRepository = PokedexRepository()

    // Original pokemon list
    private var originalPokemonList: List<Pokemon>? = null

    // Flow for pokemon list
    private val _pokemonListFlow = MutableStateFlow<List<Pokemon>?>(emptyList())
    val pokemonListFlow: StateFlow<List<Pokemon>?> = _pokemonListFlow.asStateFlow()

    // Flow for searchbar
    private val _searchBarFlow = MutableStateFlow("")
    val searchBarFlow: StateFlow<String> = _searchBarFlow

    init {
        // Fetch data when the ViewModel was initialized
        viewModelScope.launch(Dispatchers.IO) {
            originalPokemonList = pokedexRepository.getPokemonAll()
            _pokemonListFlow.value = originalPokemonList
        }
    }

    // Updates shown pokemon list based on the input text
    fun updateSearchBarText(newText: String) {
        _searchBarFlow.value = newText
        _pokemonListFlow.value = originalPokemonList?.filter {
            it.name.lowercase().contains(newText.trim().lowercase())
        }
    }
}