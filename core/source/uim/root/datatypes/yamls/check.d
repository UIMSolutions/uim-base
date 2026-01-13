/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.datatypes.yamls.check;

import uim.core;
import dyaml;

mixin(ShowModule!());

@safe:

/**
 * Check if a YAML Node is a scalar
 * Params:
 *   node = The YAML Node to check
 * Returns: true if the node is a scalar, false otherwise
 */
bool isYamlScalar(Node node) {
  return node.isScalar;
}

/**
 * Check if a YAML Node is a sequence (array)
 * Params:
 *   node = The YAML Node to check
 * Returns: true if the node is a sequence, false otherwise
 */
bool isYamlSequence(Node node) {
  return node.isSequence;
}

/**
 * Check if a YAML Node is a mapping (object)
 * Params:
 *   node = The YAML Node to check
 * Returns: true if the node is a mapping, false otherwise
 */
bool isYamlMapping(Node node) {
  return node.isMapping;
}

/**
 * Check if a YAML Node is null
 * Params:
 *   node = The YAML Node to check
 * Returns: true if the node is null, false otherwise
 */
bool isYamlNull(Node node) {
  return node.isNull;
}

/**
 * Check if a YAML string is valid
 * Params:
 *   yamlString = The YAML string to validate
 * Returns: true if the YAML is valid, false otherwise
 */
bool isValidYaml(string yamlString) {
  try {
    auto loader = Loader.fromString(yamlString);
    loader.load();
    return true;
  }
  catch (Exception e) {
    return false;
  }
}

/**
 * Check if a YAML Node contains a specific key
 * Params:
 *   node = The YAML Node to check
 *   key = The key to look for
 * Returns: true if the key exists, false otherwise
 */
bool hasYamlKey(Node node, string key) {
  if (!node.isMapping) {
    return false;
  }
  
  return node.containsKey(key);
}

/**
 * Check if a YAML Node can be converted to a specific type
 * Params:
 *   node = The YAML Node to check
 * Returns: true if the node can be converted to type T, false otherwise
 */
bool canConvertYamlTo(T)(Node node) {
  return node.convertsTo!T;
}

/**
 * Check if a YAML Node is empty
 * Params:
 *   node = The YAML Node to check
 * Returns: true if the node is empty, false otherwise
 */
bool isYamlEmpty(Node node) {
  if (node.isNull) {
    return true;
  }
  if (node.isSequence && node.length == 0) {
    return true;
  }
  if (node.isMapping && node.length == 0) {
    return true;
  }
  return false;
}
