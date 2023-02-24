package dk.cngroup.pokedex.android.utils

import androidx.compose.ui.graphics.Color
import dev.icerock.moko.resources.ColorResource
import dk.cngroup.pokedex.sharedresources.toColor

fun ColorResource.composeColor(): Color = Color(this.toColor().argb)
