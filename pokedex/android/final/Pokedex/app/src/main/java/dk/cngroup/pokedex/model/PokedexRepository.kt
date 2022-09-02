package dk.cngroup.pokedex.model

import dk.cngroup.pokedex.common.Pokemon
import dk.cngroup.pokedex.common.PokemonDetail
import retrofit2.Retrofit
import retrofit2.await
import retrofit2.converter.gson.GsonConverterFactory

class PokedexRepository {

    private val restClient = Retrofit.Builder()
        .baseUrl("https://pokeapi.co/api/v2/")
        .addConverterFactory(GsonConverterFactory.create())
        .build()

    private val pokedexService = restClient.create(PokedexService::class.java)

    suspend fun getPokemonAll(): List<Pokemon>? {
        return pokedexService.getPokemonAll().await().results?.map { pokemonEntity ->

            val name = pokemonEntity.name.replaceFirstChar { it.uppercase() }
            val id = pokemonEntity.url
                .split("/")
                .findLast { it.isNotBlank() }
                ?.toInt()
                ?: 0
            val imageLink = getPokemonImageUrlById(id)

            Pokemon(
                name = name,
                id = id,
                imageUrl = imageLink
            )
        }
    }

    suspend fun getPokemonDetail(id: Int): PokemonDetail {
        return pokedexService.getPokemon(id).await().run {
            this.copy(
                name = this.name.replaceFirstChar { it.uppercase() },
                imageUrl = getPokemonImageUrlById(id)
            )
        }
    }

    private fun getPokemonImageUrlById(id: Int) = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${id}.png"
}

