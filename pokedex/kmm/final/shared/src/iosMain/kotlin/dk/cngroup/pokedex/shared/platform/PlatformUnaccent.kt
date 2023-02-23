package dk.cngroup.pokedex.shared.platform

import platform.Foundation.*

internal actual fun CharSequence.unaccent(): String {
    return (this as NSString).stringByFoldingWithOptions(
        options = NSDiacriticInsensitiveSearch,
        locale = NSLocale.currentLocale
    )
}
