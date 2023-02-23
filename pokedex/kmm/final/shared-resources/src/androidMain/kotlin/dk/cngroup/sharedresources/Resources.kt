package dk.cngroup.sharedresources

import android.content.Context
import dev.icerock.moko.graphics.Color
import dev.icerock.moko.resources.ColorResource
import dev.icerock.moko.resources.PluralsResource
import dev.icerock.moko.resources.StringResource
import dev.icerock.moko.resources.desc.PluralFormatted
import dev.icerock.moko.resources.desc.Resource
import dev.icerock.moko.resources.desc.ResourceFormatted
import dev.icerock.moko.resources.desc.StringDesc
import dev.icerock.moko.resources.getColor

actual object Resources {
    lateinit var appContext: Context

    actual var localCode: String?
        get() = StringDesc.localeType.systemLocale?.language
        set(value) {
            StringDesc.localeType = if (value != null)
                StringDesc.LocaleType.Custom(locale = value)
            else
                StringDesc.LocaleType.System
        }

    internal actual fun getString(resId: StringResource): String {
        return StringDesc.Resource(resId).toString(appContext)
    }

    internal actual fun getFormattedString(resId: StringResource, args: List<Any>): String {
        return StringDesc.ResourceFormatted(resId, args).toString(appContext)
    }

    internal actual fun getFormattedPlural(resId: PluralsResource, quantity: Int): String {
        return StringDesc.PluralFormatted(resId, quantity, quantity).toString(appContext)
    }

    internal actual fun getColor(resId: ColorResource): Color {
        return resId.getColor(appContext)
    }
}