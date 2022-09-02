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
    // TODO: define pokemon repository

    // Original pokemon list
    // TODO: define variable for storing original pokemon list

    // Flow for pokemon list
    // TODO: define flow with pokemon data list

    // Flow for searchbar
    // TODO: define state flow for searchbar

    init {
        // Fetch data when the ViewModel was initialized
        // TODO: retrieve the pokemon list from the repository and emit them into the flow
    }

    // Updates shown pokemon list based on the input text
    // TODO: on searchbar text updated -> filter pokemons
}