/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.entity.base_entity;

import common.models.base.identifiable;
import common.models.base.auditable;
import common.models.base.versionable;
import common.models.base.soft_deletable;
import std.uuid;
import std.datetime;

@safe:

/**
 * Base entity class with common functionality
 */
abstract class BaseEntity : Identifiable, IAuditable, IVersionable, ISoftDeletable {
  mixin Auditable;
  mixin Versionable;
  mixin SoftDeletable;

  this() {
    super();
  }

  this(UUID id) {
    super(id);
  }

  protected void onCreate(string userId) {
    initAudit(userId);
  }

  protected void onUpdate(string userId) {
    updateAudit(userId);
    incrementVersion();
  }
}