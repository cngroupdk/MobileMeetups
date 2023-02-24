package dk.cngroup.pokedex.android.ui.screen

import android.content.res.Configuration
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import dk.cngroup.pokedex.android.ui.component.molecule.PokedexTopAppBar
import dk.cngroup.pokedex.android.ui.component.template.PokemonItem
import dk.cngroup.pokedex.android.ui.theme.PokedexTheme
import dk.cngroup.pokedex.shared.data.model.Pokemon
import dk.cngroup.pokedex.shared.presentation.viewModel.PokemonListViewModel
import dk.cngroup.pokedex.shared.service.MockPokedexRepository
import dk.cngroup.pokedex.sharedresources.MR
import dk.cngroup.pokedex.sharedresources.Resources
import dk.cngroup.pokedex.sharedresources.localized
import kotlinx.collections.immutable.ImmutableList
import org.koin.androidx.compose.getViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PokemonListScreen(
    viewModel: PokemonListViewModel = getViewModel(),
    navigateToPokemonDetail: (pokemonId: Int) -> Unit
) {
    val pokemonList: ImmutableList<Pokemon> = viewModel.pokemonListFlow.collectAsState().value
    val searchQuery: String = viewModel.searchQueryFlow.collectAsState(initial = "").value

    Scaffold(
        topBar = { PokemonListTopBar() }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .padding(innerPadding)
                .padding(horizontal = 12.dp)
        ) {
            PokemonListSearchBar(
                modifier = Modifier.padding(top = 8.dp),
                value = searchQuery,
                onValueChange = { viewModel.searchPokemon(it) }
            )

            PokemonGrid(
                pokemonList = pokemonList,
                onSelect = { navigateToPokemonDetail(it.id) }
            )
        }
    }
}

@Composable
private fun PokemonListTopBar() {
    PokedexTopAppBar(
        title = { Text(text = MR.strings.pokemonList_pokedex.localized(), style = MaterialTheme.typography.headlineMedium) }
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun PokemonListSearchBar(
    modifier: Modifier = Modifier,
    value: String,
    onValueChange: (String) -> Unit
) {
    val focusManager = LocalFocusManager.current
    TextField(
        modifier = modifier.fillMaxWidth(),
        value = value,
        onValueChange = onValueChange,
        placeholder = {
            Text(text = MR.strings.pokemonList_lookForPokemon.localized())
        },
        keyboardOptions = KeyboardOptions.Default.copy(
            capitalization = KeyboardCapitalization.None,
            autoCorrect = false,
            keyboardType = KeyboardType.Text,
            imeAction = ImeAction.Search
        ),
        keyboardActions = KeyboardActions(onSearch = { focusManager.clearFocus() }),
        singleLine = true
    )
}

@Composable
private fun PokemonGrid(
    modifier: Modifier = Modifier,
    pokemonList: ImmutableList<Pokemon>,
    onSelect: (Pokemon) -> Unit
) {
    LazyVerticalGrid(
        columns = GridCells.Fixed(2),
        modifier = modifier.fillMaxSize(),
        contentPadding = PaddingValues(vertical = 8.dp),
        verticalArrangement = Arrangement.spacedBy(10.dp),
        horizontalArrangement = Arrangement.spacedBy(10.dp)
    ) {
        items(
            items = pokemonList,
            key = { it.id }
        ) { pokemon ->
            PokemonItem(
                pokemon = pokemon,
                onClick = { onSelect(pokemon) }
            )
        }
    }
}

@Preview(name = "Light Mode", showBackground = true)
@Preview(name = "Dark Mode", uiMode = Configuration.UI_MODE_NIGHT_YES, showBackground = true)
@Composable
private fun PokemonListScreenPreview() {
    Resources.appContext = LocalContext.current
    PokedexTheme {
        PokemonListScreen(
            viewModel = PokemonListViewModel(repository = MockPokedexRepository()),
            navigateToPokemonDetail = {}
        )
    }
}
