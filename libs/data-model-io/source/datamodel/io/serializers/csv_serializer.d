/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module datamodel.io.serializers.csv_serializer;

import std.csv;
import std.array;
import std.conv;
import std.traits;
import std.algorithm;

@safe:

/**
 * CSV serializer options
 */
struct CsvOptions {
  char separator = ',';
  char quote = '"';
  bool includeHeader = true;
}

/**
 * CSV serializer for structs and classes
 */
class CsvSerializer(T) {
  private CsvOptions _options;

  this(CsvOptions options = CsvOptions.init) {
    _options = options;
  }

  string serialize(T[] items) {
    if (items.length == 0) {
      return "";
    }

    auto result = appender!string;

    // Write header
    if (_options.includeHeader) {
      result.put(getHeader());
      result.put("\n");
    }

    // Write rows
    foreach (item; items) {
      result.put(serializeRow(item));
      result.put("\n");
    }

    return result.data;
  }

  T[] deserialize(string csvData) @trusted {
    T[] result;
    
    auto lines = csvData.split("\n").filter!(l => l.length > 0).array;
    if (lines.length == 0) return result;

    size_t startIndex = _options.includeHeader ? 1 : 0;
    
    foreach (line; lines[startIndex .. $]) {
      result ~= deserializeRow(line);
    }

    return result;
  }

  private string getHeader() {
    string[] headers;
    
    static foreach (member; __traits(allMembers, T)) {
      static if (is(typeof(__traits(getMember, T, member)))) {
        headers ~= member;
      }
    }
    
    return headers.join([_options.separator]);
  }

  private string serializeRow(T item) {
    string[] values;
    
    static foreach (member; __traits(allMembers, T)) {
      static if (is(typeof(__traits(getMember, T, member)))) {
        values ~= escapeValue(__traits(getMember, item, member).to!string);
      }
    }
    
    return values.join([_options.separator]);
  }

  private T deserializeRow(string line) @trusted {
    auto values = line.split(_options.separator);
    T item;
    
    size_t index = 0;
    static foreach (member; __traits(allMembers, T)) {
      static if (is(typeof(__traits(getMember, T, member)))) {
        if (index < values.length) {
          alias MemberType = typeof(__traits(getMember, T, member));
          __traits(getMember, item, member) = unescapeValue(values[index]).to!MemberType;
        }
        index++;
      }
    }
    
    return item;
  }

  private string escapeValue(string value) {
    if (value.canFind(_options.separator) || value.canFind(_options.quote) || value.canFind('\n')) {
      return _options.quote ~ value.replace([_options.quote], [_options.quote, _options.quote]) ~ _options.quote;
    }
    return value;
  }

  private string unescapeValue(string value) {
    import std.string : strip;
    value = value.strip();
    
    if (value.length >= 2 && value[0] == _options.quote && value[$-1] == _options.quote) {
      value = value[1 .. $-1];
      value = value.replace([_options.quote, _options.quote], [_options.quote]);
    }
    
    return value;
  }
}