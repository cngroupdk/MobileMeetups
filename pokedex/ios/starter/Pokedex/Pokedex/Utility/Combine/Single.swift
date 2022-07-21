import Combine

/// A publisher that publishes the first element of a stream, then finishes.
public typealias Single<Output, Failure> = Publishers.First<
    AnyPublisher<Output, Failure>
> where Failure: Error

/// A publisher that publishes the first element of a stream, then finishes.
/// Publisher don't publishes `Error`, instead of the Error is wrapped into the element.
/// A value that represents either a success or a failure, including an associated value in each case.
public typealias SingleResult<Output, Failure> = Single<
    Result<Output, Failure>, Never
> where Failure: Error

extension Publisher {
    public func asSingle() -> Single<Output, Failure> {
        return eraseToAnyPublisher().first()
    }
}
