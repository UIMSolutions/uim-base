/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.base.auditable;

import std.datetime;

@safe:

/**
 * Interface for auditable entities
 */
interface IAuditable {
  SysTime createdAt() const;
  SysTime updatedAt() const;
  string createdBy() const;
  string updatedBy() const;
}

/**
 * Mixin template for auditable behavior
 */
mixin template Auditable() {
  private SysTime _createdAt;
  private SysTime _updatedAt;
  private string _createdBy;
  private string _updatedBy;

  SysTime createdAt() const { return _createdAt; }
  SysTime updatedAt() const { return _updatedAt; }
  string createdBy() const { return _createdBy; }
  string updatedBy() const { return _updatedBy; }

  protected void initAudit(string userId) {
    _createdAt = Clock.currTime();
    _updatedAt = Clock.currTime();
    _createdBy = userId;
    _updatedBy = userId;
  }

  protected void updateAudit(string userId) {
    _updatedAt = Clock.currTime();
    _updatedBy = userId;
  }
}