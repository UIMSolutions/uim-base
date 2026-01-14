/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module examples.usage_example;

import datamodel.io;
import std.stdio;
import std.uuid;

@safe:

// Example data model
struct User {
  string id;
  string username;
  string email;
  int age;
}

struct Product {
  string id;
  string name;
  double price;
  int stock;
}

void main() @trusted {
  // Create sample data
  User[] users = [
    User(randomUUID().toString(), "alice", "alice@example.com", 25),
    User(randomUUID().toString(), "bob", "bob@example.com", 30),
    User(randomUUID().toString(), "charlie", "charlie@example.com", 35)
  ];

  writeln("=== JSON Export/Import Example ===");
  
  // Export to JSON
  auto jsonExporter = new DataExporter!User(DataFormat.JSON, true);
  jsonExporter.exportToFile(users, "users.json");
  writeln("Exported users to users.json");

  // Import from JSON
  auto jsonImporter = new DataImporter!User(DataFormat.JSON);
  auto importedUsers = jsonImporter.importFromFile("users.json");
  writeln("Imported ", importedUsers.length, " users");

  writeln("\n=== CSV Export/Import Example ===");
  
  // Export to CSV
  auto csvExporter = new DataExporter!User(DataFormat.CSV);
  csvExporter.exportToFile(users, "users.csv");
  writeln("Exported users to users.csv");

  // Import from CSV
  auto csvImporter = new DataImporter!User(DataFormat.CSV);
  auto importedUsersFromCsv = csvImporter.importFromFile("users.csv");
  writeln("Imported ", importedUsersFromCsv.length, " users from CSV");

  writeln("\n=== Data Transformation Example ===");
  
  // Transform User to Product (example transformation)
  auto transformer = new DataTransformer!(User, Product)(
    (User user) => Product(
      user.id,
      "Product for " ~ user.username,
      user.age * 10.0,
      user.age
    )
  );

  auto products = transformer.transform(users);
  writeln("Transformed ", products.length, " users to products");

  // Export transformed data
  auto productExporter = new DataExporter!Product(DataFormat.JSON);
  productExporter.exportToFile(products, "products.json");
  writeln("Exported products to products.json");

  writeln("\n=== Filtering Example ===");
  
  // Filter users by age
  auto filter = new DataFilter!User((User u) => u.age >= 30);
  auto filteredUsers = filter.filter(users);
  writeln("Filtered users (age >= 30): ", filteredUsers.length);

  writeln("\n=== Batch Import Example ===");
  
  auto batchImporter = new BatchImporter!User(DataFormat.JSON);
  auto result = batchImporter.importBatch(["users.json", "products.json"]);
  writeln("Batch import - Success: ", result.successCount, ", Failures: ", result.failureCount);
  
  if (result.errors.length > 0) {
    writeln("Errors:");
    foreach (error; result.errors) {
      writeln("  - ", error);
    }
  }

  writeln("\n=== Advanced Export Example ===");
  
  auto exportOptions = ExportOptions(
    true,  // prettyPrint
    true,  // createBackup
    ".bak", // backupSuffix
    true   // overwrite
  );
  
  auto advancedExporter = new AdvancedExporter!User(DataFormat.JSON, exportOptions);
  advancedExporter.export_(users, "users_advanced.json");
  writeln("Advanced export completed with backup");
}