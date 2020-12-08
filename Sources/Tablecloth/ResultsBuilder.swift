import Foundation

@_functionBuilder
public struct ConstraintsBuilder {
  public static func buildBlock(_ items: Constraint...) -> [Constraint] {
    return items
  }
}
