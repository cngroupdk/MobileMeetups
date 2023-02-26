package dk.cngroup.pokedex.shared.service

import dk.cngroup.pokedex.shared.data.api.ApiPokedex
import dk.cngroup.pokedex.shared.data.model.Pokemon
import dk.cngroup.pokedex.shared.data.model.PokemonDetail
import dk.cngroup.pokedex.shared.data.model.PokemonType
import dk.cngroup.pokedex.shared.data.model.Species
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
        return apiPokedex.fetchPokemonDetail(id).run {
            this.copy(
                name = this.name.replaceFirstChar { it.uppercase() },
                imageUrl = getPokemonImageUrlById(id)
            )
        }
    }

    private fun getPokemonImageUrlById(id: Int) = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png"
}
//endregion

//region MockPokedexRepository
class MockPokedexRepository : PokedexRepository {
    override suspend fun getPokemonAll(): List<Pokemon> = listOf(
        Pokemon(id = 1, name = "Bulbasaur", imageUrl = getPokemonImageUrlById(1)),
        Pokemon(id = 2, name = "Ivysaur", imageUrl = getPokemonImageUrlById(2)),
        Pokemon(id = 3, name = "Venusaur", imageUrl = getPokemonImageUrlById(3)),
        Pokemon(id = 4, name = "Charmander", imageUrl = getPokemonImageUrlById(4)),
        Pokemon(id = 5, name = "Charmeleon", imageUrl = getPokemonImageUrlById(5)),
        Pokemon(id = 6, name = "Charizard", imageUrl = getPokemonImageUrlById(6))
    )

    override suspend fun getPokemonDetail(id: Int): PokemonDetail = PokemonDetail(
        baseExperience = 64,
        height = 7,
        id = 1,
        name = "Bulbasaur",
        types = listOf(
            PokemonType(
                slot = 1,
                type = Species(name = "grass", url = "https://pokeapi.co/api/v2/type/12/")
            ),
            PokemonType(
                slot = 2,
                type = Species(name = "poison", url = "https://pokeapi.co/api/v2/type/4/")
            )
        ),
        weight = 69,
        imageUrl = getPokemonImageUrlById(1)
    )

    private fun getPokemonImageUrlById(id: Int) = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png"
}
//endregion
