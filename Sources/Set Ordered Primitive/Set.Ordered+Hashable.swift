extension __SetOrdered: Hashable where S: Hashable {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(store)
    }
}
