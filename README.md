# swift-set-ordered

Use this package when you need a hash set of unique members, including `~Copyable` members, and also need to reach members by position: look up where a member sits, read the member at a position, or read the first or last member. Start from `Set<E>.Ordered`, which owns its store directly and is never shared or copied implicitly. Use `__Set<Ownership.Shared<E, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>>>.Ordered` instead when copies must share one store until one of them changes. If you only need membership and iteration, use `Set<E>` from the sibling package swift-set. If each member carries a value, use swift-dictionary-ordered.

## Laws

- A member's position is its place in insertion order. `forEach`, the positional subscript, `index(of:)`, `first` and `last` all read that one order, and growing the store does not change it.
- `remove` moves every later member down one position, so positions stay contiguous from zero. A member that is removed and inserted again goes to the end.
- If `insert` gets a member equal to one already present, the set and its order are unchanged and an equal member is handed back to the caller. It returns `nil` only when the member was added.
- `index(of:)` returns `nil` for a member that is not present, including one that was removed.
- Equality is order-sensitive: two sets with the same members inserted in a different order are not equal.
- In the shared form, copies share one store. `insert` and `remove` first give the copy being changed a store of its own, so a removal never moves positions in another copy. `contains`, `index(of:)`, `forEach`, the positional subscript, `first`, `last` and `count` never copy the store.
- In the shared form, `removeAll` always swaps in a fresh store and never empties the shared one. With `keepingCapacity`, the fresh store is created with the old capacity.
- `clone()` returns a set with its own store. Changes to either one never reach the other.
- Every member is deinitialized exactly once: members removed from the set, members still in it when its last copy goes away, and members handed back by `insert` or `remove` (the caller owns those).
