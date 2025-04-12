/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.storage.file;

import uim.core;
@safe:

// #region CREATE
  void createFile(string path) {
    auto file = File(path, "w+");
    file.close();
  }
// #endregion CREATE

// #region READ
  // #region Exists
    bool existsAllFiles(string[] paths...) {
      return existsAllFiles(paths.dup);
    }

    bool existsAllFiles(string[] paths) {
      return paths.length == 0
        ? false // Empty array, no files to check
        : paths.all!(path => existsFile(path));
    }

    bool existsAnyFiles(string[] paths...) {
      return existsAnyFiles(paths.dup);
    }

    bool existsAnyFiles(string[] paths) {
      return paths.length == 0
        ? false // Empty array, no files to check 
        : paths.any!(path => existsFile(path));
    }

    bool existsFile(string[] path) {
      return existsFile(path.join(dirSeparator));
    }
    bool existsFile(string[] path, string file) {
      return existsFile(path.join(dirSeparator) ~ dirSeparator ~ file);
    }
    bool existsFile(string[] path, string file, string ext) {
      return existsFile(path.join(dirSeparator) ~ dirSeparator ~ file ~ "." ~ ext);
    }

    bool existsFile(string path) {
      return existsPath(path) && isFile(path);
    }
    bool existsFile(string path, string file) {
      return existsFile(path ~ dirSeparator ~ file);
    }
    bool existsFile(string path, string file, string ext) {
      return existsFile(path ~ dirSeparator ~ file ~ "." ~ ext);
    }
      unittest {
    version(Windows) {
      assert(existsFile("C:/Windows/System32/cmd.exe"));
      assert(!existsFile("C:/Windows/NotARealFolder/NotARealFile.txt"));
    }
    version(Linux) {
      assert(existsFile("/usr/bin/bash"));
      assert(!existsFile("/usr/bin/NotARealFolder/NotARealFile.txt"));
    }
    version(MacOS) {
      assert(existsFile("/usr/bin/bash"));
      assert(!existsFile("/usr/bin/NotARealFolder/NotARealFile.txt"));
    }
  }
// #region exists

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
