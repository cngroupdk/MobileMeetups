package dk.cngroup.pokedex.sharedresources

import dev.icerock.moko.graphics.Color
import dev.icerock.moko.resources.ColorResource
import dev.icerock.moko.resources.PluralsResource
import dev.icerock.moko.resources.StringResource
import dev.icerock.moko.resources.desc.PluralFormatted
import dev.icerock.moko.resources.desc.Resource
import dev.icerock.moko.resources.desc.ResourceFormatted
import dev.icerock.moko.resources.desc.StringDesc
import dev.icerock.moko.resources.getColor
import platform.Foundation.languageCode
import platform.UIKit.UIScreen

actual object Resources {
    actual var localCode: String?
        get() = StringDesc.localeType.locale.languageCode()
        set(value) {
            StringDesc.localeType = if (value != null)
                StringDesc.LocaleType.Custom(locale = value)
            else
                StringDesc.LocaleType.System
        }

    internal actual fun getString(resId: StringResource): String {
        return StringDesc.Resource(resId).localized()
    }

    internal actual fun getFormattedString(resId: StringResource, args: List<Any>): String {
        return StringDesc.ResourceFormatted(resId, args).localized()
    }

    internal actual fun getFormattedPlural(resId: PluralsResource, quantity: Int): String {
        return StringDesc.PluralFormatted(resId, quantity, quantity).localized()
    }

    internal actual fun getColor(resId: ColorResource): Color {
        return resId.getColor(UIScreen.mainScreen.traitCollection.userInterfaceStyle)
    }
}