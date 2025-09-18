/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.keys.remove;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

interface IRemoveKeys(T) : IHasKeys!T, IGetKeys!T, IUpdateKeys!T {
    // Removes all keys from the collection.
    bool removeAll();

    // Removes the given keys from the collection.
    bool remove(string[] keys);

    // Removes a specific key from the collection.
    bool remove(string key);
}

