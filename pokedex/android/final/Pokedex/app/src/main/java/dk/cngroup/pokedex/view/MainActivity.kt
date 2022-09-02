package dk.cngroup.pokedex.view

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import dk.cngroup.pokedex.view.screen.PokemonDetailScreen
import dk.cngroup.pokedex.view.screen.PokemonListScreen
import dk.cngroup.pokedex.view.theme.PokedexTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            PokedexTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    val navController: NavHostController = rememberNavController()
                    NavHost(
                        navController = navController,
                        startDestination = NavigationRoutes.POKEMON_LIST
                    ) {
                        composable(
                            route = NavigationRoutes.POKEMON_LIST
                        ) {
                            PokemonListScreen(
                                navigateToPokemonDetail = { pokemonId ->
                                    navController.navigate(
                                        route = "${NavigationRoutes.POKEMON_DETAIL}/$pokemonId",
                                    )
                                }
                            )
                        }
                        composable(
                            route = "${NavigationRoutes.POKEMON_DETAIL}/{${NavigationParameters.POKEMON_ID}}",
                            arguments = listOf(
                                navArgument(NavigationParameters.POKEMON_ID) { NavType.StringType },
                            )
                        ) {
                            PokemonDetailScreen(
                                pokemonId = it.arguments?.getString(NavigationParameters.POKEMON_ID)?.toInt() ?: 0,
                                viewModel = viewModel()
                            )
                        }
                    }
                }
            }
        }
    }
}

object NavigationRoutes {
    const val POKEMON_LIST = "pokemonList"
    const val POKEMON_DETAIL = "pokemonDetail"
}

object NavigationParameters {
    const val POKEMON_ID = "pokemonId"
}