/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.dms-web.domain.repositories.folder_repository;

import uim.apps.dms_web.domain.entities.folder;
import std.uuid;

@safe:

/**
 * Repository interface for folder persistence
 */
interface IFolderRepository {
  void save(Folder folder);
  Folder findById(UUID id);
  Folder[] findAll();
  Folder[] findByOwner(string owner);
  Folder[] findByParent(UUID parentId);
  void remove(UUID id);
  bool exists(UUID id);
}