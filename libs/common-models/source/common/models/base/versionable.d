/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.base.versionable;

@safe:

/**
 * Interface for versionable entities
 */
interface IVersionable {
  size_t version_() const;
  void incrementVersion();
}

/**
 * Mixin template for version control
 */
mixin template Versionable() {
  private size_t _version = 1;

  size_t version_() const { return _version; }

  void incrementVersion() {
    _version++;
  }
}