extension __SetOrdered: Equatable where S: Equatable {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.store == rhs.store
    }
}
