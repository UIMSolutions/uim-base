# Data Model I/O Library

A comprehensive library for reading, writing, and transforming common data model files in D and vibe.d.

## Features

### File Operations

- **FileReader**: Read text and binary files
- **FileWriter**: Write with automatic directory creation
- **ChunkedFileReader**: Process large files in chunks
- **BufferedFileWriter**: Buffered writing for better performance

### Supported Formats

- **JSON**: Full support with pretty printing
- **CSV**: With custom delimiters and quoting
- **XML**: Planned
- **YAML**: Planned
- **TOML**: Planned
- **Binary**: Planned

### Serialization

- **JsonSerializer**: Generic JSON serialization
- **JsonArraySerializer**: Array serialization
- **CsvSerializer**: CSV with headers and escaping

### Import/Export

- **DataImporter**: Import from files or strings
- **DataExporter**: Export with formatting options
- **BatchImporter**: Bulk import with error handling
- **AdvancedExporter**: Export with backup and options

### Transformation

- **DataTransformer**: Transform between types
- **DataFilter**: Filter data with predicates
- **Format Conversion**: Convert between formats

## Quick Start

### Installation

Add to your `dub.json`:

```json
{
  "dependencies": {
    "data-model-io": "*"
  }
}
```

### Basic Usage

#### Import/Export JSON

```d
import datamodel.io;

struct User {
  string id;
  string username;
  string email;
  int age;
}

// Export to JSON
auto exporter = new DataExporter!User(DataFormat.JSON);
User[] users = [...];
exporter.exportToFile(users, "users.json");

// Import from JSON
auto importer = new DataImporter!User(DataFormat.JSON);
auto importedUsers = importer.importFromFile("users.json");
```

#### Import/Export CSV

```d
// Export to CSV
auto csvExporter = new DataExporter!User(DataFormat.CSV);
csvExporter.exportToFile(users, "users.csv");

// Import from CSV
auto csvImporter = new DataImporter!User(DataFormat.CSV);
auto importedUsers = csvImporter.importFromFile("users.csv");
```

#### Data Transformation

```d
// Transform User to Product
auto transformer = new DataTransformer!(User, Product)(
  (User user) => Product(
    user.id,
    "Product-" ~ user.username,
    user.age * 10.0
  )
);

auto products = transformer.transform(users);

// Transform and export in one step
transformer.transformFile(
  "users.json",
  "products.json",
  DataFormat.JSON,
  DataFormat.JSON
);
```

#### Filtering

```d
// Filter users by age
auto filter = new DataFilter!User((User u) => u.age >= 30);
auto filteredUsers = filter.filter(users);
```

#### Batch Import

```d
auto batchImporter = new BatchImporter!User(DataFormat.JSON);
auto result = batchImporter.importBatch([
  "users1.json",
  "users2.json",
  "users3.json"
]);

writeln("Success: ", result.successCount);
writeln("Failures: ", result.failureCount);
foreach (error; result.errors) {
  writeln(error);
}
```

#### Advanced Export with Options

```d
auto options = ExportOptions(
  prettyPrint: true,
  createBackup: true,
  backupSuffix: ".bak",
  overwrite: true
);

auto exporter = new AdvancedExporter!User(DataFormat.JSON, options);
exporter.export_(users, "users.json");
```

## CSV Options

```d
auto csvOptions = CsvOptions(
  separator: ',',
  quote: '"',
  includeHeader: true
);

auto serializer = new CsvSerializer!User(csvOptions);
```

## Format Detection

```d
// Auto-detect from filename
auto format = FormatDetector.detectFromFilename("data.json");

// Auto-detect from content
auto format = FormatDetector.detectFromContent(content);
```

## Large File Handling

```d
// Chunked reading for large files
auto reader = new ChunkedFileReader(4096);
reader.readChunks("large_file.txt", (chunk) {
  // Process chunk
});

// Buffered writing
auto writer = new BufferedFileWriter("output.txt", 100);
foreach (line; lines) {
  writer.writeLine(line);
}
writer.flush();
```

## Running Examples

```bash
cd libs/data-model-io
dub run data-model-io:examples
```

## API Reference

### DataImporter!T

- `T[] importFromFile(string filepath)`
- `T[] importFromString(string content)`
- `T importSingleFromFile(string filepath)`
- `T importSingleFromString(string content)`

### DataExporter!T

- `void exportToFile(T[] items, string filepath)`
- `string exportToString(T[] items)`
- `void exportSingleToFile(T item, string filepath)`
- `string exportSingleToString(T item)`

### DataTransformer!(TSource, TTarget)

- `TTarget[] transform(TSource[] items)`
- `void transformFile(string input, string output, DataFormat inFmt, DataFormat outFmt)`

### DataFilter!T

- `T[] filter(T[] items)`

## License

Apache 2.0

## Contributing

Contributions welcome! Please ensure code follows the existing style and includes tests.
