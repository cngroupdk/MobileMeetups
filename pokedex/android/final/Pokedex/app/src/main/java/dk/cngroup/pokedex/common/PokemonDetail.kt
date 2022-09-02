package dk.cngroup.pokedex.common

import retrofit2.http.Field

data class PokemonDetail(
    @Field("base_experience")
    val baseExperience: Long,
    val height: Long,
    val id: Long,
    val name: String,
    val types: List<Type>,
    val weight: Long,
    val imageUrl: String = "",
)

data class Species(
    val name: String,
    val url: String
)

data class Type(
    val slot: Long,
    val type: Species
)
