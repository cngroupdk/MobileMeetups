package dk.cngroup.pokedex.shared.platform

import android.content.res.Resources
import android.os.Build
import kotlin.math.round

actual class PlatformInfo actual constructor() {
    actual val osName = "Android"
    actual val osVersion = "${Build.VERSION.SDK_INT}"

    actual val deviceModel = "${Build.MANUFACTURER} ${Build.MODEL}"
    actual val cpuType = Build.SUPPORTED_ABIS?.firstOrNull() ?: "---"

    actual val screen: ScreenInfo = ScreenInfo()
}

actual class ScreenInfo actual constructor() {
    private val metrics = Resources.getSystem().displayMetrics

    actual val width = metrics.widthPixels
    actual val height = metrics.heightPixels
    actual val density = round(metrics.density).toInt()
}
