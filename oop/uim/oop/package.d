﻿module uim.oop;

version (test_uim_oop) {
    import std.stdio;
    unittest {
        writeln("-----  ", __MODULE__, "\t  -----");
    }
}

// Phobos libraries
public {
  import std.array;
  import std.conv;
  import std.datetime;
  import std.file;
  import std.random;
  import std.stdio;
  import std.string;
  import std.uuid;
}

// External libraries
public import vibe.d;

// UIM libraries
public import uim.core;

public {
  import uim.oop.configurations;
  import uim.oop.containers;
  import uim.oop.containers.maps;
  import uim.oop.direntries;
  import uim.oop.enumerations;
  import uim.oop.helpers;
  import uim.oop.formatters;
  import uim.oop.interfaces;
  import uim.oop.mixins;
  import uim.oop.patterns;
  import uim.oop.parsers;
  import uim.oop.simple;
  import uim.oop.tests;
  import uim.oop.tools;
  import uim.oop.validators;
}

template Version(string name) {
  const char[] Version = `
version (`~name~`) {
  import std.stdio;

  unittest {
    writeln("-----  ", __MODULE__, "\t  -----");
  }
}  
`;
}