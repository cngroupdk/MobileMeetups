package dk.cngroup.pokedex.shared

import dk.cngroup.pokedex.shared.platform.PlatformInfo
import dk.cngroup.pokedex.shared.platform.ioDispatcher
import dk.cngroup.pokedex.shared.presentation.viewModel.PokemonDetailViewModel
import dk.cngroup.pokedex.shared.presentation.viewModel.PokemonListViewModel
import dk.cngroup.pokedex.shared.service.PokedexRepository
import dk.cngroup.pokedex.shared.service.PokedexRepositoryImpl
import org.koin.core.KoinApplication
import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.core.module.dsl.factoryOf
import org.koin.dsl.module

private object Modules {
    val core = module {
        factory { PlatformInfo() }
    }

    val services = module {
        single {
            val pokedexRepository: PokedexRepository = PokedexRepositoryImpl(defaultDispatcher = ioDispatcher)
            pokedexRepository
        }
    }
    val viewModels = module {
        factoryOf(::PokemonListViewModel)
        factoryOf(::PokemonDetailViewModel)
    }
}

public fun initKoin(
    appModule: Module = module {},
    coreModule: Module = Modules.core,
    servicesModule: Module = Modules.services,
    viewModelsModule: Module = Modules.viewModels
): KoinApplication = startKoin {
    modules(
        appModule,
        coreModule,
        servicesModule,
        viewModelsModule
    )
}
