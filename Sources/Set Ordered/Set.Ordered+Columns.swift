public import Buffer_Linear_Primitive
public import Buffer
public import Hash_Indexed_Primitive
import Hash
import Hash_Table_Primitive
public import Index
public import Memory_Allocator
public import Memory
public import Ownership_Shared_Primitive
public import Set_Ordered_Primitive
public import Storage

extension __SetOrdered where S: ~Copyable {

    @inlinable
    @discardableResult
    public mutating func insert<E: Hash.Key & ~Copyable>(_ element: consuming E) -> E?
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear> {
        store.insert(element)
    }

    @inlinable
    @discardableResult
    public mutating func insert<E: Hash.Key & ~Copyable>(_ element: consuming E) -> E?
    where
        S == Ownership.Shared<
            E, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>
        >
    {
        store.withUnique(consuming: element) { column, element in
            column.insert(element)
        }
    }
}

extension __SetOrdered where S: ~Copyable {

    @inlinable
    public func contains<E: Hash.Key & ~Copyable>(_ element: borrowing E) -> Bool
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear> {
        store.contains(element)
    }

    @inlinable
    public func contains<E: Hash.Key & ~Copyable>(_ element: borrowing E) -> Bool
    where
        S == Ownership.Shared<
            E, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>
        >
    {
        store.withColumn { $0.contains(element) }
    }
}

extension __SetOrdered where S: ~Copyable {

    @inlinable
    public func index<E: Hash.Key & ~Copyable>(of element: borrowing E) -> Index<E>?
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear> {

        store.position(of: element)
    }

    @inlinable
    public func index<E: Hash.Key & ~Copyable>(of element: borrowing E) -> Index<E>?
    where
        S == Ownership.Shared<
            E, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>
        >
    {

        store.withColumn { $0.position(of: element) }
    }
}

extension __SetOrdered where S: ~Copyable {

    @inlinable
    public mutating func remove<E: Hash.Key & ~Copyable>(_ element: borrowing E) -> E?
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear> {
        store.remove(element)
    }

    @inlinable
    public mutating func remove<E: Hash.Key & ~Copyable>(_ element: borrowing E) -> E?
    where
        S == Ownership.Shared<
            E, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>
        >
    {
        store.withUnique { $0.remove(element) }
    }

    @inlinable
    public mutating func removeAll<E: Hash.Key & ~Copyable>(keepingCapacity: Bool = true)
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear> {
        store.removeAll(keepingCapacity: keepingCapacity)
    }

    @inlinable
    public mutating func removeAll<E: Hash.Key & SendableMetatype>(keepingCapacity: Bool = true)
    where
        S == Ownership.Shared<
            E, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>
        >
    {
        let capacity: Index<E>.Count = keepingCapacity ? store.capacity : .zero
        self.store = Ownership.Shared(
            Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>(
                minimumCapacity: capacity
            )
        )
    }
}

extension __SetOrdered where S: ~Copyable {

    @inlinable
    public func forEach<E: Hash.Key & ~Copyable>(_ body: (borrowing E) -> Void)
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear> {
        store.forEach(body)
    }

    @inlinable
    public func forEach<E: Hash.Key & ~Copyable>(_ body: (borrowing E) -> Void)
    where
        S == Ownership.Shared<
            E, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>
        >
    {
        store.withColumn { $0.forEach(body) }
    }
}

extension __SetOrdered where S: ~Copyable {

    @inlinable
    public func clone<E: Hash.Key>() -> Self
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear> {
        Self(store: store.clone())
    }
}
