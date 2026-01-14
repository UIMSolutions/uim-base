/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.dms-web.application.usecases.list_documents;

import uim.apps.dms_web.domain.entities.document;
import uim.apps.dms_web.domain.repositories.document_repository;
import std.uuid;
import std.algorithm;
import std.array;
import std.conv;

@safe:

/**
 * Use case for listing documents with filtering
 */
class ListDocumentsUseCase {
  private IDocumentRepository _repository;

  this(IDocumentRepository repository) {
    _repository = repository;
  }

  ListDocumentsResponse execute(ListDocumentsRequest request) {
    Document[] documents;

    if (request.folderId != UUID.init) {
      documents = _repository.findByFolder(request.folderId);
    } else if (request.author.length > 0) {
      documents = _repository.findByAuthor(request.author);
    } else if (request.tag.length > 0) {
      documents = _repository.findByTag(request.tag);
    } else if (request.status != DocumentStatus.init) {
      documents = _repository.findByStatus(request.status);
    } else {
      documents = _repository.findAll();
    }

    // Apply search filter if provided
    if (request.searchTerm.length > 0) {
      import std.string : toLower, indexOf;
      documents = documents.filter!(d => 
        d.title.toLower.indexOf(request.searchTerm.toLower) >= 0 ||
        d.content.toLower.indexOf(request.searchTerm.toLower) >= 0
      ).array;
    }

    auto dtos = documents.map!(d => DocumentDTO.fromDocument(d)).array;
    return ListDocumentsResponse(dtos, documents.length);
  }
}

struct ListDocumentsRequest {
  string author;
  string tag;
  DocumentStatus status;
  UUID folderId;
  string searchTerm;
}

struct ListDocumentsResponse {
  DocumentDTO[] documents;
  size_t totalCount;
}

struct DocumentDTO {
  string id;
  string title;
  string author;
  string fileName;
  string mimeType;
  size_t fileSize;
  string status;
  string createdAt;
  string updatedAt;
  string[] tags;
  size_t version_;
  string folderId;

  static DocumentDTO fromDocument(Document doc) {
    DocumentDTO dto;
    dto.id = doc.id.toString();
    dto.title = doc.title;
    dto.author = doc.author;
    dto.fileName = doc.fileName;
    dto.mimeType = doc.mimeType;
    dto.fileSize = doc.fileSize;
    dto.status = doc.status.to!string;
    dto.createdAt = doc.createdAt.toISOExtString();
    dto.updatedAt = doc.updatedAt.toISOExtString();
    dto.tags = doc.tags;
    dto.version_ = doc.version_;
    dto.folderId = doc.folderId.toString();
    return dto;
  }
}