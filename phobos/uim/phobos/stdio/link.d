/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.stdio.link;

import uim.phobos;
@safe:

// #region CREATE
// #endregion CREATE

// #region READ
  // #region Exists
  // Checks if the given path exists and is a symlink.
    bool existsLink(string[] path) {
      return existsPath(path.join(dirSeparator));
    }

    bool existsLink(string path) {
      return existsPath(path) && isSymlink(path);
    }

    unittests {
      // TODO: Add tests for existsLink
    }
  // #endregion Exists
// #endregion READ

// #region UPDATE
// #endregion UPDATE

// #region DELETE
// #endregion DELETE