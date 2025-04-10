/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.file;

import uim.phobos;

@safe:

// #region exists
bool existsPath(string path) {
  return exists(path);
}

// #region File 
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
// #endregion File 

// #region Folder
bool existsFolder(string path) {
  return existsPath(path) && isDir(path);
}

bool existsLink(string path) {
  return existsPath(path) && isSymlink(path);
}
// #endregion Folder

unittest {
  version(Windows) {
    assert(existsPath("C:/Windows"));
    assert(!existsPath("C:/Windows/NotARealFolder"));

    assert(existsFile("C:/Windows/System32/cmd.exe"));
    assert(!existsFile("C:/Windows/NotARealFolder/NotARealFile.txt"));

    assert(existsFolder("C:/Windows"));
    assert(!existsFolder("C:/Windows/System32/cmd.exe"));

    assert(existsLink(path("C:/Windows/System32/cmd.exe")));
    assert(!existsLink(path("C:/Windows/NotARealFolder/NotARealFile.txt")));
  }
}
// #region exists
