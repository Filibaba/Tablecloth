import UIKit

extension UIView {

  /// Add a subview together with a number of constraints to the receiver.
  ///
  /// - Parameter child: The new child view to add.
  /// - Parameter constraints: An array of `Constraints` to apply to the inserted view and the reciever.
  public func addSubview(_ child: UIView, constraints: [Constraint]) {
    addSubview(child)
    child.translatesAutoresizingMaskIntoConstraints = false
    constraints.activate(child, otherView: self)
  }

  /// Add a subview together with a number of constraints to the receiver.
  ///
  /// - Parameter child: The new child view to add.
  /// - Parameter constraints: An array of `Constraints` to apply to the inserted view and the reciever.
  public func addSubview(_ child: UIView, @ConstraintsBuilder constraints: () -> [Constraint]) {
    addSubview(child)
    child.translatesAutoresizingMaskIntoConstraints = false
    constraints().activate(child, otherView: self)
  }

  /// Insert the given view above the specified subview.
  ///
  /// - Parameter child: The view to insert.
  /// - Parameter subview: The sibling view that will be behind the inserted view.
  /// - Parameter constraints: An array of `Constraints` to apply to the inserted view and the reciever.
  public func insertSubview(_ child: UIView, aboveSubview subview: UIView, constraints: [Constraint]) {
    insertSubview(child, aboveSubview: subview)
    child.translatesAutoresizingMaskIntoConstraints = false
    constraints.activate(child, otherView: self)
  }

  /// Insert the given view above the specified subview.
  ///
  /// - Parameter child: The view to insert.
  /// - Parameter subview: The sibling view that will be above the inserted view.
  /// - Parameter constraints: An array of `Constraints` to apply to the inserted view and the reciever.
  public func insertSubview(_ child: UIView, aboveSubview subview: UIView, @ConstraintsBuilder constraints: () -> [Constraint]) {
    insertSubview(child, aboveSubview: subview)
    child.translatesAutoresizingMaskIntoConstraints = false
    constraints().activate(child, otherView: self)
  }

  /// Insert the given view below the specified subview.
  ///
  /// - Parameter child: The view to insert.
  /// - Parameter subview: The sibling view that will be behind the inserted view.
  /// - Parameter constraints: An array of `Constraints` to apply to the inserted view and the reciever.
  public func insertSubview(_ child: UIView, belowSubview subview: UIView, constraints: [Constraint]) {
    insertSubview(child, belowSubview: subview)
    child.translatesAutoresizingMaskIntoConstraints = false
    constraints.activate(child, otherView: self)
  }

  /// Insert the given view below the specified subview.
  ///
  /// - Parameter child: The view to insert.
  /// - Parameter subview: The sibling view that will be behind the inserted view.
  /// - Parameter constraints: An array of `Constraints` to apply to the inserted view and the reciever.
  public func insertSubview(_ child: UIView, belowSubview subview: UIView, @ConstraintsBuilder constraints: () -> [Constraint]) {
    insertSubview(child, belowSubview: subview)
    child.translatesAutoresizingMaskIntoConstraints = false
    constraints().activate(child, otherView: self)
  }

  /// Insert the given view below the specified subview.
  ///
  /// - Parameter child: The view to insert.
  /// - Parameter index: The index in the array of the subviews property at which to insert the view. Subview indices
  ///     start at 0 and cannot be greater than the number of subviews.
  /// - Parameter constraints: An array of `Constraints` to apply to the inserted view and the reciever.
  public func insertSubview(_ child: UIView, at index: Int, constraints: [Constraint]) {
    insertSubview(child, at: index)
    child.translatesAutoresizingMaskIntoConstraints = false
    constraints.activate(child, otherView: self)
  }

  /// Insert the given view below the specified subview.
  ///
  /// - Parameter child: The view to insert.
  /// - Parameter index: The index in the array of the subviews property at which to insert the view. Subview indices
  ///     start at 0 and cannot be greater than the number of subviews.
  /// - Parameter constraints: An array of `Constraints` to apply to the inserted view and the reciever.
  public func insertSubview(_ child: UIView, at index: Int, @ConstraintsBuilder constraints: () -> [Constraint]) {
    insertSubview(child, at: index)
    child.translatesAutoresizingMaskIntoConstraints = false
    constraints().activate(child, otherView: self)
  }

  /// Enables auto layout for the reciever and returns itself.
  ///
  /// - Returns: The reciever.
  public func withAutoLayoutEnabled() -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }

  /// Configures a set of constraints on the reciever.
  ///
  /// Useful when you want to configure constraints on a view that you're not adding to the view hierarchy. Most
  /// commonly a collection view cell's `contentView` for example. That is why this method does not enable auto layout
  /// on the reciever by default.
  ///
  /// If the reciever does not have a super view yet the constraining view will be itself. Thusly this method can also
  /// be used to, for example, make a view square by calling this method _before_ adding the child to the view
  /// hierarchy.
  ///
  ///     let imageView = UIImageView(image: myImage)
  ///     imageView.configureConstraints {
  ///       .equal(\.heightAnchor, \.widthAnchor)
  ///     }
  ///
  /// - Parameter enableAutoLayout: Set to `true` to disable `translatesAutoresizingMaskIntoConstraints` on the
  ///     reciever.
  /// - Parameter constraints: An array of `Constraints` to apply to the inserted view and the reciever.
  public func configureConstraints(enableAutoLayout: Bool = false, @ConstraintsBuilder _ constraints: () -> [Constraint]) {
    let otherView = superview ?? self
    if enableAutoLayout {
      translatesAutoresizingMaskIntoConstraints = false
    }
    constraints().activate(self, otherView: otherView)
  }

}
