package dk.cngroup.pokedex.shared.service

import dk.cngroup.pokedex.shared.data.api.ApiPokedex
import dk.cngroup.pokedex.shared.data.model.Pokemon
import dk.cngroup.pokedex.shared.data.model.PokemonDetail
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

interface PokedexRepository {
    suspend fun getPokemonAll(): List<Pokemon>
    suspend fun getPokemonDetail(id: Int): PokemonDetail
}

//region PokedexRepositoryImpl
internal class PokedexRepositoryImpl(
    private val defaultDispatcher: CoroutineDispatcher = Dispatchers.Default
) : PokedexRepository {

    private val apiPokedex: ApiPokedex by lazy { ApiPokedex() }

    override suspend fun getPokemonAll(): List<Pokemon> = withContext(defaultDispatcher) {
        apiPokedex.fetchAllPokemons().results?.map { pokemonEntity ->
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
        } ?: listOf()
    }

    override suspend fun getPokemonDetail(id: Int): PokemonDetail {
        TODO("Not yet implemented")
    }

    private fun getPokemonImageUrlById(id: Int) = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png"
}
//endregion

//region MockPokedexRepository
class MockPokedexRepository : PokedexRepository {
    override suspend fun getPokemonAll(): List<Pokemon> {
        TODO("Not yet implemented")
    }

    override suspend fun getPokemonDetail(id: Int): PokemonDetail {
        TODO("Not yet implemented")
    }
}
//endregion
