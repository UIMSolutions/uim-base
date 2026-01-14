/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.vibe.dms.infrastructure.web.controllers.folder_controller;

import vibe.vibe;
import uim.apps.dms_web.application.usecases.create_folder;
import std.uuid;

@safe:

/**
 * REST API controller for folder operations
 */
class FolderController {
  private CreateFolderUseCase _createUseCase;

  this(CreateFolderUseCase createUseCase) {
    _createUseCase = createUseCase;
  }

  void registerRoutes(URLRouter router) @trusted {
    router.get("/api/folders", &listFolders);
    router.post("/api/folders", &createFolder);
    router.get("/api/folders/:id", &getFolder);
    router.put("/api/folders/:id", &updateFolder);
    router.delete("/api/folders/:id", &deleteFolder);
  }

  void listFolders(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    res.writeJsonBody(["message": "List all folders"]);
  }

  void createFolder(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    try {
      auto json = req.json;
      
      auto request = CreateFolderRequest(
        json["name"].get!string,
        json["owner"].get!string,
        json.get("description", "").get!string,
        UUID.init
      );

      if (auto parentId = "parentId" in json) {
        request.parentId = UUID(parentId.get!string);
      }

      auto response = _createUseCase.execute(request);
      
      res.statusCode = HTTPStatus.created;
      res.writeJsonBody([
        "success": true,
        "folderId": response.folderId.toString(),
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

  void getFolder(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    res.writeJsonBody(["message": "Get folder by ID"]);
  }

  void updateFolder(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    res.writeJsonBody(["message": "Update folder"]);
  }

  void deleteFolder(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    res.writeJsonBody(["message": "Delete folder"]);
  }
}