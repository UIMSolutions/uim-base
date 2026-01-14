module datamodel.io.formats.format;

@safe:

/**
 * Supported data model formats
 */
enum DataFormat {
  JSON,
  XML,
  YAML,
  CSV,
  TOML,
  INI,
  Binary
}

/**
 * Format detector based on file extension or content
 */
class FormatDetector {
  static DataFormat detectFromFilename(string filename) {
    import std.path : extension;
    import std.string : toLower;
    
    auto ext = extension(filename).toLower;
    
    switch (ext) {
      case ".json": return DataFormat.JSON;
      case ".xml": return DataFormat.XML;
      case ".yaml":
      case ".yml": return DataFormat.YAML;
      case ".csv": return DataFormat.CSV;
      case ".toml": return DataFormat.TOML;
      case ".ini": return DataFormat.INI;
      case ".bin":
      case ".dat": return DataFormat.Binary;
      default: throw new Exception("Unknown file format: " ~ ext);
    }
  }

  static DataFormat detectFromContent(string content) {
    import std.string : strip, startsWith;
    
    auto trimmed = content.strip();
    
    if (trimmed.startsWith("{") || trimmed.startsWith("[")) {
      return DataFormat.JSON;
    } else if (trimmed.startsWith("<")) {
      return DataFormat.XML;
    } else if (trimmed.startsWith("---")) {
      return DataFormat.YAML;
    }
    
    return DataFormat.JSON; // Default
  }
}