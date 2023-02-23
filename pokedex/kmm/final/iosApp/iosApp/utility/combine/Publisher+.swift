import Combine

extension Publisher where Self.Failure == Never {
    public func assignWeak<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root
    ) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] (value) in
            object?[keyPath: keyPath] = value
        }
    }
}

extension Publisher {
    public func sinkToResult(
        _ result: @escaping (Result<Output, Failure>) -> Void
    ) -> AnyCancellable {
        return sink(
            receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    result(.failure(error))
                default: break
                }
            },
            receiveValue: { value in
                result(.success(value))
            }
        )
    }
}
