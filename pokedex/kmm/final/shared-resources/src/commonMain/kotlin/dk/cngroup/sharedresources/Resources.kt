package dk.cngroup.sharedresources

import dev.icerock.moko.graphics.Color
import dev.icerock.moko.resources.ColorResource
import dev.icerock.moko.resources.PluralsResource
import dev.icerock.moko.resources.StringResource

expect object Resources {
    var localCode: String?

    internal fun getString(resId: StringResource): String
    internal fun getFormattedString(resId: StringResource, args: List<Any>): String
    internal fun getFormattedPlural(resId: PluralsResource, quantity: Int): String

    internal fun getColor(resId: ColorResource): Color
}

fun StringResource.localized(): String = Resources.getString(this)
fun StringResource.localized(args: List<Any>) = Resources.getFormattedString(resId = this, args = args)
fun PluralsResource.localized(quantity: Int) = Resources.getFormattedPlural(resId = this, quantity = quantity)
fun ColorResource.toColor(): Color = Resources.getColor(resId = this)