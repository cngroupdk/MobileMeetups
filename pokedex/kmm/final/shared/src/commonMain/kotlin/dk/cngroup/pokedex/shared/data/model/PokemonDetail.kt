package dk.cngroup.pokedex.shared.data.model

import dk.cngroup.pokedex.shared.platform.Parcelable
import dk.cngroup.pokedex.shared.platform.Parcelize
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Parcelize
@Serializable
data class PokemonDetail(
    @SerialName("base_experience")
    val baseExperience: Long,
    val height: Long,
    val id: Long,
    val name: String,
    val types: List<Type>,
    val weight: Long,
    val imageUrl: String?
) : Parcelable

@Parcelize
@Serializable
data class Species(
    val name: String,
    val url: String
) : Parcelable

@Parcelize
@Serializable
data class Type(
    val slot: Long,
    val type: Species
) : Parcelable
