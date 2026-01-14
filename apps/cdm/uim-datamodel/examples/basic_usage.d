module examples.basic_usage;

import datamodel.core.model;
import datamodel.io.reader;
import datamodel.io.writer;
import datamodel.io.formats.format;

void main() {
    // Create a new data model instance
    auto myModel = new DataModel();
    
    // Define some fields
    myModel.addField("name", "string");
    myModel.addField("age", "int");
    
    // Set values
    myModel.setField("name", "John Doe");
    myModel.setField("age", 30);
    
    // Serialize the model to JSON format
    string jsonOutput = serializeToJson(myModel);
    writeln("Serialized JSON: ", jsonOutput);
    
    // Deserialize from JSON format
    auto newModel = deserializeFromJson(jsonOutput);
    writeln("Deserialized Model: ", newModel);
}