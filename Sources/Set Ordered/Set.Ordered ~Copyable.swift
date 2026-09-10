public import Buffer
public import Index
import Ordinal
public import Set_Ordered_Primitive
public import Store

extension __SetOrdered where S: ~Copyable, S: Store.`Protocol` & Buffer.`Protocol` {

    @inlinable
    public var count: Index<S.Element>.Count { store.count }

    @inlinable
    public var isEmpty: Bool { store.isEmpty }

    @inlinable
    public var capacity: Index<S.Element>.Count { store.capacity }
}

extension __SetOrdered where S: ~Copyable, S: Store.`Protocol` & Buffer.`Protocol` {

    @inlinable
    public subscript(index: Index<S.Element>) -> S.Element {
        _read {
            precondition(index < count.map(Ordinal.init), "ordered surface: index out of bounds")
            yield store[index]
        }
    }
}

extension __SetOrdered
where S: ~Copyable, S.Element: Copyable, S: Store.`Protocol` & Buffer.`Protocol` {

    @inlinable
    public var first: S.Element? {
        isEmpty ? nil : store[.zero]
    }

    @inlinable
    public var last: S.Element? {
        guard !isEmpty else { return nil }
        return store[count.subtract.saturating(.one).map(Ordinal.init)]
    }
}

extension __SetOrdered where S: Copyable, S: Store.`Protocol` {

    @inlinable
    public borrowing func clone() -> Self {
        var result = copy self
        result.store.unshare()
        return result
    }
}
