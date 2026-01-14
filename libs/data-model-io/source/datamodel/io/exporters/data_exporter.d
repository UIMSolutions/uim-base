/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module datamodel.io.exporters.data_exporter;

import datamodel.io.writers.file_writer;
import datamodel.io.serializers.json_serializer;
import datamodel.io.serializers.csv_serializer;
import datamodel.io.formats.format;
import std.conv;

@safe:

/**
 * Generic data exporter
 */
class DataExporter(T) {
  private FileWriter _fileWriter;
  private DataFormat _format;
  private bool _prettyPrint;

  this(DataFormat format = DataFormat.JSON, bool prettyPrint = true) {
    _fileWriter = new FileWriter();
    _format = format;
    _prettyPrint = prettyPrint;
  }

  void exportToFile(T[] items, string filepath) @trusted {
    auto content = exportToString(items);
    _fileWriter.write(filepath, content);
  }

  string exportToString(T[] items) @trusted {
    final switch (_format) {
      case DataFormat.JSON:
        return exportJson(items);
      case DataFormat.CSV:
        return exportCsv(items);
      case DataFormat.XML:
      case DataFormat.YAML:
      case DataFormat.TOML:
      case DataFormat.INI:
      case DataFormat.Binary:
        throw new Exception("Format not yet implemented: " ~ _format.to!string);
    }
  }

  void exportSingleToFile(T item, string filepath) @trusted {
    auto content = exportSingleToString(item);
    _fileWriter.write(filepath, content);
  }

  string exportSingleToString(T item) @trusted {
    final switch (_format) {
      case DataFormat.JSON:
        auto serializer = new JsonSerializer!T();
        return serializer.serializeToString(item, _prettyPrint);
      case DataFormat.CSV:
        auto serializer = new CsvSerializer!T();
        return serializer.serialize([item]);
      case DataFormat.XML:
      case DataFormat.YAML:
      case DataFormat.TOML:
      case DataFormat.INI:
      case DataFormat.Binary:
        throw new Exception("Format not yet implemented");
    }
  }

  private string exportJson(T[] items) @trusted {
    auto serializer = new JsonArraySerializer!T();
    return serializer.serializeArrayToString(items, _prettyPrint);
  }

  private string exportCsv(T[] items) {
    auto serializer = new CsvSerializer!T();
    return serializer.serialize(items);
  }
}

/**
 * Export options
 */
struct ExportOptions {
  bool prettyPrint = true;
  bool createBackup = false;
  string backupSuffix = ".bak";
  bool overwrite = true;
}

/**
 * Advanced exporter with options
 */
class AdvancedExporter(T) {
  private DataExporter!T _exporter;
  private ExportOptions _options;

  this(DataFormat format, ExportOptions options = ExportOptions.init) {
    _exporter = new DataExporter!T(format, options.prettyPrint);
    _options = options;
  }

  void export_(T[] items, string filepath) @trusted {
    import std.file : exists, copy;
    
    // Create backup if requested
    if (_options.createBackup && exists(filepath)) {
      auto backupPath = filepath ~ _options.backupSuffix;
      copy(filepath, backupPath);
    }

    // Check if file exists and overwrite is disabled
    if (!_options.overwrite && exists(filepath)) {
      throw new Exception("File already exists and overwrite is disabled: " ~ filepath);
    }

    _exporter.exportToFile(items, filepath);
  }
}