/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module datamodel.io.importers.data_importer;

import datamodel.io.readers.file_reader;
import datamodel.io.serializers.json_serializer;
import datamodel.io.serializers.csv_serializer;
import datamodel.io.formats.format;
import vibe.data.json;

@safe:

/**
 * Generic data importer
 */
class DataImporter(T) {
  private FileReader _fileReader;
  private DataFormat _format;

  this(DataFormat format = DataFormat.JSON) {
    _fileReader = new FileReader();
    _format = format;
  }

  T[] importFromFile(string filepath) @trusted {
    auto content = _fileReader.read(filepath);
    return importFromString(content);
  }

  T[] importFromString(string content) @trusted {
    final switch (_format) {
      case DataFormat.JSON:
        return importJson(content);
      case DataFormat.CSV:
        return importCsv(content);
      case DataFormat.XML:
      case DataFormat.YAML:
      case DataFormat.TOML:
      case DataFormat.INI:
      case DataFormat.Binary:
        throw new Exception("Format not yet implemented: " ~ _format.to!string);
    }
  }

  T importSingleFromFile(string filepath) @trusted {
    auto content = _fileReader.read(filepath);
    return importSingleFromString(content);
  }

  T importSingleFromString(string content) @trusted {
    final switch (_format) {
      case DataFormat.JSON:
        auto serializer = new JsonSerializer!T();
        auto json = parseJsonString(content);
        return serializer.deserialize(json);
      case DataFormat.CSV:
        auto items = importCsv(content);
        return items.length > 0 ? items[0] : T.init;
      case DataFormat.XML:
      case DataFormat.YAML:
      case DataFormat.TOML:
      case DataFormat.INI:
      case DataFormat.Binary:
        throw new Exception("Format not yet implemented");
    }
  }

  private T[] importJson(string content) @trusted {
    auto serializer = new JsonArraySerializer!T();
    auto json = parseJsonString(content);
    return serializer.deserializeArray(json);
  }

  private T[] importCsv(string content) {
    auto serializer = new CsvSerializer!T();
    return serializer.deserialize(content);
  }
}

/**
 * Import result with statistics
 */
struct ImportResult(T) {
  T[] items;
  size_t totalCount;
  size_t successCount;
  size_t failureCount;
  string[] errors;
  
  bool isSuccess() const {
    return failureCount == 0;
  }
}

/**
 * Batch importer with error handling
 */
class BatchImporter(T) {
  private DataImporter!T _importer;

  this(DataFormat format = DataFormat.JSON) {
    _importer = new DataImporter!T(format);
  }

  ImportResult!T importBatch(string[] filepaths) @trusted {
    ImportResult!T result;
    
    foreach (filepath; filepaths) {
      try {
        auto items = _importer.importFromFile(filepath);
        result.items ~= items;
        result.successCount += items.length;
      } catch (Exception e) {
        result.failureCount++;
        result.errors ~= filepath ~ ": " ~ e.msg;
      }
    }
    
    result.totalCount = result.successCount + result.failureCount;
    return result;
  }
}