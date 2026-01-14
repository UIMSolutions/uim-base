/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.dms-web.domain.entities.folder;

import std.datetime;
import std.uuid;

@safe:

/**
 * Folder entity for organizing documents
 */
class Folder {
  private UUID _id;
  private string _name;
  private string _description;
  private UUID _parentId;
  private string _owner;
  private SysTime _createdAt;
  private SysTime _updatedAt;

  this(string name, string owner, string description = "") {
    _id = randomUUID();
    _name = name;
    _owner = owner;
    _description = description;
    _createdAt = Clock.currTime();
    _updatedAt = Clock.currTime();
  }

  // Getters
  UUID id() const { return _id; }
  string name() const { return _name; }
  string description() const { return _description; }
  UUID parentId() const { return _parentId; }
  string owner() const { return _owner; }
  SysTime createdAt() const { return _createdAt; }
  SysTime updatedAt() const { return _updatedAt; }

  void rename(string newName) {
    if (newName.length == 0) {
      throw new Exception("Folder name cannot be empty");
    }
    _name = newName;
    _updatedAt = Clock.currTime();
  }

  void setParent(UUID parentId) {
    _parentId = parentId;
    _updatedAt = Clock.currTime();
  }

  void updateDescription(string newDescription) {
    _description = newDescription;
    _updatedAt = Clock.currTime();
  }
}