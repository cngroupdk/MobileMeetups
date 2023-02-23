package dk.cngroup.pokedex.shared.platform

import platform.Foundation.NSLog

internal actual class PlatformLogger {

    actual fun debug(tag: String?, message: String) {
        val formattedTag = if (tag != null) "$tag | " else ""
        NSLog("D: $formattedTag$message")
    }

    actual fun warn(tag: String?, message: String) {
        val formattedTag = if (tag != null) "$tag | " else ""
        NSLog("W: $tag | $message")
    }

    actual fun error(tag: String?, message: String) {
        val formattedTag = if (tag != null) "$tag | " else ""
        NSLog("E: $tag | $message")
    }
}
