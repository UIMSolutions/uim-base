/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.storage.file;

import uim.core;

@safe:

// #region CREATE
void createFilesInPath(string path, string[] filenames...) {
  createFilesInPath(path, filenames.dup);
}

void createFilesInPath(string path, string[] filenames) {
  filenames.each!(filename => createFileInPath(path, filename));
}

void createFileInPath(string[] path, string filename) {
  createFileInPath(buildPath(path), filename);
}

void createFileInPath(string path, string filename) {
  createFile(buildPath(path, file) name);
}

void createFiles(string[] filenames...) {
  createFiles(filenames.dup);
}

void createFiles(string[] filenames) {
  filenames.each!(filename => createFile(filename));
}

void createFile(string filename) {
  auto file = File(filename, "w+");
  file.close();
}

unittest {
  version (Windows) {
    createFile("C:/Windows/System32/test.txt");
    assert(existsFile("C:/Windows/System32/test.txt"));
    removeFile("C:/Windows/System32/test.txt");

    createFiles("C:/Windows/NotARealFolder/test.txt");
    assert(existsAllFiles("C:/Windows/NotARealFolder/test.txt"));
    removeFiles("C:/Windows/NotARealFolder/test.txt");
  }
  version (Linux) {
    createFile("/usr/bin/test.txt");
    assert(existsFile("/usr/bin/test.txt"));
    removeFile("/usr/bin/test.txt");
  }
  version (MacOS) {
    createFile("/usr/bin/test.txt");
    assert(existsFile("/usr/bin/test.txt"));
    removeFile("/usr/bin/test.txt");
  }
}
// #endregion CREATE

// #region READ
// #region Exists
bool existsAllFiles(string[] paths...) {
  return existsAllFiles(paths.dup);
}

bool existsAllFiles(string[] paths) {
  return paths.length == 0
    ? false  // Empty array, no files to check
     : paths.all!(path => existsFile(path));
}

bool existsAnyFiles(string[] paths...) {
  return existsAnyFiles(paths.dup);
}

bool existsAnyFiles(string[] paths) {
  return paths.length == 0
    ? false  // Empty array, no files to check 
     : paths.any!(path => existsFile(path));
}

bool existsFile(string[] path) {
  return existsFile(buildPath(path));
}

bool existsFile(string[] path, string file) {
  return existsFile(buildPath(path) ~ dirSeparator ~ file);
}

bool existsFile(string[] path, string file, string ext) {
  return existsFile(buildPath(path) ~ dirSeparator ~ file ~ "." ~ ext);
}

bool existsFile(string path, string file = null, string ext = null) {
  return (file is null)
    ? exists(path) && isFile(path) : ((ext is null)
        ? exists(normalizePath(path, file)) && isFile(normalizePath(path, file)) 
        : exists(normalizePath(path, file ~ "." ~ ext)) && isFile(normalizePath(path, file ~ "." ~ ext)));
}

unittest {
  version (Windows) {
    assert(existsFile("C:/Windows/System32/cmd.exe"));
    assert(!existsFile("C:/Windows/NotARealFolder/NotARealFile.txt"));

    assert(existsFile("C:/Windows/System32/cmd.exe", "cmd"));
    assert(!existsFile("C:/Windows/System32/cmd.exe", "NotARealFile.txt"));
    
    assert(existsFile("C:/Windows/System32/cmd.exe", "cmd", "exe"));
    assert(!existsFile("C:/Windows/System32/cmd.exe", "cmd", "NotARealFile.txt"));

    assert(existsAnyFiles(["C:/Windows/System32/cmd.exe", "C:/Windows/NotARealFolder/NotARealFile.txt"]));
    assert(!existsAnyFiles(["C:/Windows/NotARealFolder/NotFile.txt", "C:/Windows/NotARealFolder/NotARealFile.txt"]));

    assert(existsAnyFiles("C:/Windows/System32/cmd.exe", "C:/Windows/NotARealFolder/NotARealFile.txt"));
    assert(!existsAnyFiles("C:/Windows/NotARealFolder/NotARealFile.txt", "C:/Windows/NotARealFolder/NotARealFile.txt"));

    assert(existsAllFiles(["C:/Windows/System32/cmd.exe", "C:/Windows/System32/cmd.exe"]));
    assert(!existsAllFiles(["C:/Windows/NotARealFolder/NotARealFile.txt", "C:/Windows/System32/cmd.exe"]));

    assert(existsAllFiles("C:/Windows/System32/cmd.exe", "C:/Windows/System32/cmd.exe"));
    assert(!existsAllFiles("C:/Windows/NotARealFolder/NotARealFile.txt", "C:/Windows/System32/cmd.exe"));
  }
  version (Linux) {
    assert(existsFile("/usr/bin/bash"));
    assert(!existsFile("/usr/bin/NotARealFolder/NotARealFile.txt"));

    assert(existsFile("/usr/bin", "bash"));
    assert(!existsFile("/usr/bin/NotARealFolder", "NotARealFile.txt"));
  }
  version (MacOS) {
    assert(existsFile("/usr/bin/bash"));
    assert(!existsFile("/usr/bin/NotARealFolder/NotARealFile.txt"));

    assert(existsFile("/usr/bin", "bash"));
    assert(!existsFile("/usr/bin/NotARealFolder", "NotARealFile.txt"));
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
