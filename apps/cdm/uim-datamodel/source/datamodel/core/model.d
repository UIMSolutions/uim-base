module datamodel.core.model;

import std.array : array;
import std.string : toString;
import std.json : Json;
import std.exception : enforce;

/**
 * Represents a data model with fields and methods for manipulation.
 */
class DataModel {
    private string name;
    private Json fields;

    this(string name) {
        this.name = name;
        this.fields = Json.array();
    }

    void addField(string fieldName, Json fieldProperties) {
        enforce(fieldName !is null && fieldProperties !is null, "Field name and properties cannot be null.");
        fields.push(Json(fieldName, fieldProperties));
    }

    string getName() const {
        return name;
    }

    Json getFields() const {
        return fields;
    }

    string toJson() const {
        return toString(fields);
    }
}