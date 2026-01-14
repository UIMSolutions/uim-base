/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.vibe.dms.domain.repositories.document_repository;

import uim.apps.dms_web.domain.entities.document;
import std.uuid;

@safe:

/**
 * Repository interface for document persistence
 */
interface IDocumentRepository {
  void save(Document document);
  Document findById(UUID id);
  Document[] findAll();
  Document[] findByAuthor(string author);
  Document[] findByTag(string tag);
  Document[] findByStatus(DocumentStatus status);
  Document[] findByFolder(UUID folderId);
  void remove(UUID id);
  bool exists(UUID id);
  size_t count();
}