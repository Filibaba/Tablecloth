import UIKit

extension Array where Element == Constraint {

  /// Activates an array of `Constraint`s.
  ///
  /// - Parameter child: The view to create constraints for.
  /// - Parameter otherView: The view to create constraints against.
  public func activate(_ child: UIView, otherView: UIView) {
    for constraint in self {
      let layoutConstraint = constraint.constraint(child, otherView, constraint.constant, constraint.multiplier)
      layoutConstraint.isActive = true
      if let priority = constraint.priority {
        layoutConstraint.priority = priority
      }
    }
  }

  /// A list of constraints that constrain a view to another view's edge anchors.
  public static var toFrame: [Constraint] {
    [
      equal(\.topAnchor),
      equal(\.leadingAnchor),
      equal(\.bottomAnchor),
      equal(\.trailingAnchor),
    ]
  }

  /// Creates a list of constraints that constrains a view to another view's edge anchors.
  ///
  /// - Parameter insets: Insets the view by the given amount.
  ///
  /// - Returns: A list of constraints that constrain a view to another view's edge anchors.
  public static func toFrame(insets: NSDirectionalEdgeInsets = .zero) -> [Constraint] {
    [
      equal(\.topAnchor).constant(insets.top),
      equal(\.leadingAnchor).constant(insets.leading),
      equal(\.bottomAnchor).constant(insets.bottom),
      equal(\.trailingAnchor).constant(insets.trailing),
    ]
  }

  /// Constraints that constrain the view to its super view's layout margins.
  public static var toLayoutMargins: [Constraint] {
    [
      equal(\.topAnchor, \.layoutMarginsGuide.topAnchor),
      equal(\.trailingAnchor, \.layoutMarginsGuide.trailingAnchor),
      equal(\.bottomAnchor, \.layoutMarginsGuide.bottomAnchor),
      equal(\.leadingAnchor, \.layoutMarginsGuide.leadingAnchor),
    ]
  }

  /// Creates a list of constraints that constrain the view to a scroll view's content layout guide.
  ///
  /// - Parameter scrollView: The scroll view to constrain to.
  ///
  /// - Returns: A list of constraints.
  public static func toContentLayoutGuides(of scrollView: UIScrollView) -> [Constraint] {
    [
      equal(\.topAnchor, \.contentLayoutGuide.topAnchor, otherView: scrollView),
      equal(\.bottomAnchor, \.contentLayoutGuide.bottomAnchor, otherView: scrollView),
      equal(\.leadingAnchor, \.contentLayoutGuide.leadingAnchor, otherView: scrollView),
      equal(\.trailingAnchor, \.contentLayoutGuide.trailingAnchor, otherView: scrollView)
    ]
  }

  /// Creates a list of constraints that constrain the view to a scroll view's frame layout guide.
  ///
  /// - Parameter scrollView: The scroll view to constrain to.
  ///
  /// - Returns: A list of constraints.
  public static func toFrameLayoutGuides(of scrollView: UIScrollView) -> [Constraint] {
    [
      equal(\.topAnchor, \.frameLayoutGuide.topAnchor, otherView: scrollView),
      equal(\.bottomAnchor, \.frameLayoutGuide.bottomAnchor, otherView: scrollView),
      equal(\.leadingAnchor, \.frameLayoutGuide.leadingAnchor, otherView: scrollView),
      equal(\.trailingAnchor, \.frameLayoutGuide.trailingAnchor, otherView: scrollView),
    ]
  }
}

extension Array where Element == NSLayoutConstraint {

  /// Activates all of the constraints in the array.
  public func activate() {
    forEach { $0.isActive = true }
  }

}
