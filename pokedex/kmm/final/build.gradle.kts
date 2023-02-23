plugins {
    alias(libs.plugins.android.application) apply false
    alias(libs.plugins.kotlin.multiplatform) apply false
    alias(libs.plugins.kotlin.android) apply false
    alias(libs.plugins.android.library) apply false
    alias(libs.plugins.kotlinter) apply false
    alias(libs.plugins.kotlin.parcelize) apply false
    alias(libs.plugins.mokoResource.multiplatform) apply false
}

buildscript {
    repositories {
        gradlePluginPortal()
    }

    dependencies {
        classpath(libs.moko.resource.generator)
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        //maven("https://androidx.dev/storage/compose-compiler/repository/")
    }
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}