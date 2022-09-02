package dk.cngroup.pokedex.view_model

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dk.cngroup.pokedex.common.PokemonDetail
import dk.cngroup.pokedex.model.PokedexRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

class PokemonDetailViewModel: ViewModel() {

    // Repository for fetching data
    private val pokedexRepository: PokedexRepository = PokedexRepository()

    // Flow for data propagation
    private val _stateFlow = MutableStateFlow<PokemonDetail?>(value = null)
    val stateFlow: StateFlow<PokemonDetail?> = _stateFlow.asStateFlow()

//    fun getPokemonDetail(id: Int) {
//        viewModelScope.launch {
//            _stateFlow.value = pokedexRepository.getPokemonDetail(id)
//        }
//    }
}