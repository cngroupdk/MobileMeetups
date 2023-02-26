package dk.cngroup.pokedex.android.ui.component.template

import android.content.res.Configuration
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import dk.cngroup.pokedex.android.ui.theme.PokedexTheme
import dk.cngroup.pokedex.shared.data.model.Species
import dk.cngroup.pokedex.shared.data.model.Type
import dk.cngroup.pokedex.sharedresources.Resources

@Composable
fun PokemonTypes(
    modifier: Modifier = Modifier,
    types: List<Type>
) {
    if (types.isNotEmpty()) {
        Row(
            modifier = modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.Center
        ) {
            types.forEach {
                Box(
                    modifier = Modifier
                        .padding(4.dp)
                        .background(
                            shape = RoundedCornerShape(4.dp),
                            color = MaterialTheme.colorScheme.primaryContainer
                        )
                        .padding(4.dp)
                ) {
                    Text(text = it.type.name)
                }
            }
        }
    }
}

@Preview(name = "Light Mode", showBackground = true)
@Preview(name = "Dark Mode", uiMode = Configuration.UI_MODE_NIGHT_YES, showBackground = true)
@Composable
private fun PokemonTypesPreview() {
    Resources.appContext = LocalContext.current
    PokedexTheme {
        PokemonTypes(
            types = listOf(
                Type(
                    slot = 1,
                    type = Species(name = "grass", url = "https://pokeapi.co/api/v2/type/12/")
                ),
                Type(
                    slot = 2,
                    type = Species(name = "poison", url = "https://pokeapi.co/api/v2/type/4/")
                )
            )
        )
    }
}
