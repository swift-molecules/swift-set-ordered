// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-set-ordered",
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
            name: "Set Ordered",
            targets: ["Set Ordered"]
        ),

    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-set.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-hash.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-hash-table.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ownership-shared.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-buffer.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-buffer-linear.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-storage.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-heap.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-allocation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-tagged.git",
            branch: "main"
        ),

    ],
    targets: [

        .target(
            name: "Set Ordered Primitive",
            dependencies: [
                .product(name: "Set Primitive", package: "swift-set"),
                .product(name: "Hash Indexed Primitive", package: "swift-hash-table"),
                .product(name: "Hash Table Primitive", package: "swift-hash-table"),
                .product(name: "Hash", package: "swift-hash"),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared"
                ),
                .product(name: "Buffer Primitive", package: "swift-buffer"),
                .product(name: "Buffer Protocol", package: "swift-buffer"),
                .product(
                    name: "Buffer Linear Primitive",
                    package: "swift-buffer-linear"
                ),
                .product(name: "Storage Primitive", package: "swift-storage"),
                .product(
                    name: "Storage Contiguous",
                    package: "swift-storage"
                ),
                .product(name: "Store Protocol", package: "swift-storage"),
                .product(name: "Memory Heap", package: "swift-memory-heap"),
                .product(
                    name: "Memory Allocator Primitive",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Index", package: "swift-index"),
            ]
        ),

        .target(
            name: "Set Ordered",
            dependencies: [
                "Set Ordered Primitive",
                .product(name: "Hash Indexed Primitive", package: "swift-hash-table"),
                .product(name: "Hash Table Primitive", package: "swift-hash-table"),
                .product(name: "Hash", package: "swift-hash"),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared"
                ),
                .product(name: "Buffer Primitive", package: "swift-buffer"),
                .product(name: "Buffer Protocol", package: "swift-buffer"),
                .product(
                    name: "Buffer Linear Primitive",
                    package: "swift-buffer-linear"
                ),
                .product(name: "Storage Primitive", package: "swift-storage"),
                .product(
                    name: "Storage Contiguous",
                    package: "swift-storage"
                ),
                .product(name: "Store Protocol", package: "swift-storage"),
                .product(name: "Memory Heap", package: "swift-memory-heap"),
                .product(
                    name: "Memory Allocator Primitive",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Index", package: "swift-index"),
                .product(
                    name: "Ordinal Standard Library Integration",
                    package: "swift-ordinal"
                ),
            ]
        ),

        .testTarget(
            name: "Set Ordered Tests",
            dependencies: [
                "Set Ordered",
                .product(
                    name: "Hash Table Test Support",
                    package: "swift-hash-table"
                ),
                .product(
                    name: "Buffer Test Support",
                    package: "swift-buffer"
                ),
                .product(
                    name: "Hash Standard Library Integration",
                    package: "swift-hash"
                ),
                .product(
                    name: "Tagged Standard Library Integration",
                    package: "swift-tagged"
                ),
                .product(
                    name: "Ordinal Standard Library Integration",
                    package: "swift-ordinal"
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
