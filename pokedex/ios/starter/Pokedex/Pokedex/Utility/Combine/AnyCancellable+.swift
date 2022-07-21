import Combine
import Foundation

extension Set where Element == AnyCancellable {

  public mutating func cancelAll() {
    self.forEach { $0.cancel() }
    self.removeAll()
  }

}
