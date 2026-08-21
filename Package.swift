// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-set-ordered-primitives",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(
            name: "Set Ordered Primitive",
            targets: ["Set Ordered Primitive"]
        ),

        .library(
            name: "Set Ordered Primitives",
            targets: ["Set Ordered Primitives"]
        ),

    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-set-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-index-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-hash-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-hash-table-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-ownership-shared-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-buffer-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-buffer-linear-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-storage-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-memory-heap-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-memory-allocation-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-ordinal-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-tagged-primitives.git",
            branch: "main"
        ),

    ],
    targets: [

        .target(
            name: "Set Ordered Primitive",
            dependencies: [
                .product(name: "Set Primitive", package: "swift-set-primitives"),
                .product(name: "Hash Indexed Primitive", package: "swift-hash-table-primitives"),
                .product(name: "Hash Table Primitive", package: "swift-hash-table-primitives"),
                .product(name: "Hash Primitives", package: "swift-hash-primitives"),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared-primitives"
                ),
                .product(name: "Buffer Primitive", package: "swift-buffer-primitives"),
                .product(name: "Buffer Protocol Primitives", package: "swift-buffer-primitives"),
                .product(
                    name: "Buffer Linear Primitive",
                    package: "swift-buffer-linear-primitives"
                ),
                .product(name: "Storage Primitive", package: "swift-storage-primitives"),
                .product(
                    name: "Storage Contiguous Primitives",
                    package: "swift-storage-primitives"
                ),
                .product(name: "Store Protocol Primitives", package: "swift-storage-primitives"),
                .product(name: "Memory Heap Primitives", package: "swift-memory-heap-primitives"),
                .product(
                    name: "Memory Allocator Primitive",
                    package: "swift-memory-allocation-primitives"
                ),
                .product(name: "Index Primitives", package: "swift-index-primitives"),
            ]
        ),

        .target(
            name: "Set Ordered Primitives",
            dependencies: [
                "Set Ordered Primitive",
                .product(name: "Hash Indexed Primitive", package: "swift-hash-table-primitives"),
                .product(name: "Hash Table Primitive", package: "swift-hash-table-primitives"),
                .product(name: "Hash Primitives", package: "swift-hash-primitives"),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared-primitives"
                ),
                .product(name: "Buffer Primitive", package: "swift-buffer-primitives"),
                .product(name: "Buffer Protocol Primitives", package: "swift-buffer-primitives"),
                .product(
                    name: "Buffer Linear Primitive",
                    package: "swift-buffer-linear-primitives"
                ),
                .product(name: "Storage Primitive", package: "swift-storage-primitives"),
                .product(
                    name: "Storage Contiguous Primitives",
                    package: "swift-storage-primitives"
                ),
                .product(name: "Store Protocol Primitives", package: "swift-storage-primitives"),
                .product(name: "Memory Heap Primitives", package: "swift-memory-heap-primitives"),
                .product(
                    name: "Memory Allocator Primitive",
                    package: "swift-memory-allocation-primitives"
                ),
                .product(name: "Index Primitives", package: "swift-index-primitives"),
                .product(
                    name: "Ordinal Primitives Standard Library Integration",
                    package: "swift-ordinal-primitives"
                ),
            ]
        ),

        .testTarget(
            name: "Set Ordered Primitives Tests",
            dependencies: [
                "Set Ordered Primitives",
                .product(
                    name: "Hash Table Primitives Test Support",
                    package: "swift-hash-table-primitives"
                ),
                .product(
                    name: "Buffer Primitives Test Support",
                    package: "swift-buffer-primitives"
                ),
                .product(
                    name: "Hash Primitives Standard Library Integration",
                    package: "swift-hash-primitives"
                ),
                .product(
                    name: "Tagged Primitives Standard Library Integration",
                    package: "swift-tagged-primitives"
                ),
                .product(
                    name: "Ordinal Primitives Standard Library Integration",
                    package: "swift-ordinal-primitives"
                ),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
