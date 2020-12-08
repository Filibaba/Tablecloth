// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Tablecloth",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(name: "Tablecloth", targets: ["Tablecloth"]),
  ],
  dependencies: [],
  targets: [
    .target(name: "Tablecloth", dependencies: []),
    .testTarget(name: "TableclothTests", dependencies: ["Tablecloth"]),
  ]
)
