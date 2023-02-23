package dk.cngroup.pokedex.shared.platform

expect class PlatformInfo() {
    val osName: String
    val osVersion: String

    val deviceModel: String
    val cpuType: String

    val screen: ScreenInfo
}

expect class ScreenInfo() {
    val width: Int
    val height: Int
    val density: Int
}

val PlatformInfo.deviceInfo: String
    get() {
        return "($osName; $osVersion; $deviceModel; ${screen.width}x${screen.height}@${screen.density}x; $cpuType)"
    }
