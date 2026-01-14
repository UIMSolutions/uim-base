/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.dms-web.infrastructure.web.controllers.document_controller;

import vibe.vibe;
import uim.apps.dms_web.application.usecases;
import uim.apps.dms_web.domain.entities.document;
import std.uuid;
import std.conv;

@safe:

/**
 * REST API controller for document operations
 */
class DocumentController {
  private CreateDocumentUseCase _createUseCase;
  private ListDocumentsUseCase _listUseCase;

  this(CreateDocumentUseCase createUseCase, ListDocumentsUseCase listUseCase) {
    _createUseCase = createUseCase;
    _listUseCase = listUseCase;
  }

  void registerRoutes(URLRouter router) @trusted {
    router.get("/api/documents", &listDocuments);
    router.post("/api/documents", &createDocument);
    router.get("/api/documents/:id", &getDocument);
    router.put("/api/documents/:id", &updateDocument);
    router.delete("/api/documents/:id", &deleteDocument);
  }

  void listDocuments(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    try {
      auto request = ListDocumentsRequest();
      
      if (auto author = "author" in req.query) {
        request.author = *author;
      }
      if (auto tag = "tag" in req.query) {
        request.tag = *tag;
      }
      if (auto search = "search" in req.query) {
        request.searchTerm = *search;
      }
      if (auto folderId = "folderId" in req.query) {
        request.folderId = UUID(*folderId);
      }

      auto response = _listUseCase.execute(request);
      
      res.writeJsonBody([
        "success": true,
        "documents": response.documents.serializeToJson(),
        "totalCount": response.totalCount
      ]);
    } catch (Exception e) {
      res.statusCode = HTTPStatus.badRequest;
      res.writeJsonBody([
        "success": false,
        "error": e.msg
      ]);
    }
  }

  void createDocument(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    try {
      auto json = req.json;
      
      auto request = CreateDocumentRequest(
        json["title"].get!string,
        json["content"].get!string,
        json["author"].get!string,
        json.get("fileName", "").get!string,
        json.get("mimeType", "text/plain").get!string,
        json.get("fileSize", 0).get!size_t,
        UUID.init,
        []
      );

      if (auto folderId = "folderId" in json) {
        request.folderId = UUID(folderId.get!string);
      }

      if (auto tags = "tags" in json) {
        foreach (tag; tags.get!(Json[])) {
          request.tags ~= tag.get!string;
        }
      }

      auto response = _createUseCase.execute(request);
      
      res.statusCode = HTTPStatus.created;
      res.writeJsonBody([
        "success": true,
        "documentId": response.documentId.toString(),
        "message": response.message
      ]);
    } catch (Exception e) {
      res.statusCode = HTTPStatus.badRequest;
      res.writeJsonBody([
        "success": false,
        "error": e.msg
      ]);
    }
  }

  void getDocument(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    // Implementation for getting a single document
    res.writeJsonBody(["message": "Get document by ID"]);
  }

  void updateDocument(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    // Implementation for updating a document
    res.writeJsonBody(["message": "Update document"]);
  }

  void deleteDocument(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    // Implementation for deleting a document
    res.writeJsonBody(["message": "Delete document"]);
  }
}