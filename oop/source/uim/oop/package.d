module uim.oop;

mixin(Version!"test_uim_oop");

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

// UIM libraries
public import uim.core;

public {
  import uim.oop.configurations;
  import uim.oop.collections;
  import uim.oop.containers;
  import uim.oop.containers.maps;
  import uim.oop.direntries;
  import uim.oop.enumerations;
  import uim.oop.exceptions;
  import uim.oop.factories;
  import uim.oop.formatters;
  import uim.oop.interfaces;
  import uim.oop.mixins;
  import uim.oop.patterns;
  import uim.oop.parsers;
  import uim.oop.registries;
  import uim.oop.tests;
  import uim.oop.validators;
}

