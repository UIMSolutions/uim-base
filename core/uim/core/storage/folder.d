/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.storage.folder;

import uim.core;
@safe:

// #region CREATE
// #endregion CREATE

// #region READ
  // #region exists
    // Checks if the given path exists and is a symfolder.
    bool existsAllFolders(string[] paths...) {
      return existsAllFolders(paths.dup);
    }

    bool existsAllFolders(string[] paths) {
      return paths.all!(path => existsPath(path));
    }

    bool existsAnyFolders(string[] paths...) {
      return existsAnyFolders(paths.dup);
    }

    bool existsAnyFolders(string[] paths) {
      return paths.any!(path => existsPath(path));
    }

    bool existsFolder(string[] path) {
        return existsFolder(path.join(dirSeparator));
    }
    
    bool existsFolder(string path) {
        return existsPath(path) && isDir(path);
    }
  unittest {
    version(Windows) {
      assert(existsFolder("C:/Windows"));
      assert(!existsFolder("C:/Windows/System32/cmd.exe"));
    }
    version(Linux) {
      assert(existsFolder("/usr/bin"));
      assert(!existsFolder("/usr/bin/bash"));
    }
    version(MacOS) {
      assert(existsFolder("/usr/bin"));
      assert(!existsFolder("/usr/bin/bash"));
    }
  }
// #region exists

  // #endregion exists
// #endregion READ

// #region UPDATE
// #endregion UPDATE

// #region DELETE
// #endregion DELETE
