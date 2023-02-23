import Foundation
import SharedKit

final class Koin {
    static let instance = Koin()

    private init() {}
    private var core: Koin_coreKoin?
    private(set) var isRunning: Bool = false

    static func start() {
        if instance.core == nil {
            let app = KoinIOS.shared.initialize()
            instance.core = app.koin
        }
        if instance.core == nil {
            fatalError("Can't initialize Koin.")
        } else {
            instance.isRunning = true
        }
    }

    func get<T: AnyObject>(parameters: [AnyObject]? = nil) -> T {
        guard let core = core else {
            fatalError("You should call `start()` before using \(#function)")
        }
        let params =
            (parameters != nil && !parameters!.isEmpty) ? NSMutableArray(array: parameters!) : nil
        guard let result = core.get(objCClass: T.self, parameters: params) as? T else {
            fatalError("Koin can't provide an instance of type: \(T.self)")
        }
        return result
    }
}
