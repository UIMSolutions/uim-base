/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.dms-web.application.usecases.create_folder;

import uim.apps.dms_web.domain.entities.folder;
import uim.apps.dms_web.domain.repositories.folder_repository;
import std.uuid;

@safe:

/**
 * Use case for creating a new folder
 */
class CreateFolderUseCase {
  private IFolderRepository _repository;

  this(IFolderRepository repository) {
    _repository = repository;
  }

  CreateFolderResponse execute(CreateFolderRequest request) {
    if (request.name.length == 0) {
      throw new Exception("Folder name cannot be empty");
    }

    auto folder = new Folder(request.name, request.owner, request.description);
    
    if (request.parentId != UUID.init) {
      if (!_repository.exists(request.parentId)) {
        throw new Exception("Parent folder does not exist");
      }
      folder.setParent(request.parentId);
    }

    _repository.save(folder);

    return CreateFolderResponse(folder.id, "Folder created successfully");
  }
}

struct CreateFolderRequest {
  string name;
  string owner;
  string description;
  UUID parentId;
}

struct CreateFolderResponse {
  UUID folderId;
  string message;
}