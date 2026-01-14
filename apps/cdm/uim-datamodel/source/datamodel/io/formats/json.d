module datamodel.io.formats.json;

import std.json;
import datamodel.io.formats.format; // Importing the DataFormat enum

/**
 * Function to serialize a data model to JSON format.
 * @param model The data model to serialize.
 * @return A JSON string representation of the data model.
 */
string serializeToJson(T)(T model) {
    // Convert the model to a JSON object
    auto jsonObject = JsonObject();
    
    // Assuming the model has a method to get its fields as a key-value pair
    foreach (field; model.getFields()) {
        jsonObject[field.key] = field.value;
    }
    
    return jsonObject.toString();
}

/**
 * Function to deserialize a JSON string into a data model.
 * @param jsonString The JSON string to deserialize.
 * @return The deserialized data model.
 */
T deserializeFromJson(T)(string jsonString) {
    auto jsonObject = parseJSON(jsonString);
    
    // Create a new instance of the model
    T model = new T();
    
    // Assuming the model has a method to set its fields from a key-value pair
    foreach (key, value; jsonObject) {
        model.setField(key, value);
    }
    
    return model;
}