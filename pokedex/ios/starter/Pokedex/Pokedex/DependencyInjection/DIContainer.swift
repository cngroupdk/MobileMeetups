import Combine
import Foundation

// MARK: - DIContainer
typealias Store<State> = CurrentValueSubject<State, Never>

class DIContainer: ObservableObject {

    var services: Services

    init(services: Services? = nil) {
        self.services = services ?? Services()
    }

}

// MARK: - DIContainer: Services
extension DIContainer {

    struct Services {
        private var storage: [String: ServiceProtocol]

        init() {
            self.storage = [String: ServiceProtocol]()
        }

        init(elements: [ServiceProtocol]) {
            var dictionary = [String: ServiceProtocol]()
            for element in elements {
                dictionary[String(describing: type(of: element))] = element
            }
            self.storage = dictionary
        }

        subscript<T>(type: T.Type) -> T? where T: ServiceProtocol {
            get {
                let key = String(describing: type)
                return storage[key] as? T
            }
            set {
                let key = String(describing: type)
                storage[key] = newValue
            }
        }

        // returns service based on protocol, it is necessary for stubs (there is stored different service but also conforming to protocol)
        subscript<T>(type: T.Type) -> T? {
            let value = storage.first(where: { $1 is T })?.value
            return value as? T
        }
    }

}
