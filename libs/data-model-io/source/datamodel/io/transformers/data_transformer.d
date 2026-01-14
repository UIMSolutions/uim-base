/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module datamodel.io.transformers.data_transformer;

import datamodel.io.importers.data_importer;
import datamodel.io.exporters.data_exporter;
import datamodel.io.formats.format;

@safe:

/**
 * Data transformation pipeline
 */
class DataTransformer(TSource, TTarget) {
  private TTarget delegate(TSource) @safe _transformFunc;

  this(TTarget delegate(TSource) @safe transformFunc) {
    _transformFunc = transformFunc;
  }

  TTarget[] transform(TSource[] items) {
    TTarget[] result;
    foreach (item; items) {
      result ~= _transformFunc(item);
    }
    return result;
  }

  void transformFile(string inputFile, string outputFile, 
                     DataFormat inputFormat, DataFormat outputFormat) @trusted {
    auto importer = new DataImporter!TSource(inputFormat);
    auto exporter = new DataExporter!TTarget(outputFormat);
    
    auto sourceItems = importer.importFromFile(inputFile);
    auto targetItems = transform(sourceItems);
    exporter.exportToFile(targetItems, outputFile);
  }
}

/**
 * Filter for data items
 */
class DataFilter(T) {
  private bool delegate(T) @safe _filterFunc;

  this(bool delegate(T) @safe filterFunc) {
    _filterFunc = filterFunc;
  }

  T[] filter(T[] items) {
    import std.algorithm : filter;
    import std.array : array;
    
    return items.filter!((item) => _filterFunc(item)).array;
  }
}