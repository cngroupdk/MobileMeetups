import SwiftUI

extension View {
    // TODO: implement some modifiers
  func leadingAligned() -> some View {
      self
  }

  func trailingAligned() -> some View {
      self
  }

  func eraseToAnyView() -> AnyView {
    AnyView(self)
  }

  @ViewBuilder
  public func `if`<Content: View>(
    _ condition: Bool,
    content: (Self) -> Content
  ) -> some View {
    if condition {
      content(self)
    } else {
      self
    }
  }

  @ViewBuilder
  public func `if`<TrueContent: View, FalseContent: View>(
    _ condition: Bool,
    content: (Self) -> TrueContent,
    else elseContent: (Self) -> FalseContent
  ) -> some View {
    if condition {
      content(self)
    } else {
      elseContent(self)
    }
  }

  @ViewBuilder
  public func `ifLet`<Content: View, Wrapped>(
    _ optional: Wrapped?,
    content: (Self, Wrapped) -> Content
  ) -> some View {
    if let value = optional {
      content(self, value)
    } else {
      self
    }
  }

  @ViewBuilder
  public func `ifLet`<TrueContent: View, FalseContent: View, Wrapped>(
    _ optional: Wrapped?,
    content: (Self, Wrapped) -> TrueContent,
    else elseContent: (Self) -> FalseContent
  ) -> some View {
    if let value = optional {
      content(self, value)
    } else {
      elseContent(self)
    }
  }
}
