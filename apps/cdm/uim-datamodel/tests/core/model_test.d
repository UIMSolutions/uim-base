module core.model_test;

import datamodel.core.model;
import std.stdio;
import std.array;
import std.exception;

void main() {
    // Example test case for the DataModel class
    try {
        auto model = new DataModel("TestModel");
        model.addField("name", String);
        model.addField("age", int);
        
        // Test setting values
        model.setValue("name", "Alice");
        model.setValue("age", 30);
        
        // Test getting values
        assert(model.getValue("name") == "Alice");
        assert(model.getValue("age") == 30);
        
        // Test invalid field access
        try {
            model.getValue("nonexistentField");
            writeln("Test failed: Expected an exception for nonexistent field.");
        } catch (Exception e) {
            writeln("Caught expected exception: ", e.msg);
        }
        
        writeln("All tests passed!");
    } catch (Exception e) {
        writeln("Test failed: ", e.msg);
    }
}