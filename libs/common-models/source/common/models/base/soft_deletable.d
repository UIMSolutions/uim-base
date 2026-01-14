/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.base.soft_deletable;

import std.datetime;

@safe:

/**
 * Interface for soft-deletable entities
 */
interface ISoftDeletable {
  bool isDeleted() const;
  SysTime deletedAt() const;
  string deletedBy() const;
  void markAsDeleted(string userId);
  void restore();
}

/**
 * Mixin template for soft delete behavior
 */
mixin template SoftDeletable() {
  private bool _isDeleted = false;
  private SysTime _deletedAt;
  private string _deletedBy;

  bool isDeleted() const { return _isDeleted; }
  SysTime deletedAt() const { return _deletedAt; }
  string deletedBy() const { return _deletedBy; }

  void markAsDeleted(string userId) {
    _isDeleted = true;
    _deletedAt = Clock.currTime();
    _deletedBy = userId;
  }

  void restore() {
    _isDeleted = false;
    _deletedAt = SysTime.init;
    _deletedBy = "";
  }
}