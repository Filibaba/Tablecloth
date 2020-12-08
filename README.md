# Tablecloth

A tiny little Auto Layout "DSL" library based on [Auto Layout with Key Paths](https://talk.objc.io/episodes/S01E75-auto-layout-with-key-paths)
by [Swift Talk](https://talk.objc.io).

## Usage

Tablecloth wraps the creation of `NSLayoutConstraint`s in a custom `Constraint` type.

The following snippet adds a view `imageView` to `view` and pins it to `view`'s leading layout margin anchor, makes them the same
height and centers the `imageView` vertically.

```swift
view.addSubview(imageView) {
  equal(\.leadingAnchor, \.layoutMarginsGuide.leadingAnchor)
  equal(\.heightAnchor)
  equal(\.centerYAnchor)
}
```

Or you can add a view and make it fill its superview.

```swift
view.addSubview(scrollView, constraints: .toFrame)
```

You can also constrain a view to other view's in the view hierarchy.

```swift
view.addSubview(label) {
  equal(\.leadingAnchor, \.trailingAnchor, of: firstLabel).constant(16)
}
```

The modifiers `.constant()` and `.multiplier()` and `.priority()` can be used to modify a constraint's properties.

## On Production Readyness

This code has been used with great success in [Plantry](https://www.plantry.app/) for years. It does however not contain everything
required to build any layout imaginable.  Sometimes you need to keep a reference to a constraint and this is not currently possible
and have to be handled the good ol' way.

## License

MIT
