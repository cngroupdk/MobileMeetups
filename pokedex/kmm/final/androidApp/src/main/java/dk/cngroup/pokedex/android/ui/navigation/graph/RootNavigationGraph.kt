package dk.cngroup.pokedex.android.ui.navigation.graph

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
import dk.cngroup.pokedex.android.ui.screen.PokemonDetailScreen
import dk.cngroup.pokedex.android.ui.screen.PokemonListScreen
import org.koin.androidx.compose.getViewModel
import org.koin.core.parameter.parametersOf

@Composable
fun RootNavigationGraph(
    navController: NavHostController
) {
    NavHost(
        navController = navController,
        route = Graph.ROOT,
        startDestination = RootNavigationScreen.PokemonList.route
    ) {
        composable(route = RootNavigationScreen.PokemonList.route) {
            PokemonListScreen(
                navigateToPokemonDetail = {
                    navController.navigate(
                        RootNavigationScreen.PokemonDetail.route
                            .replace(
                                "{${RootNavigationScreen.Parameter.POKEMON_ID}}",
                                it.toString()
                            )
                    )
                }
            )
        }

        composable(
            route = RootNavigationScreen.PokemonDetail.route,
            arguments = listOf(
                navArgument(RootNavigationScreen.Parameter.POKEMON_ID) { NavType.StringType }
            )
        ) {
            it.arguments?.getString(RootNavigationScreen.Parameter.POKEMON_ID)?.let { pokemonId ->
                PokemonDetailScreen(
                    viewModel = getViewModel { parametersOf(pokemonId.toInt()) }
                )
            }
        }
    }
}

sealed class RootNavigationScreen(val route: String) {
    object Parameter {
        const val POKEMON_ID = "pokemonId"
    }

    object PokemonList : RootNavigationScreen("pokemonList")
    object PokemonDetail : RootNavigationScreen("pokemonDetail/{${Parameter.POKEMON_ID}}")
}
