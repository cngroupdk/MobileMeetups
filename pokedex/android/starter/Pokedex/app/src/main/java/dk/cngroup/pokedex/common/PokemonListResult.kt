package dk.cngroup.pokedex.common

data class PokemonListResult(
    val count: Int,
    val results: List<PokemonResult>?
)