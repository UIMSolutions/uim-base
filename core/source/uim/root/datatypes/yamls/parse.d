/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.datatypes.yamls.parse;

import uim.core;
import dyaml;
import std.file;

mixin(ShowModule!());

@safe:

/**
 * Parse a YAML string into a Node
 * Params:
 *   yamlString = The YAML string to parse
 * Returns: A dyaml Node representing the parsed YAML
 */
Node parseYaml(string yamlString) {
  return Loader.fromString(yamlString).load();
}

/**
 * Parse multiple YAML strings into an array of Nodes
 * Params:
 *   yamlStrings = Array of YAML strings to parse
 * Returns: Array of dyaml Nodes
 */
Node[] parseYamls(string[] yamlStrings) {
  Node[] results;
  foreach (yamlStr; yamlStrings) {
    results ~= parseYaml(yamlStr);
  }
  return results;
}

/**
 * Parse a YAML file into a Node
 * Params:
 *   filePath = Path to the YAML file
 * Returns: A dyaml Node representing the parsed YAML file
 */
Node parseYamlFile(string filePath) {
  return Loader.fromFile(filePath).load();
}

/**
 * Parse multiple YAML documents from a single string
 * Params:
 *   yamlString = The YAML string containing multiple documents
 * Returns: Array of dyaml Nodes, one for each document
 */
Node[] parseYamlDocuments(string yamlString) {
  Node[] documents;
  auto loader = Loader.fromString(yamlString);
  foreach (Node doc; loader) {
    documents ~= doc;
  }
  return documents;
}
