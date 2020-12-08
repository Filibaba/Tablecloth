import UIKit

/// A `Constraint` wraps a function that creates a layout constraint between one or two views.
public struct Constraint {

  // MARK: Properties

  /// A function that creates a layout constraint.
  ///
  /// - Parameter view: The view to constrain.
  /// - Parameter otherView: The other view to constrain the `view` to.
  /// - Parameter constant: The constant offset for the constraint.
  /// - Parameter mulitplier: The multiplier constant for the constraint.
  ///
  /// - Returns: An `NSLayoutConstraint`.
  internal typealias Builder = (
    _ view: UIView, _ otherView: UIView, _ constant: CGFloat, _ multiplier: CGFloat
  ) -> NSLayoutConstraint

  /// The constraint builder.
  internal let constraint: Builder

  internal var postProcessor: ((NSLayoutConstraint) -> Void)?

  /// The constant to pass to the constraint builder.
  internal var constant: CGFloat = 0

  /// The multiplier to pass to the constraint builder.
  internal var multiplier: CGFloat = 1

  /// The priority of the generated layout constraint.
  internal var priority: UILayoutPriority?

  // MARK: Initialization

  /// Initializes a `Constraint`.
  ///
  /// - Parameter constraint: A `Builder` function that generates a constraint.
  ///
  /// - Returns: A new `NSLayoutConstraint` between the two views.
  internal init(_ constraint: @escaping Builder) {
    self.constraint = constraint
  }

  // MARK: Changing the Constraint's Properties

  /// Modifies the constraint's constant offset.
  ///
  /// - Parameter constant: The constant offset for the constraint.
  ///
  /// - Returns: A modified `Constraint`.
  public func constant(_ constant: CGFloat) -> Constraint {
    var copy = self
    copy.constant = constant
    return copy
  }

  /// Modifies the constraint's multiplier constant.
  ///
  /// - Parameter mulitplier: The multiplier constant for the constraint.
  ///
  /// - Returns: A modified `Constraint`.
  public func multiplier(_ multiplier: CGFloat) -> Constraint {
    var copy = self
    copy.multiplier = multiplier
    return copy
  }

  /// Modifies the constraint's layout priority.
  ///
  /// - Parameter priority: The priority of the generated layout constraint.
  ///
  /// - Returns: A modified `Constraint`.
  public func priority(_ priority: UILayoutPriority) -> Constraint {
    var copy = self
    copy.priority = priority
    return copy
  }

  public func with(_ closure: @escaping (NSLayoutConstraint) -> Void) -> Constraint {
    var copy = self
    copy.postProcessor = closure
    return coy
  }
}

// MARK: Creating Constraints

/// Generates an "equal" `Constraint` between two view's layout anchors.
///
/// This code will constraint `subview` to be equal to the width of `view` - 16 points.
///
///     view.addSubview(subview) {
///       equal(\.widthAnchor, constant: -16)
///     }
///
/// Or you can constrain the view to another view in the view hierarchy. This for example will make `subview`'s width
/// the same as `imageView`s height.
///
///     view.addSubview(subview) {
///       equal(\.widthAnchor, \.heightAnchor, of: imageView)
///     }
///
/// - Parameter from: A key path to the anchor to equate to on the other view.
/// - Parameter to: An optional keypath to the anchor to equate `keyPath` to. If `nil` `keyPath` will be used as the
///     target as well.
/// - Parameter otherView: The view to constrain the target to. Defaults to the view's parent.
///
/// - Returns: A `Constraint` that creates an equality constraint.
public func equal<Anchor>(
  _ from: KeyPath<UIView, Anchor>,
  _ to: KeyPath<UIView, Anchor>? = nil,
  of otherView: UIView? = nil
) -> Constraint where Anchor: NSLayoutDimension {
  .init { view, parent, constant, multiplier in
    let anchor = view[keyPath: from]
    let comparison = (otherView ?? parent)[keyPath: to ?? from]
    return anchor.constraint(equalTo: comparison, multiplier: multiplier, constant: constant)
  }
}

/// Generates an "equal" `Constraint` between two view's layout anchors.
///
/// This code will constraint `subview` to be equal to the width of `view` - 16 points.
///
///     view.addSubview(subview) {
///       equal(\.widthAnchor).constant(-16)
///     }
///
/// Or you can constrain the view to another view in the view hierarchy. This for example will make `subview`'s width
/// the same as `imageView`s height.
///
///     view.addSubview(subview) {
///       equal(\.widthAnchor, \.heightAnchor, of: imageView)
///     }
///
/// - Parameter from: A key path to the anchor to equate to on the other view.
/// - Parameter to: An optional keypath to the anchor to equate `keyPath` to. If `nil` `keyPath` will be used as the
///     target as well.
/// - Parameter otherView: The view to constrain the target to. Defaults to the view's parent.
///
/// - Returns: A `Constraint` that creates an equality constraint.
public func equal<Axis, Anchor>(
  _ from: KeyPath<UIView, Anchor>,
  _ to: KeyPath<UIView, Anchor>? = nil,
  of otherView: UIView? = nil
) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
  .init { view, parent, constant, _ in
    let anchor = view[keyPath: from]
    let comparison = (otherView ?? parent)[keyPath: to ?? from]
    return anchor.constraint(equalTo: comparison, constant: constant)
  }
}

