package dk.cngroup.pokedex.shared.data.api

internal enum class ApiLink(private val path: String) {
    POKEMON("pokemon");

    private companion object {
        const val serverUrl = "https://pokeapi.co/api/v2/"
    }

    fun getLink(): String = serverUrl + path
}
