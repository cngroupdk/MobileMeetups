package dk.cngroup.pokedex.shared.platform

import kotlinx.cinterop.ObjCClass
import kotlinx.cinterop.getOriginalKotlinClass
import org.koin.core.Koin
import org.koin.core.KoinApplication
import org.koin.core.parameter.ParametersHolder

object KoinIOS {
    fun initialize(): KoinApplication = initKoin()
}

fun Koin.get(objCClass: ObjCClass, parameters: MutableList<Any?>?): Any {
    val kClazz = getOriginalKotlinClass(objCClass)!!
    val params = if (parameters != null) { { ParametersHolder(parameters) } } else null
    return get(kClazz, null, params)
}
