/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.storage.path;

import uim.core;
mixin(Version!("test_uim_core"));

@safe:

// #region CREATE
// #endregion CREATE

// #region READ
// #region exists
  // #region Path 
    bool existsPath(string[] path) {
      return exists(buildPath(path));
    }

    bool existsPath(string path) {
      return exists(path);
    }
  // #endregion Path 


  unittest {
    version(Windows) {
      assert(existsPath("C:/Windows"));
      assert(!existsPath("C:/Windows/NotARealFolder"));
    }
    version(Linux) {
      assert(existsPath("/usr/bin"));
      assert(!existsPath("/usr/bin/NotARealFolder"));
    }
    version(MacOS) {
      assert(existsPath("/usr/bin"));
      assert(!existsPath("/usr/bin/NotARealFolder"));
    }
  }
// #region exists

// #region Times
SysTime lastAccessTime(string path) {
  SysTime accessTime, modificationTime;
  getTimes(path, accessTime, modificationTime);
  return accessTime;
}

SysTime lastModificationTime(string path) {
  SysTime accessTime, modificationTime;
  getTimes(path, accessTime, modificationTime);
  return modificationTime;
}

unittest {
  version(Windows) {
    assert(lastAccessTime("C:/Windows/System32/cmd.exe") != SysTime.init);
    assert(lastModificationTime("C:/Windows/System32/cmd.exe") != SysTime.init);
  }
}
// #endregion Times

// #region Age
/* SysTime lastAccessAge(string path) {
  auto currTime = Clock.currTime();

  SysTime accessTime, modificationTime;
  getTimes(path, accessTime, modificationTime);
  return accessTime;
}

SysTime lastModificationAge(string path) {
  return lastModificationTime(path) - Clock.currTime();
} */
// #endregion Times

auto dirEntryInfos(string aPath) {
  debug writeln(__MODULE__ ~ " - dirEntryInfos(path: %s)".format(aPath));

  DirEntry[] results;
  /* bool dirEntryInfo(FileInfo info) { 
    debug writeln(__MODULE__~" - Info %s".format(info));
    results ~= info; return true; 
  }

  debug writeln(__MODULE__~" - listDirectory(aPath, &dirEntryInfo))");
  listDirectory(aPath, &dirEntryInfo);

  debug writeln(__MODULE__~" - Results %s)".format(results)); */
  return results;
}

// read directories (subfolders) in path 
auto dirNames(string aPath, bool aFullName = false) {
  debug writeln(__MODULE__ ~ " - dirNames(string %s, bool fullName = false)".format(aPath));

  string[] results;
  /* string[] results = dirEntryInfos(aPath).filter!(a => a.isDirectory).map!(a => a.name).array;
  if (aFullName) results = results.map!(a => aPath~"/"~a).array;
 */

  foreach (string name; dirEntries(aPath, SpanMode.breadth)) {
    writeln(name);
  }

  debug writeln(__MODULE__ ~ " - Results %s)".format(results));
  return results;
}

// read links in path 
auto linkNames(string path, bool aFullName = false) {
  string[] results = dirEntryInfos(path).filter!(a => a.isSymlink)
    .map!(a => a.name)
    .array;
  if (aFullName)
    results = results.map!(a => path ~ "/" ~ a).array;
  return results;
}

// read filenames in path 
auto fileNames(string aPath, bool aFullName = false) {
  string[] results = dirEntryInfos(aPath).filter!(a => a.isFile)
    .map!(a => a.name)
    .array;
  if (aFullName)
    results = results.map!(a => aPath ~ "/" ~ a).array;
  return results;
}

unittest {
  /*   debug writeln("1");  
  debug writeln(dirNames("."));
  debug writeln("2");  
  debug writeln(dirNames(".", true));
  debug writeln("3");   */
}
// #endregion READ

