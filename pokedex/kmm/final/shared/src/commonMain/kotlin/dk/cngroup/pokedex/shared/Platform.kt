package dk.cngroup.pokedex.shared

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform
