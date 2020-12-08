import UIKit

extension UIViewController {

  /// Adds the given view controller as a child of the reciever and applies the given constraints to the child's view.
  ///
  /// - Parameter child: The view controller to add as a child.
  /// - Parameter containerView: The view to add the child's view to. If `nil` the receivers `view` is used.
  /// - Parameter constraints: The auto layout constraints to apply to the child's view.
  public func addChild(_ child: UIViewController, containerView: UIView? = nil, constraints: [Constraint]) {
    addChild(child)
    (containerView ?? view).addSubview(child.view, constraints: constraints)
    child.didMove(toParent: self)
  }

  /// Adds the given view controller as a child of the reciever and applies the given constraints to the child's view.
  ///
  /// - Parameter child: The view controller to add as a child.
  /// - Parameter containerView: The view to add the child's view to. If `nil` the receivers `view` is used.
  /// - Parameter constraints: The auto layout constraints to apply to the child's view.
  public func addChild(_ child: UIViewController, containerView: UIView? = nil, @ConstraintsBuilder constraints: () -> [Constraint]) {
    addChild(child, containerView: containerView, constraints: constraints())
  }

}
