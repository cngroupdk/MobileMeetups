package dk.cngroup.pokedex.shared.platform

import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

internal actual val ioDispatcher: CoroutineDispatcher
    get() = Dispatchers.IO
