import SwiftUI

extension Binding where Value: Equatable {
    public func removeDuplicates() -> Self {
        return .init(
            get: { self.wrappedValue },
            set: { newValue, transaction in
                guard self.wrappedValue != newValue else { return }
                self.transaction(transaction).wrappedValue = newValue
            }
        )
    }
}

extension Binding {
    public func map<T>(
        get: @escaping (Value) -> T?,
        set: @escaping (T?) -> Value
    ) -> Binding<T?> {
        Binding<T?>(
            get: {
                get(wrappedValue)
            },
            set: {
                wrappedValue = set($0)
            }
        )
    }
}
