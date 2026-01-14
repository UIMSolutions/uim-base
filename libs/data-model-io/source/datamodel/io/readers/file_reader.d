/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module datamodel.io.readers.file_reader;

import std.file;
import std.stdio;

@safe:

/**
 * Generic file reader interface
 */
interface IFileReader {
  string read(string filepath);
  ubyte[] readBinary(string filepath);
  bool exists(string filepath);
}

/**
 * File reader implementation
 */
class FileReader : IFileReader {
  string read(string filepath) @trusted {
    if (!exists(filepath)) {
      throw new Exception("File not found: " ~ filepath);
    }
    return readText(filepath);
  }

  ubyte[] readBinary(string filepath) @trusted {
    if (!exists(filepath)) {
      throw new Exception("File not found: " ~ filepath);
    }
    return cast(ubyte[])std.file.read(filepath);
  }

  bool exists(string filepath) @trusted {
    return std.file.exists(filepath);
  }
}

/**
 * Chunked file reader for large files
 */
class ChunkedFileReader {
  private size_t _chunkSize;

  this(size_t chunkSize = 4096) {
    _chunkSize = chunkSize;
  }

  void readChunks(string filepath, void delegate(string chunk) @safe callback) @trusted {
    auto file = File(filepath, "r");
    scope(exit) file.close();

    char[] buffer = new char[_chunkSize];
    
    while (!file.eof()) {
      auto chunk = file.rawRead(buffer);
      if (chunk.length > 0) {
        callback(chunk.idup);
      }
    }
  }
}