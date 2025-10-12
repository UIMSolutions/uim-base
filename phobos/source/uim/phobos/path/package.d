/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.path;

import uim.phobos;
@safe:

// #region normalizePath
auto normalizePath(string[] path) {
  return buildNormalizedPath(path);
}

unittest {
  version (Windows) {
    assert(normalizePath(["C:", "Windows", "System32"]) == "C:\\Windows\\System32");
    assert(normalizePath(["C:", "Windows", "System32", ""]) == "C:\\Windows\\System32");
    assert(normalizePath(["C:", "Windows", "System32", ".."]) == "C:\\Windows");
    assert(normalizePath(["C:", "Windows", "System32", "..", ".."]) == "C:\\");
    assert(normalizePath(["C:", "Windows", "System32", "..", "..", "."]) == "C:\\");

    assert(normalizePath(["C:\\Windows\\System32\\"]) == "C:\\Windows\\System32");
  }
  version (Linux) {
    assert(normalizePath(["/", "usr", "bin"]) == "/usr/bin");
    assert(normalizePath(["/", "usr", "bin", ""]) == "/usr/bin/");
    assert(normalizePath(["/", "usr", "bin", ".."]) == "/usr/");
    assert(normalizePath(["/", "usr", "bin", "..", ".."]) == "/");
    assert(normalizePath(["/", "usr", "bin", "..", "..", "."]) == "/");

    assert(normalizePath(["/usr/bin/"]) == "/usr/bin");
  }
  version (MacOS) {
    assert(normalizePath(["/", "usr", "bin"]) == "/usr/bin");
    assert(normalizePath(["/", "usr", "bin", ""]) == "/usr/bin/");
    assert(normalizePath(["/", "usr", "bin", ".."]) == "/usr/");
    assert(normalizePath(["/", "usr", "bin", "..", ".."]) == "/");
    assert(normalizePath(["/", "usr", "bin", "..", "..", "."]) == "/");

    assert(normalizePath(["/usr/bin/"]) == "/usr/bin");
  }
}
// #endregion normalizePath