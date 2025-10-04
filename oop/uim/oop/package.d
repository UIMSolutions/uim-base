/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
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