/// Generates a "greater than or equal" `Constraint` between two view's layout anchors.
///
/// - Parameter from: A key path to the anchor to compare to on the other view.
/// - Parameter to: An optional keypath to the anchor to equate `keyPath` to. If `nil` `keyPath` will be used as the
///     target as well.
/// - Parameter otherView: The view to constrain the target to. Defaults to the view's parent.
///
/// - Returns: A `Constraint` that creates a greater than or equal constraint.
public func greaterThanOrEqual<Anchor>(
  _ from: KeyPath<UIView, Anchor>,
  _ to: KeyPath<UIView, Anchor>? = nil,
  of otherView: UIView? = nil
) -> Constraint where Anchor: NSLayoutDimension {
  .init { view, parent, constant, multiplier in
    let anchor = view[keyPath: from]
    let comparison = (otherView ?? parent)[keyPath: to ?? from]
    return anchor.constraint(greaterThanOrEqualTo: comparison, multiplier: multiplier, constant: constant)
  }
}

/// Generates a "greater than or equal" `Constraint` between two view's layout anchors.
///
/// - Parameter from: A key path to the anchor to compare to on the other view.
/// - Parameter to: An optional keypath to the anchor to equate `keyPath` to. If `nil` `keyPath` will be used as the
///     target as well.
/// - Parameter otherView: The view to constrain the target to. Defaults to the view's parent.
///
/// - Returns: A `Constraint` that creates a greater than or equal constraint.
public func greaterThanOrEqual<Axis, Anchor>(
  _ from: KeyPath<UIView, Anchor>,
  _ to: KeyPath<UIView, Anchor>? = nil,
  of otherView: UIView? = nil
) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
  .init { view, parent, constant, _ in
    let anchor = view[keyPath: from]
    let comparison = (otherView ?? parent)[keyPath: to ?? from]
    return anchor.constraint(greaterThanOrEqualTo: comparison, constant: constant)
  }
}

/// Generates a "less than or equal" `Constraint` between two view's layout anchors.
///
/// - Parameter from: A key path to the anchor to compare to on the other view.
/// - Parameter to: An optional keypath to the anchor to equate `keyPath` to. If `nil` `keyPath` will be used as the
///     target as well.
/// - Parameter otherView: The view to constrain the target to. Defaults to the view's parent.
///
/// - Returns: A `Constraint` that creates a less than or equal constraint.
public func lessThanOrEqual<Anchor>(
  _ from: KeyPath<UIView, Anchor>,
  _ to: KeyPath<UIView, Anchor>? = nil,
  of otherView: UIView? = nil
) -> Constraint where Anchor: NSLayoutDimension {
  .init { view, parent, constant, multiplier in
    let anchor = view[keyPath: from]
    let comparison = (otherView ?? parent)[keyPath: to ?? from]
    return anchor.constraint(lessThanOrEqualTo: comparison, multiplier: multiplier, constant: constant)
  }
}

/// Generates a "less than or equal" `Constraint` between two view's layout anchors.
///
/// - Parameter from: A key path to the anchor to compare to on the other view.
/// - Parameter to: An optional keypath to the anchor to equate `keyPath` to. If `nil` `keyPath` will be used as the
///     target as well.
/// - Parameter otherView: The view to constrain the target to. Defaults to the view's parent.
///
/// - Returns: A `Constraint` that creates a less than or equal constraint.
public func lessThanOrEqual<Axis, Anchor>(
  _ from: KeyPath<UIView, Anchor>,
  _ to: KeyPath<UIView, Anchor>? = nil,
  of otherView: UIView? = nil
) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
  .init { view, parent, constant, _ in
    let anchor = view[keyPath: from]
    let comparison = (otherView ?? parent)[keyPath: to ?? from]
    return anchor.constraint(lessThanOrEqualTo: comparison, constant: constant)
  }
}

/// Creates a constant `Constraint`.
///
/// - Parameter keyPath: The keypath to constrain to a constant size.
/// - Parameter constant: The constant value.
///
/// - Returns: A constant `Constraint`.
public func constant<Anchor>(
  _ keyPath: KeyPath<UIView, Anchor>,
  value constant: CGFloat
) -> Constraint where Anchor: NSLayoutDimension {
  .init { view, _, _constant, _ in
    guard _constant == 0 else {
      fatalError("""
          Constant constraint was created with a `.constant()` modifier, which has no effect on this constraint. This is
          considered a programmer error.
        """)
    }
    return view[keyPath: keyPath].constraint(equalToConstant: constant)
  }
}


// MARK: - Scroll View Affordances

/// Generates an "equal" `Constraint` between a view and a scroll view's layout guides.
///
/// - Parameter from: A key path to the anchor to equate to on the other view.
/// - Parameter to: An optional keypath to the anchor to equate `keyPath` to. If `nil` `keyPath` will be used as the
///     target as well.
/// - Parameter otherView: The view to constrain the target to. Defaults to the view's parent.
///
/// - Returns: A `Constraint` that creates an equality constraint.
public func equal<Axis, Anchor>(
  _ from: KeyPath<UIView, Anchor>,
  _ to: KeyPath<UIScrollView, Anchor>,
  otherView: UIScrollView
) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
  .init { view, parent, constant, _ in
    let anchor = view[keyPath: from]
    let comparison = otherView[keyPath: to]
    return anchor.constraint(equalTo: comparison, constant: constant)
  }
}
