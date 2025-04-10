/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.stdio.file;

import uim.phobos;
@safe:

// #region CREATE
  void createFile(string path) {
    auto file = File(path, "w+");
    file.close();
  }
// #endregion CREATE

// #region READ
  // #region Exists
  // #endregion Exists
// #endregion READ

// #region UPDATE
// #endregion UPDATE

// #region DELETE
  // #region Remove
    void removeFiles(string[] paths...) {
      removeFiles(paths.dup);
    }

    void removeFiles(string[] paths) {
      paths.each!(path => remove(path));
    }

    void removeFile(string[] path, string pathSeparator = null) {
      remove(path.join(pathSeparator is null ? dirSeparator : pathSeparator));
    }

    void removeFile(string path) {
      if (path.isFile) {
        return remove(path);
      }
    }
  // #endregion Remove
// #endregion DELETE
