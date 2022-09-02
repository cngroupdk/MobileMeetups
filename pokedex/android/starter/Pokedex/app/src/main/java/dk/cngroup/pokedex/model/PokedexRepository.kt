package dk.cngroup.pokedex.model

import dk.cngroup.pokedex.common.Pokemon
import dk.cngroup.pokedex.common.PokemonDetail
import retrofit2.Retrofit
import retrofit2.await
import retrofit2.converter.gson.GsonConverterFactory

class PokedexRepository {

    val pokemonListUrl = "https://pokeapi.co/api/v2/"

    // TODO: defined rest client by Retrofit library

    // TODO: define pokemon service

    // TODO: define suspendable function that returns pokemon list

    // TODO: define suspendable function that returns pokemon detail

    private fun getPokemonImageUrlById(id: Int): String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${id}.png"
    }
}

