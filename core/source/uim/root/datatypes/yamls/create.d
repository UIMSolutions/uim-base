/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.datatypes.yamls.create;

import uim.core;
import dyaml;
import std.conv;

mixin(ShowModule!());

@safe:

/**
 * Create a YAML Node from a key-value pair
 * Params:
 *   key = The key for the mapping
 *   value = The value for the mapping
 * Returns: A dyaml Node representing a mapping
 */
Node createYaml(K, V)(K key, V value) {
  Node[string] mapping;
  mapping[key.to!string] = Node(value);
  return Node(mapping);
}

/**
 * Create a YAML Node from an associative array
 * Params:
 *   data = Associative array to convert to YAML
 * Returns: A dyaml Node representing the data
 */
Node createYaml(V)(V[string] data) {
  Node[string] mapping;
  foreach (key, value; data) {
    mapping[key] = Node(value);
  }
  return Node(mapping);
}

/**
 * Create a YAML Node from an array
 * Params:
 *   data = Array to convert to YAML
 * Returns: A dyaml Node representing the array
 */
Node createYaml(T)(T[] data) {
  Node[] sequence;
  foreach (item; data) {
    sequence ~= Node(item);
  }
  return Node(sequence);
}

/**
 * Create an empty YAML mapping Node
 * Returns: An empty dyaml Node of mapping type
 */
Node createEmptyYamlMapping() {
  Node[string] mapping;
  return Node(mapping);
}

/**
 * Create an empty YAML sequence Node
 * Returns: An empty dyaml Node of sequence type
 */
Node createEmptyYamlSequence() {
  Node[] sequence;
  return Node(sequence);
}

/**
 * Create a YAML scalar Node
 * Params:
 *   value = The scalar value
 * Returns: A dyaml Node representing the scalar value
 */
Node createYamlScalar(T)(T value) {
  return Node(value);
}
