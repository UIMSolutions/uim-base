/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module datamodel.io.writers.file_writer;

import std.file;
import std.stdio;
import std.path;

@safe:

/**
 * Generic file writer interface
 */
interface IFileWriter {
  void write(string filepath, string content);
  void writeBinary(string filepath, ubyte[] data);
  void append(string filepath, string content);
}

/**
 * File writer implementation
 */
class FileWriter : IFileWriter {
  private bool _createDirectories;

  this(bool createDirectories = true) {
    _createDirectories = createDirectories;
  }

  void write(string filepath, string content) @trusted {
    ensureDirectory(filepath);
    std.file.write(filepath, content);
  }

  void writeBinary(string filepath, ubyte[] data) @trusted {
    ensureDirectory(filepath);
    std.file.write(filepath, data);
  }

  void append(string filepath, string content) @trusted {
    ensureDirectory(filepath);
    std.file.append(filepath, content);
  }

  private void ensureDirectory(string filepath) @trusted {
    if (_createDirectories) {
      auto dir = dirName(filepath);
      if (!exists(dir)) {
        mkdirRecurse(dir);
      }
    }
  }
}

/**
 * Buffered file writer for better performance
 */
class BufferedFileWriter {
  private File _file;
  private string[] _buffer;
  private size_t _bufferSize;

  this(string filepath, size_t bufferSize = 100) @trusted {
    _file = File(filepath, "w");
    _bufferSize = bufferSize;
  }

  ~this() @trusted {
    flush();
    _file.close();
  }

  void writeLine(string line) {
    _buffer ~= line;
    if (_buffer.length >= _bufferSize) {
      flush();
    }
  }

  void flush() @trusted {
    foreach (line; _buffer) {
      _file.writeln(line);
    }
    _buffer.length = 0;
  }
}