/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.storage.folder;

import uim.core;

@safe:

// #region CREATE
void createFoldersInPath(string path, string[] foldernames...) {
  createFoldersInPath(path, foldernames.dup);
}

void createFoldersInPath(string path, string[] foldernames) {
  foldernames.each!(foldername => createFolderInPath(path, foldername));
}

void createFolderInPath(string[] path, string foldername) {
  createFolderInPath(normalizePath(path), foldername);
}

void createFolderInPath(string path, string foldername) {
  createFolder(normalizePath(path, foldername));
}

void createFolders(string[] foldernames...) {
  createFolders(foldernames.dup);
}

void createFolders(string[] foldernames) {
  foldernames.each!(foldername => createFolder(foldername));
}

void createFolder(string foldername) {
  mkdir(foldername);
}

unittest {
  createFolder(tempDir ~ "test");
  assert(existsFolder(tempDir ~ "test"));
  removeFolder(tempDir ~ "test");
  assert(!existsFolder(tempDir ~ "test"));

  createFolders([tempDir ~ "test1", tempDir ~ "test2", tempDir ~ "test3"]);
  assert(existsAllFolders([tempDir ~ "test1", tempDir ~ "test2", tempDir ~ "test3"]));
  removeFolders([tempDir ~ "test1", tempDir ~ "test2", tempDir ~ "test3"]);
  assert(!existsAnyFolders([
      tempDir ~ "test1", tempDir ~ "test2", tempDir ~ "test3"
    ]));

  createFolders(tempDir ~ "test1", tempDir ~ "test2", tempDir ~ "test3");
  assert(existsAllFolders(tempDir ~ "test1", tempDir ~ "test2", tempDir ~ "test3"));
  removeFolders(tempDir ~ "test1", tempDir ~ "test2", tempDir ~ "test3");
  assert(!existsAnyFolders(tempDir ~ "test1", tempDir ~ "test2", tempDir ~ "test3"));
}
// #endregion CREATE

// #region READ
// #region exists
// Checks if the given path exists and is a symfolder.
bool existsAllFolders(string[] folderpaths...) {
  return existsAllFolders(folderpaths.dup);
}

bool existsAllFolders(string[] folderpaths) {
  return folderpaths.all!(path => existsFolder(path));
}

bool existsAnyFolders(string[] folderpaths...) {
  return existsAnyFolders(folderpaths.dup);
}

bool existsAnyFolders(string[] folderpaths) {
  return folderpaths.any!(path => existsPath(path));
}

bool existsFolder(string[] path) {
  return existsFolder(buildPath(path));
}

bool existsFolder(string folderpath) {
  return exists(folderpath) && isDir(folderpath);
}

unittest {
  version (Windows) {
    assert(existsFolder("C:/Windows"));
    assert(!existsFolder("C:/Windows/System32/cmd.exe"));
  }
  version (Linux) {
    assert(existsFolder("/usr/bin"));
    assert(!existsFolder("/usr/bin/bash"));
  }
  version (MacOS) {
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
void removeFoldersInPath(string path, string[] foldernames...) {
  removeFoldersInPath(path, foldernames.dup);
}

void removeFoldersInPath(string path, string[] foldernames) {
  foldernames.each!(foldername => removeFolderInPath(path, foldername));
}

void removeFolderInPath(string path, string foldername) {
  removeFolder(normalizePath(path, foldername));
}

void removeFolders(string[] paths...) {
  removeFolders(paths.dup);
}

void removeFolders(string[] foldernames) {
  foldernames.each!(foldername => removeFolder(foldername));
}

void removeFolder(string[] folderpath) {
  removeFolder(normalizePath(folderpath));
}

void removeFolder(string foldername) {
  if (foldername.isDir) {
    rmdir(normalizePath(foldername));
  }
}

unittest {
  // TODO: Add unittest for removeFolder, removeFolders, removeFolderInPath, removeFoldersInPath
}
// #endregion DELETE
