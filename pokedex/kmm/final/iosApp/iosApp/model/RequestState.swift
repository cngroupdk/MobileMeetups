import Combine

public enum RequestState<T> {
    case notAsked
    case loading(last: T?)
    case success(T)
    case failure(Error)
}

extension RequestState {
    public var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }

    public var isLoadedSuccessfully: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }

    public var data: T? {
        switch self {
        case let .loading(data):
            return data

        case let .success(data):
            return data

        default: return nil
        }
    }

    public var error: Error? {
        switch self {
        case let .failure(error):
            return error

        default:
            return nil
        }
    }

    public func map<V>(_ transform: (T) -> V) -> RequestState<V> {
        switch self {
        case .notAsked:
            return .notAsked

        case let .loading(last: data):
            return .loading(last: data.map(transform))

        case let .success(value):
            return .success(transform(value))

        case let .failure(error):
            return .failure(error)
        }
    }
}

extension RequestState: Equatable where T: Equatable {
    public static func == (lhs: RequestState<T>, rhs: RequestState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.notAsked, .notAsked):
            return true

        case let (.loading(lhsV), .loading(rhsV)):
            return lhsV == rhsV

        case let (.success(lhsV), .success(rhsV)):
            return lhsV == rhsV

        case let (.failure(lhsE), .failure(rhsE)):
            return lhsE.localizedDescription == rhsE.localizedDescription

        default:
            return false
        }
    }
}
