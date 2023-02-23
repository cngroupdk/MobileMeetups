package dk.cngroup.pokedex.shared.data.api

import io.ktor.client.call.*
import io.ktor.client.request.*
import kotlinx.serialization.Serializable

internal class ApiPokedex : Api() {

    @Serializable
    data class PokemonListResult(val count: Int, val results: List<PokemonResult>?)

    @Serializable
    data class PokemonResult(val name: String, val url: String)

    suspend fun fetchAllPokemons(): PokemonListResult {
        return client.get(ApiLink.POKEMON.getLink() + "?limit=150").body()
    }
}