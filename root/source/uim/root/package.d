module uim.root;

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
  import uim.root.collections;
  import uim.root.datatypes;
}

template Version(string name) {
  const char[] Version = `
version (`
    ~ name ~ `) {
  import std.stdio;
  import std.string;

  unittest {
    string mod = leftJustify(__MODULE__, 50, ' ');
    writeln("-----  ", mod, " -----");
  }
}  
`;
}
