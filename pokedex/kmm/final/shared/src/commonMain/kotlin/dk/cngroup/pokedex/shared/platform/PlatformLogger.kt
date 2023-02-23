package dk.cngroup.pokedex.shared.platform

internal expect class PlatformLogger() {

    fun debug(tag: String?, message: String)

    fun warn(tag: String?, message: String)

    fun error(tag: String?, message: String)
}

object Logger {
    private val logger = PlatformLogger()

    fun d(message: String) = d(null, message)
    fun d(tag: String?, message: String) {
        logger.debug(tag, message)
    }

    fun w(message: String) = w(null, message)
    fun w(tag: String?, message: String) {
        logger.warn(tag, message)
    }

    fun e(message: String) = e(null, message)
    fun e(tag: String?, message: String) {
        logger.error(tag, message)
    }
}
