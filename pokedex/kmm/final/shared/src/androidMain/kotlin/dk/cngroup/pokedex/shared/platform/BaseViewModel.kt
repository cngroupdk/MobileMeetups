package dk.cngroup.pokedex.shared.platform

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.CoroutineScope

actual abstract class BaseViewModel : ViewModel() {
    actual val scope: CoroutineScope
        get() = viewModelScope
}
