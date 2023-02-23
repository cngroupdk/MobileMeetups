package dk.cngroup.pokedex.shared.data.model

import dk.cngroup.pokedex.shared.platform.Parcelable
import dk.cngroup.pokedex.shared.platform.Parcelize
import kotlinx.serialization.Serializable

@Parcelize
@Serializable
data class Pokemon(
    val id: Int = 0,
    val name: String,
    val imageUrl: String?
) : Parcelable
