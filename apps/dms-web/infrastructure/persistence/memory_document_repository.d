/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.dms-web.infrastructure.persistence.memory_document_repository;

import uim.apps.dms_web.domain.entities.document;
import uim.apps.dms_web.domain.repositories.document_repository;
import std.uuid;
import std.algorithm;
import std.array;

@safe:

/**
 * In-memory implementation of document repository
 */
class InMemoryDocumentRepository : IDocumentRepository {
  private Document[UUID] _documents;

  void save(Document document) {
    _documents[document.id] = document;
  }

  Document findById(UUID id) {
    return _documents.get(id, null);
  }

  Document[] findAll() {
    return _documents.values.array;
  }

  Document[] findByAuthor(string author) {
    return _documents.values
      .filter!(d => d.author == author)
      .array;
  }

  Document[] findByTag(string tag) {
    return _documents.values
      .filter!(d => d.hasTag(tag))
      .array;
  }

  Document[] findByStatus(DocumentStatus status) {
    return _documents.values
      .filter!(d => d.status == status)
      .array;
  }

  Document[] findByFolder(UUID folderId) {
    return _documents.values
      .filter!(d => d.folderId == folderId)
      .array;
  }

  void remove(UUID id) {
    _documents.remove(id);
  }

  bool exists(UUID id) {
    return (id in _documents) !is null;
  }

  size_t count() {
    return _documents.length;
  }
}