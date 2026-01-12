/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.storage.link;

import uim.core;
mixin(ShowModule!());

@safe:

// #region CREATE
// #endregion CREATE

// #region READ
  // #region Exists
    // Checks if the given path exists and is a symlink.
    bool existsAllLinks(string[] paths) {
      return paths.all!(path => existsPath(path));
    }

    bool existsAnyLinks(string[] paths) {
      return paths.any!(path => existsPath(path));
    }

    bool existsLink(string[] path) {
      return existsPath(buildPath(path));
    }

    bool existsLink(string path) {
      return existsPath(path) && isSymlink(path);
    }

    unittest {
      // TODO: Add tests for existsLink
    }
  // #endregion Exists
// #endregion READ

// #region UPDATE
// #endregion UPDATE

// #region DELETE
// #endregion DELETE