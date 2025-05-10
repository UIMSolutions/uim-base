/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos;

public {
  import std.algorithm;
  import std.array;
  import std.ascii;
  import std.base64;
  import std.bigint;
  import std.bitmanip;
  import std.checkedint;
  import std.compiler;
  import std.complex;
  import std.concurrency;
  import std.container;
  import std.conv;
  import std.csv;
  import std.datetime;
  import std.demangle;
  import std.digest;
  import std.encoding;
  import std.exception;
  import std.file;
  import std.format;
  import std.file;
  import std.format;
  import std.getopt;
  import std.logger;
  import std.math;
  import std.path;
  import std.range;
  import std.regex;
  import std.stdint;
  import std.stdio;
  import std.string;
  import std.traits;
  import std.typecons;
  import std.uni;
  import std.utf;
  import std.uuid;
  import std.zip;
}

public {
  import uim.phobos.algorithm;
  import uim.phobos.array;
  import uim.phobos.ascii;
  import uim.phobos.base64;
  import uim.phobos.bigint;
  import uim.phobos.bitmanip;
  import uim.phobos.checkedint;
  import uim.phobos.compiler;
  import uim.phobos.complex;
  import uim.phobos.concurrency;
  import uim.phobos.constants;
  import uim.phobos.containers;
  import uim.phobos.convert;
  import uim.phobos.csv;
  import uim.phobos.datatypes;
  import uim.phobos.datetime;
  import uim.phobos.demangle;
  import uim.phobos.digest;
  import uim.phobos.enumerations;
  import uim.phobos.logger;
  import uim.phobos.file;
  import uim.phobos.format;
  import uim.phobos.interfaces;
  import uim.phobos.math;
  import uim.phobos.meta;
  import uim.phobos.mixins;
  import uim.phobos.net;
  import uim.phobos.path;
  import uim.phobos.random;
  import uim.phobos.range;
  import uim.phobos.regex;
  import uim.phobos.signals;
  import uim.phobos.socket;
  import uim.phobos.stdint;
  import uim.phobos.stdio;
  import uim.phobos.strings;
  import uim.phobos.system;
  import uim.phobos.traits;
  import uim.phobos.utf;
  import uim.phobos.uni;
  import uim.phobos.uuids;
  import uim.phobos.variants;
  import uim.phobos.windows;
  import uim.phobos.zip;
  import uim.phobos.zlib;
}

template Version(string name) {
  const char[] Version = `
version (`~name~`) {
  import std.stdio;
  import std.string;

  unittest {
    string mod = leftJustify(__MODULE__, 50, ' ');
    writeln("-----  ", mod, " -----");
  }
}  
`;
}
