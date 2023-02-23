package dk.cngroup.pokedex.android.ui.theme

import android.app.Activity
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.compositeOver
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalView
import androidx.core.view.ViewCompat
import dk.cngroup.pokedex.android.utils.composeColor
import dk.cngroup.pokedex.sharedresources.MR

private val DarkColorScheme = darkColorScheme(
    primary = MR.colors.dark_primary.composeColor(),
    onPrimary = MR.colors.dark_onPrimary.composeColor(),
    primaryContainer = MR.colors.dark_primaryContainer.composeColor(),
    onPrimaryContainer = MR.colors.dark_onPrimaryContainer.composeColor(),
    secondary = MR.colors.dark_secondary.composeColor(),
    onSecondary = MR.colors.dark_onSecondary.composeColor(),
    secondaryContainer = MR.colors.dark_secondaryContainer.composeColor(),
    onSecondaryContainer = MR.colors.dark_onSecondaryContainer.composeColor(),
    tertiary = MR.colors.dark_tertiary.composeColor(),
    onTertiary = MR.colors.dark_onTertiary.composeColor(),
    tertiaryContainer = MR.colors.dark_tertiaryContainer.composeColor(),
    onTertiaryContainer = MR.colors.dark_onTertiaryContainer.composeColor(),
    error = MR.colors.dark_error.composeColor(),
    errorContainer = MR.colors.dark_errorContainer.composeColor(),
    onError = MR.colors.dark_onError.composeColor(),
    onErrorContainer = MR.colors.dark_onErrorContainer.composeColor(),
    background = MR.colors.dark_background.composeColor(),
    onBackground = MR.colors.dark_onBackground.composeColor(),
    surface = MR.colors.dark_surface.composeColor(),
    onSurface = MR.colors.dark_onSurface.composeColor(),
    surfaceVariant = MR.colors.dark_surfaceVariant.composeColor(),
    onSurfaceVariant = MR.colors.dark_onSurfaceVariant.composeColor(),
    outline = MR.colors.dark_outline.composeColor(),
    inverseOnSurface = MR.colors.dark_inverseOnSurface.composeColor(),
    inverseSurface = MR.colors.dark_inverseSurface.composeColor(),
    inversePrimary = MR.colors.dark_inversePrimary.composeColor(),
    surfaceTint = MR.colors.dark_surfaceTint.composeColor(),
    outlineVariant = MR.colors.dark_outlineVariant.composeColor(),
    scrim = MR.colors.dark_scrim.composeColor()
)

private val LightColorScheme = lightColorScheme(
    primary = MR.colors.light_primary.composeColor(),
    onPrimary = MR.colors.light_onPrimary.composeColor(),
    primaryContainer = MR.colors.light_primaryContainer.composeColor(),
    onPrimaryContainer = MR.colors.light_onPrimaryContainer.composeColor(),
    secondary = MR.colors.light_secondary.composeColor(),
    onSecondary = MR.colors.light_onSecondary.composeColor(),
    secondaryContainer = MR.colors.light_secondaryContainer.composeColor(),
    onSecondaryContainer = MR.colors.light_onSecondaryContainer.composeColor(),
    tertiary = MR.colors.light_tertiary.composeColor(),
    onTertiary = MR.colors.light_onTertiary.composeColor(),
    tertiaryContainer = MR.colors.light_tertiaryContainer.composeColor(),
    onTertiaryContainer = MR.colors.light_onTertiaryContainer.composeColor(),
    error = MR.colors.light_error.composeColor(),
    errorContainer = MR.colors.light_errorContainer.composeColor(),
    onError = MR.colors.light_onError.composeColor(),
    onErrorContainer = MR.colors.light_onErrorContainer.composeColor(),
    background = MR.colors.light_background.composeColor(),
    onBackground = MR.colors.light_onBackground.composeColor(),
    surface = MR.colors.light_surface.composeColor(),
    onSurface = MR.colors.light_onSurface.composeColor(),
    surfaceVariant = MR.colors.light_surfaceVariant.composeColor(),
    onSurfaceVariant = MR.colors.light_onSurfaceVariant.composeColor(),
    outline = MR.colors.light_outline.composeColor(),
    inverseOnSurface = MR.colors.light_inverseOnSurface.composeColor(),
    inverseSurface = MR.colors.light_inverseSurface.composeColor(),
    inversePrimary = MR.colors.light_inversePrimary.composeColor(),
    surfaceTint = MR.colors.light_surfaceTint.composeColor(),
    outlineVariant = MR.colors.light_outlineVariant.composeColor(),
    scrim = MR.colors.light_scrim.composeColor()
)

@Composable
fun PokedexTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    val colorScheme = when {
        darkTheme -> DarkColorScheme
        else -> LightColorScheme
    }
    val view = LocalView.current
    if (!view.isInEditMode) {
        SideEffect {
            val window = (view.context as Activity).window
            window.statusBarColor = colorScheme.primary.toArgb()
            window.navigationBarColor = colorScheme.primary.copy(alpha = 0.08f).compositeOver(colorScheme.surface.copy()).toArgb()
            ViewCompat.getWindowInsetsController(view)?.isAppearanceLightStatusBars = darkTheme
            ViewCompat.getWindowInsetsController(view)?.isAppearanceLightNavigationBars = darkTheme
        }
    }

    MaterialTheme(
        colorScheme = colorScheme,
        content = content
    )
}
