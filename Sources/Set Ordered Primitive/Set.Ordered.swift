public import Buffer_Linear_Primitive
public import Buffer_Primitive
public import Hash_Indexed_Primitive
import Hash
public import Index
public import Memory_Allocator_Primitive
public import Memory
public import Ownership_Shared_Primitive
public import Set_Primitive
public import Storage_Contiguous
public import Storage_Primitive

extension __Set where S: ~Copyable {

    public typealias Ordered = __SetOrdered<S>
}

@_documentation(visibility: public)
@frozen
public struct __SetOrdered<S: ~Copyable>: ~Copyable {

    @usableFromInline
    package var store: S

    @inlinable
    public init(store: consuming S) {
        self.store = store
    }
}

extension __SetOrdered where S: ~Copyable {

    @inlinable
    public consuming func take() -> S {
        store
    }
}

extension __SetOrdered: Copyable where S: Copyable {}

extension __SetOrdered: Sendable where S: Sendable & ~Copyable {}

extension __SetOrdered where S: ~Copyable {

    @inlinable
    public init<E: Hash.Key & ~Copyable>(minimumCapacity: Index.Index<E>.Count = .zero)
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear> {
        self.init(store: S(minimumCapacity: minimumCapacity))
    }

    @inlinable
    public init<E: Hash.Key & SendableMetatype>(
        minimumCapacity: Index.Index<E>.Count = .zero
    )
    where
        S == Ownership.Shared<
            E, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>
        >
    {
        self.init(
            store: Ownership.Shared(
                Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>(
                    minimumCapacity: minimumCapacity
                )
            )
        )
    }

    @inlinable
    public init<E: Hash.Key & SendableMetatype & ~Copyable>(
        minimumCapacity: Index.Index<E>.Count = .zero
    )
    where
        S == Ownership.Shared<
            E, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>
        >
    {
        self.init(
            store: Ownership.Shared(
                Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>(
                    minimumCapacity: minimumCapacity
                )
            )
        )
    }
}
