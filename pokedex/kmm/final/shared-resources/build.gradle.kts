import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    alias(libs.plugins.kotlin.multiplatform)
    alias(libs.plugins.android.library)
    alias(libs.plugins.mokoResource.multiplatform)
}

kotlin {
    android {
        compilations.all {
            kotlinOptions {
                jvmTarget = libs.versions.jvmTarget.get()
            }
        }
    }

    val xcf = XCFramework()
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "SharedResources"
            xcf.add(this)
        }
    }

    sourceSets {
        val commonMain by getting {
            dependencies {
                api(libs.moko.resource.core)
            }
        }
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test"))
            }
        }
        val androidMain by getting {
            dependencies {
                api(libs.moko.resource.compose)
            }
        }
        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependsOn(commonMain)
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)
        }
    }
}

multiplatformResources {
    multiplatformResourcesPackage = "dk.cngroup.pokedex.sharedresources" // required
//    multiplatformResourcesClassName = "SharedResources" // optional, default MR
//    multiplatformResourcesVisibility = MRVisibility.Internal // optional, default Public
//    iosBaseLocalizationRegion = "en" // optional, default "en"
//    multiplatformResourcesSourceSet = "commonClientMain"  // optional, default "commonMain"
}

android {
    namespace = "dk.cngroup.pokedex.sharedresources"
    compileSdk = libs.versions.android.compileSdk.get().toInt()
    sourceSets.getByName("main").res.srcDir(File(buildDir, "generated/moko/androidMain/res"))
    defaultConfig {
        minSdk = libs.versions.android.minSdk.get().toInt()
        targetSdk = libs.versions.android.targetSdk.get().toInt()
    }
}
