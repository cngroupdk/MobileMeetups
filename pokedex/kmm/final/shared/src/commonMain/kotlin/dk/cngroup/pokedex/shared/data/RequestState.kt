package dk.cngroup.pokedex.shared.data

sealed class RequestState<T> {
    class NotAsked<T> : RequestState<T>()
    data class Loading<T>(val last: T?) : RequestState<T>()
    data class Success<T>(val data: T) : RequestState<T>()
    data class Failure<T>(val error: Throwable) : RequestState<T>()

    val isLoading: Boolean
        get() = this is Loading

    val isLoadedSuccessfully: Boolean
        get() = this is Success

    val associatedData: T?
        get() = when (this) {
            is Loading -> last as? T
            is Success -> data as? T
            else -> null
        }

    val associatedError: Throwable?
        get() = when (this) {
            is Failure -> error
            else -> null
        }

    fun<V> map(transform: (T) -> V): RequestState<V> = when (this) {
        is NotAsked -> NotAsked()
        is Loading -> Loading(last = if (last != null) transform(last) else null)
        is Success -> Success(data = transform(data))
        is Failure -> Failure(error = error)
    }
}
