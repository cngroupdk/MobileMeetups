package dk.cngroup.pokedex.shared.platform

import kotlinx.cinterop.alloc
import kotlinx.cinterop.memScoped
import kotlinx.cinterop.ptr
import platform.CoreGraphics.CGRectGetHeight
import platform.CoreGraphics.CGRectGetWidth
import platform.Foundation.NSString
import platform.Foundation.NSUTF8StringEncoding
import platform.Foundation.stringWithCString
import platform.UIKit.UIDevice
import platform.UIKit.UIScreen
import platform.UIKit.UIUserInterfaceIdiomPad
import platform.UIKit.UIUserInterfaceIdiomPhone
import platform.posix.uname
import platform.posix.utsname

actual class PlatformInfo actual constructor() {
    actual val osName = when (UIDevice.currentDevice.userInterfaceIdiom) {
        UIUserInterfaceIdiomPhone -> "iOS"
        UIUserInterfaceIdiomPad -> "iPadOS"
        else -> kotlin.native.Platform.osFamily.name
    }

    actual val osVersion = UIDevice.currentDevice.systemVersion

    actual val deviceModel: String
        get() {
            memScoped {
                val systemInfo: utsname = alloc()
                uname(systemInfo.ptr)
                return NSString.stringWithCString(systemInfo.machine, encoding = NSUTF8StringEncoding)
                    ?: "---"
            }
        }

    actual val cpuType = kotlin.native.Platform.cpuArchitecture.name

    actual val screen: ScreenInfo = ScreenInfo()
}

actual class ScreenInfo actual constructor() {
    actual val width = CGRectGetWidth(UIScreen.mainScreen.nativeBounds).toInt()
    actual val height = CGRectGetHeight(UIScreen.mainScreen.nativeBounds).toInt()
    actual val density = UIScreen.mainScreen.scale.toInt()
}
