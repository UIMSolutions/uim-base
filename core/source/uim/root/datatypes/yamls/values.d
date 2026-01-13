/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.datatypes.yamls.values;

import uim.core;
import dyaml;
import std.conv;

mixin(ShowModule!());

@safe:

/**
 * Get a value from a YAML Node by key
 * Params:
 *   node = The YAML Node to query
 *   key = The key to retrieve
 * Returns: The value at the specified key
 */
Node getYamlValue(Node node, string key) {
  if (node.isMapping && node.containsKey(key)) {
    return node[key];
  }
  return Node.init;
}

/**
 * Get a value from a YAML Node by key with a default value
 * Params:
 *   node = The YAML Node to query
 *   key = The key to retrieve
 *   defaultValue = The default value to return if key doesn't exist
 * Returns: The value at the specified key or the default value
 */
T getYamlValueOr(T)(Node node, string key, T defaultValue) {
  if (node.isMapping && node.containsKey(key)) {
    auto value = node[key];
    if (value.convertsTo!T) {
      return value.as!T;
    }
  }
  return defaultValue;
}

/**
 * Get a value from a YAML sequence by index
 * Params:
 *   node = The YAML sequence Node
 *   index = The index to retrieve
 * Returns: The value at the specified index
 */
Node getYamlValueAt(Node node, size_t index) {
  if (node.isSequence && index < node.length) {
    return node[index];
  }
  return Node.init;
}

/**
 * Get all keys from a YAML mapping Node
 * Params:
 *   node = The YAML mapping Node
 * Returns: Array of all keys
 */
string[] getYamlKeys(Node node) {
  string[] keys;
  
  if (node.isMapping) {
    foreach (string key, Node value; node) {
      keys ~= key;
    }
  }
  
  return keys;
}

/**
 * Get all values from a YAML mapping Node
 * Params:
 *   node = The YAML mapping Node
 * Returns: Array of all values
 */
Node[] getYamlValues(Node node) {
  Node[] values;
  
  if (node.isMapping) {
    foreach (string key, Node value; node) {
      values ~= value;
    }
  }
  
  return values;
}

/**
 * Get the length/size of a YAML Node
 * Params:
 *   node = The YAML Node
 * Returns: The number of elements in the node
 */
size_t getYamlLength(Node node) {
  if (node.isSequence || node.isMapping) {
    return node.length;
  }
  return 0;
}

/**
 * Get a nested value from a YAML Node using a path
 * Params:
 *   node = The YAML Node to query
 *   path = Array of keys representing the path to the value
 * Returns: The value at the specified path
 */
Node getYamlValueByPath(Node node, string[] path) {
  Node current = node;
  
  foreach (key; path) {
    if (current.isMapping && current.containsKey(key)) {
      current = current[key];
    } else {
      return Node.init;
    }
  }
  
  return current;
}
