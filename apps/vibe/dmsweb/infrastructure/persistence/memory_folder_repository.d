/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.dms-web.infrastructure.persistence.memory_folder_repository;

import uim.apps.dms_web.domain.entities.folder;
import uim.apps.dms_web.domain.repositories.folder_repository;
import std.uuid;
import std.algorithm;
import std.array;

@safe:

/**
 * In-memory implementation of folder repository
 */
class InMemoryFolderRepository : IFolderRepository {
  private Folder[UUID] _folders;

  void save(Folder folder) {
    _folders[folder.id] = folder;
  }

  Folder findById(UUID id) {
    return _folders.get(id, null);
  }

  Folder[] findAll() {
    return _folders.values.array;
  }

  Folder[] findByOwner(string owner) {
    return _folders.values
      .filter!(f => f.owner == owner)
      .array;
  }

  Folder[] findByParent(UUID parentId) {
    return _folders.values
      .filter!(f => f.parentId == parentId)
      .array;
  }

  void remove(UUID id) {
    _folders.remove(id);
  }

  bool exists(UUID id) {
    return (id in _folders) !is null;
  }
}