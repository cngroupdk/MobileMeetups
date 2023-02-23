package dk.cngroup.pokedex.android

import android.app.Application
import dk.cngroup.sharedresources.Resources

class PokedexApp : Application() {
    override fun onCreate() {
        super.onCreate()
        Resources.appContext = applicationContext
    }
}
