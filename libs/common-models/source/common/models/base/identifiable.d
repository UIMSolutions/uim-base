/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.base.identifiable;

import std.uuid;

@safe:

/**
 * Interface for entities with unique identifiers
 */
interface IIdentifiable {
  UUID id() const;
}

/**
 * Base class for identifiable entities
 */
abstract class Identifiable : IIdentifiable {
  protected UUID _id;

  this() {
    _id = randomUUID();
  }

  this(UUID id) {
    _id = id;
  }

  UUID id() const {
    return _id;
  }

  override bool opEquals(Object other) const {
    if (auto o = cast(Identifiable)other) {
      return _id == o._id;
    }
    return false;
  }

  override size_t toHash() const nothrow @trusted {
    return _id.toHash();
  }
}