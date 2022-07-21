import Foundation

struct Pokemon: Identifiable, Hashable {
  let id: Int
  let name: String
  let imageUrl: URL?
  let detail: Pokemon.Detail?

  init(
    id: Int,
    name: String,
    imageUrl: URL? = nil,
    detail: Pokemon.Detail? = nil
  ) {
    self.id = id
    self.name = name
    self.imageUrl = imageUrl
    self.detail = detail
  }

  func updated(with detail: Pokemon.Detail) -> Pokemon {
    .init(
      id: self.id,
      name: self.name,
      imageUrl: self.imageUrl,
      detail: detail
    )
  }
}

// MARK: - Detail
extension Pokemon {
  struct Detail: Hashable {
    let type: String?
    let baseExperience: Int?
    let weight: Int?
    let height: Int?
    let hp: Int?
    let attack: Int?
  }
}
