import Foundation

struct Pokemon: Identifiable, Hashable {
    let id: Int
    let name: String
    let image: URL?
    let detail: URL?
}
