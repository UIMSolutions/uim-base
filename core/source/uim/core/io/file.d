/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.io.file;

import uim.core;
mixin(Version!("test_uim_core"));
@safe:

version (linux) {
  bool copy(string fileName, string fromDir, string toDir, bool createMissingDirs = true, bool overwriteExistingFile = true) {
    if (fileName.length == 0) {
      return false;
    }
    if (fromDir.isEmpty || toDir.isEmpty) {
      return false;
    }

    string from = fromDir;
    if (!from.endsWith('/'))
      from ~= "/";

    if (!exists(from ~ fileName)) {
      return false;
    }

    string to = toDir;
    if (!to.endsWith("/"))
      to ~= "/";

    if (createMissingDirs) {
      if (!exists(from))
        mkdir(from);
      if (!exists(to))
        mkdir(to);
    } else {
      if (!exists(from) || !exists(to)) {
        return false;
      }
    }

    if (!overwriteExistingFile && exists(to ~ fileName)) {
      return false;
    }

    try {
      std.file.copy(from ~ fileName, to ~ fileName);
    } catch (Exception e) {
      return false;
    }

    return true;
  }
}

version (linux) {
  bool move(string fileName, string fromDir, string toDir, bool createMissingDirs = true, bool overwriteExistingFile = true) {
    if (fileName.isEmpty) {
      return false;
    }
    if (fromDir.isEmpty || toDir.isEmpty) {
      return false;
    }

    string from = fromDir;
    if (!from.endsWith("/"))
      from ~= "/";

    if (!exists(from ~ fileName)) {
      return false;
    }

    string to = toDir;
    if (!to.endsWith("/"))
      to ~= "/";

    if (createMissingDirs) {
      if (!exists(from))
        mkdir(from);
      if (!exists(to))
        mkdir(to);
    } else {
      if (!exists(from)) {
        return false;
      }
      if (!exists(to)) {
        return false;
      }
    }

    if (!overwriteExistingFile && exists(to ~ fileName)) {
      return false;
    }

    try {
      fileName.copy(from, to);
    } catch (Exception e) {
      return false;
    }

    try {
      std.file.remove(from ~ fileName);
    } catch (Exception e) {
      return false;
    }

    return true;
  }
}

unittest {
  // Todo
}

