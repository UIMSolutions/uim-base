/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.consoles.helpers.mixins;

import uim.io;

@safe:
string consoleThis(string name = null, bool overrideMemberNames = true) {
  string fullName = name ~ "Console";
  return objThis(fullName, overrideMemberNames);
}

template ConsoleThis(string name = null, bool overrideMemberNames = true) {
  const char[] ConsoleThis = consoleThis(name, overrideMemberNames);
}

string consoleCalls(string name) {
  string fullName = name ~ "Console";
  return objCalls(fullName);
}

unittest {
  assert(consoleCalls("Test") == objCalls("TestConsole"));
}

template ConsoleCalls(string name) {
  const char[] ConsoleCalls = consoleCalls(name);
}
