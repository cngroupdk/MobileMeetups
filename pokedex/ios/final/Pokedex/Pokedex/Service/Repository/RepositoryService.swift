import Foundation

// MARK: - RepositoryServiceProtocol
protocol RepositoryServiceProtocol: ServiceProtocol {
}

// MARK: - RepositoryService
final class RepositoryService: RepositoryServiceProtocol {
}

// MARK: - Mock
#if DEBUG
    extension RepositoryServiceProtocol where Self == MockRepositoryService {
        static var mock: RepositoryServiceProtocol {
            MockRepositoryService()
        }
    }

    final class MockRepositoryService: RepositoryServiceProtocol {

    }
#endif
