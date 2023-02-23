package dk.cngroup.pokedex.shared.platform

import kotlinx.coroutines.CoroutineScope

expect abstract class BaseViewModel() {
    val scope: CoroutineScope
}
