import Foundation
import SharedKit

extension RequestState {
    enum TransformationError: Swift.Error {
        case identifiable(String)
        case unknown
    }
}

extension RequestState {
    static func create<Element>(
        from state: SharedKit.RequestState<Element>
    ) -> RequestState<Element> {
        if state is RequestStateNotAsked {
            return .notAsked
        } else if let loadingState = state as? RequestStateLoading<Element> {
            return .loading(last: loadingState.last)
        } else if let successState = state as? RequestStateSuccess<Element>,
            let data = successState.data
        {
            return .success(data)
        } else if let failureState = state as? RequestStateFailure {
            if let message = failureState.error.message {
                return .failure(Self.TransformationError.identifiable(message))
            } else {
                return .failure(Self.TransformationError.unknown)
            }
        } else {
            return .failure(Self.TransformationError.unknown)
        }
    }

    static func create<Element>(
        from result: Swift.Result<SharedKit.RequestState<Element>, Swift.Error>
    ) -> RequestState<Element> {
        switch result {
        case .success(let state):
            return Self.create(from: state)
        case .failure(let error):
            return .failure(Self.TransformationError.identifiable(error.localizedDescription))
        }
    }
}

extension RequestState where T == NSArray {
    func mapToSwiftArray<Element>() -> RequestState<[Element]> {
        switch self {
        case .notAsked: return .notAsked
        case .loading(let last): return .loading(last: last?.compactMap { $0 as? Element })
        case .success(let data): return .success(data.compactMap { $0 as? Element })
        case .failure(let error): return .failure(error)
        }
    }
}

extension RequestState where T == NSDictionary {
    func mapToSwiftDictionary<Key, Element>() -> RequestState<[Key: Element]> {
        switch self {
        case .notAsked: return .notAsked
        case .loading(let last):
            return .loading(
                last: last?.reduce(into: [Key: Element]()) { (partialResult, arg1) in
                    if let newKey = arg1.key as? Key,
                        let newValue = arg1.value as? Element
                    {
                        partialResult[newKey] = newValue
                    }
                }
            )
        case .success(let data):
            return .success(
                data.reduce(into: [Key: Element]()) { (partialResult, arg1) in
                    if let newKey = arg1.key as? Key,
                        let newValue = arg1.value as? Element
                    {
                        partialResult[newKey] = newValue
                    }
                }
            )
        case .failure(let error): return .failure(error)
        }
    }
}
