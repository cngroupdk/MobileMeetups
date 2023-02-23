package dk.cngroup.pokedex.android

import android.app.Application
import dk.cngroup.pokedex.shared.platform.initKoin
import dk.cngroup.pokedex.shared.presentation.viewModel.PokemonListViewModel
import dk.cngroup.sharedresources.Resources
import org.koin.androidx.viewmodel.dsl.viewModelOf
import org.koin.dsl.module

class PokedexApp : Application() {
    override fun onCreate() {
        super.onCreate()
        Resources.appContext = applicationContext
        initKoin(
            viewModelsModule = module {
                viewModelOf(::PokemonListViewModel)
            }
        )
    }
}
