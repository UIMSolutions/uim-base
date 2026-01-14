/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.dms-web.application.usecases.create_document;

import uim.apps.dms_web.domain.entities.document;
import uim.apps.dms_web.domain.repositories.document_repository;
import std.uuid;

@safe:

/**
 * Use case for creating a new document
 */
class CreateDocumentUseCase {
  private IDocumentRepository _repository;

  this(IDocumentRepository repository) {
    _repository = repository;
  }

  CreateDocumentResponse execute(CreateDocumentRequest request) {
    // Validate input
    if (request.title.length == 0) {
      throw new Exception("Title cannot be empty");
    }
    if (request.author.length == 0) {
      throw new Exception("Author cannot be empty");
    }

    // Create document
    auto document = new Document(
      request.title, 
      request.content, 
      request.author,
      request.fileName,
      request.mimeType
    );
    
    if (request.folderId != UUID.init) {
      document.moveTo(request.folderId);
    }

    if (request.fileSize > 0) {
      document.setFileSize(request.fileSize);
    }

    // Add tags if provided
    foreach (tag; request.tags) {
      document.addTag(tag);
    }

    // Save to repository
    _repository.save(document);

    return CreateDocumentResponse(document.id, "Document created successfully");
  }
}

struct CreateDocumentRequest {
  string title;
  string content;
  string author;
  string fileName;
  string mimeType;
  size_t fileSize;
  UUID folderId;
  string[] tags;
}

struct CreateDocumentResponse {
  UUID documentId;
  string message;
}