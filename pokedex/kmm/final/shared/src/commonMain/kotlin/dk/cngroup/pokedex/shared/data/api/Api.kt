package dk.cngroup.pokedex.shared.data.api

import io.ktor.client.*
import io.ktor.client.plugins.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.request.*
import io.ktor.serialization.kotlinx.json.*
import kotlinx.serialization.json.Json

internal abstract class Api {
    private val nonStrictJson = Json { isLenient = true; ignoreUnknownKeys = true }

    val client: HttpClient = HttpClient {
        install(ContentNegotiation) {
            json(nonStrictJson)
        }
    }
}
