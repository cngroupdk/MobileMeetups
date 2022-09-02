package dk.cngroup.pokedex.model

import dk.cngroup.pokedex.common.PokemonDetail
import dk.cngroup.pokedex.common.PokemonListResult
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path

interface PokedexService {

    @GET("pokemon?limit=100")
    fun getPokemonAll(): Call<PokemonListResult>

    @GET("pokemon/{pokemon_id}")
    fun getPokemon(@Path("pokemon_id") pokemonId: Int): Call<PokemonDetail>

}