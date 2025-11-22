/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.lists.list;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class UIMList(V) : DCollection!V, IList!V {
    // Check if the list is empty.
    bool isEmpty();

    // Add an item to the list. Returns true if the item was added, false if it was already present.
    bool add(in V item);

    // Check if the list contains the specified item.
    bool contains(in V item);

    // Get an item by its index.
    V get(size_t index);
}
