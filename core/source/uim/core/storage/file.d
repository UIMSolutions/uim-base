/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur)                                                  
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                
*****************************************************************************************************************/
module uim.core.storage.file;

import uim.core;

mixin(Version!("test_uim_core"));
@safe:

// #region CREATE
void createFilesInPath(string path, string[] filenames) {
  filenames.each!(filename => createFileInPath(path, filename));
}

void createFileInPath(string[] path, string filename) {
  createFileInPath(normalizePath(path), filename);
}

void createFileInPath(string path, string filename) {
  createFile(normalizePath([path, filename]));
}

void createFiles(string[] filenames) {
  filenames.each!(filename => createFile(filename));
}

void createFile(string filename) {
  auto file = File(filename, "w+");
  file.close();
}

unittest {
  createFile(tempDir~"test.txt");
  assert(existsFile(tempDir~"test.txt"));
  removeFile(tempDir~"test.txt");
  assert(!existsFile(tempDir~"test.txt"));

  createFiles([tempDir~"test1.txt", tempDir~"test2.txt", tempDir~"test3.txt"]);
  assert(existsAllFiles([tempDir~"test1.txt", tempDir~"test2.txt", tempDir~"test3.txt"]));
  removeFiles([tempDir~"test1.txt", tempDir~"test2.txt", tempDir~"test3.txt"]);
  assert(!existsAnyFiles([tempDir~"test1.txt", tempDir~"test2.txt", tempDir~"test3.txt"]));
}
// #endregion CREATE

// #region READ
// #region Exists
bool existsAllFiles(string[] paths) {
  return paths.length == 0
    ? false  // Empty array, no files to check
     : paths.all!(path => existsFile(path));
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
        ? exists(normalizePath([path, file])) && isFile(normalizePath([path, file])) 
        : exists(normalizePath([path, file ~ "." ~ ext])) && isFile(normalizePath([path, file ~ "." ~ ext])));
}

unittest {
  version (Windows) {
    assert(existsFile("C:/Windows/System32/cmd.exe"));
    assert(!existsFile("C:/Windows/NotARealFolder/NotARealFile.txt"));

    assert(existsFile("C:/Windows/System32", "cmd.exe"));
    assert(!existsFile("C:/Windows/System32", "NotARealFile.txt"));
    
    assert(existsFile("C:/Windows/System32", "cmd", "exe"));
    assert(!existsFile("C:/Windows/System32", "cmd", "NotARealFile.txt"));

    assert(existsAnyFiles(["C:/Windows/System32/cmd.exe", "C:/Windows/NotARealFolder/NotARealFile.txt"]));
    assert(!existsAnyFiles(["C:/Windows/NotARealFolder/NotFile.txt", "C:/Windows/NotARealFolder/NotARealFile.txt"]));

    assert(existsAllFiles(["C:/Windows/System32/cmd.exe", "C:/Windows/System32/cmd.exe"]));
    assert(!existsAllFiles(["C:/Windows/NotARealFolder/NotARealFile.txt", "C:/Windows/System32/cmd.exe"]));
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
// #endregion Exists
// #endregion READ

// #region UPDATE
// #endregion UPDATE

// #region DELETE
// #region Remove
void removeFilesInPath(string path, string[] filenames) {
  filenames.each!(filename => removeFileInPath(path, filename));
}

void removeFileInPath(string path, string filename) {
  removeFile(normalizePath([path, filename]));
}

void removeFiles(string[] filenames) {
  filenames.each!(filename => removeFile(filename));
}

void removeFile(string[] filepath) {
  removeFile(normalizePath(filepath));
}

void removeFile(string filename) {
  if (filename.isFile) {
    remove(normalizePath([filename]));
  }
}

unittest {
  // TODO: Add unittest for removeFile, removeFiles, removeFileInPath, removeFilesInPath
}
// #endregion Remove
// #endregion DELETE
