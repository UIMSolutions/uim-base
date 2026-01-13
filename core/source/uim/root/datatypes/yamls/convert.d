/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.datatypes.yamls.convert;

import uim.core;
import dyaml;
import std.conv;
import std.exception;

mixin(ShowModule!());

@safe:

/**
 * Convert a YAML Node to a string representation
 * Params:
 *   node = The YAML Node to convert
 * Returns: String representation of the YAML node
 */
string yamlToString(Node node) {
  import dyaml.dumper;
  auto dumper = dumper();
  return dumper.dump(node);
}

/**
 * Convert a YAML Node to a JSON-compatible string
 * Params:
 *   node = The YAML Node to convert
 * Returns: JSON string representation
 */
string yamlToJsonString(Node node) {
  import std.json;
  
  JSONValue convertNodeToJson(Node n) {
    if (n.isScalar) {
      if (n.convertsTo!string) return JSONValue(n.as!string);
      if (n.convertsTo!long) return JSONValue(n.as!long);
      if (n.convertsTo!double) return JSONValue(n.as!double);
      if (n.convertsTo!bool) return JSONValue(n.as!bool);
      return JSONValue(null);
    }
    else if (n.isSequence) {
      JSONValue[] arr;
      foreach (Node item; n) {
        arr ~= convertNodeToJson(item);
      }
      return JSONValue(arr);
    }
    else if (n.isMapping) {
      JSONValue[string] obj;
      foreach (string key, Node value; n) {
        obj[key] = convertNodeToJson(value);
      }
      return JSONValue(obj);
    }
    return JSONValue(null);
  }
  
  return convertNodeToJson(node).toString();
}

/**
 * Convert a YAML Node to an associative array
 * Params:
 *   node = The YAML Node to convert
 * Returns: Associative array representation
 */
string[string] yamlToStringMap(Node node) {
  string[string] result;
  
  if (node.isMapping) {
    foreach (string key, Node value; node) {
      if (value.isScalar) {
        result[key] = value.as!string;
      }
    }
  }
  
  return result;
}

/**
 * Convert a YAML sequence Node to an array
 * Params:
 *   node = The YAML sequence Node to convert
 * Returns: Array of strings
 */
string[] yamlToArray(Node node) {
  string[] result;
  
  if (node.isSequence) {
    foreach (Node item; node) {
      if (item.isScalar) {
        result ~= item.as!string;
      }
    }
  }
  
  return result;
}

/**
 * Convert YAML Node to a specific type
 * Params:
 *   node = The YAML Node to convert
 * Returns: The converted value of type T
 */
T yamlTo(T)(Node node) {
  return node.as!T;
}
