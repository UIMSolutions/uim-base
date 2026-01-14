module tests.serialization.serializer_test;

import std.stdio;
import datamodel.serialization.serializer; // Import the serializer module
import datamodel.core.model; // Import the model module for testing
import std.array : array;

void main() {
    // Example test case for serializing a data model
    auto model = new DataModel(); // Assuming DataModel is defined in model.d
    model.set("name", "Test Model");
    model.set("version", 1);

    // Serialize the model to JSON format
    auto jsonOutput = Serializer.serializeToJson(model);
    writeln("Serialized JSON: ", jsonOutput);

    // Add assertions to validate the output
    assert(jsonOutput == "{\"name\":\"Test Model\",\"version\":1}");

    // Additional test cases can be added here
}