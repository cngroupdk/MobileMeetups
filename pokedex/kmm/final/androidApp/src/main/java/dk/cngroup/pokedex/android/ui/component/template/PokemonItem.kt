package dk.cngroup.pokedex.android.ui.component.template

import android.content.res.Configuration
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.skydoves.landscapist.ImageOptions
import com.skydoves.landscapist.glide.GlideImage
import dk.cngroup.pokedex.android.ui.theme.PokedexTheme
import dk.cngroup.pokedex.shared.data.model.Pokemon
import dk.cngroup.pokedex.sharedresources.Resources

@Composable
fun PokemonItem(
    pokemon: Pokemon,
    onClick: (pokemonId: Int) -> Unit
) {
    Box(
        modifier = Modifier
            .fillMaxSize()
            .clip(shape = RoundedCornerShape(12.dp))
            .background(
                color = MaterialTheme.colorScheme.primary.copy(alpha = 0.1f)
            )
            .clickable {
                onClick(pokemon.id)
            }
            .padding(8.dp)
    ) {
        Column {
            Text(
                text = pokemon.name,
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold
            )
            Text(
                modifier = Modifier
                    .background(
                        shape = RoundedCornerShape(6.dp),
                        color = MaterialTheme.colorScheme.primary.copy(alpha = 0.2f)
                    )
                    .padding(2.dp),
                fontSize = 12.sp,
                text = "#${pokemon.id}"
            )
        }
        GlideImage(
            modifier = Modifier
                .size(80.dp)
                .align(Alignment.BottomEnd),
            imageModel = { pokemon.imageUrl },
            imageOptions = ImageOptions(contentScale = ContentScale.Fit)
        )
    }
}

@Preview(name = "Light Mode", showBackground = true)
@Preview(name = "Dark Mode", uiMode = Configuration.UI_MODE_NIGHT_YES, showBackground = true)
@Composable
private fun PokemonItemPreview() {
    Resources.appContext = LocalContext.current
    PokedexTheme {
        PokemonItem(
            pokemon = Pokemon(
                id = 1,
                name = "Bulbasaur",
                imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
            ),
            onClick = {}
        )
    }
}
