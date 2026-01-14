module datamodel.core.field;

/**
 * Represents a field in a data model.
 */
class Field {
    string name;
    string type;
    bool required;

    this(string name, string type, bool required = false) {
        this.name = name;
        this.type = type;
        this.required = required;
    }

    // Additional methods for field validation and manipulation can be added here
}

/**
 * Represents a specific type of field: StringField.
 */
class StringField : Field {
    this(string name, bool required = false) {
        super(name, "string", required);
    }

    // Add validation methods specific to string fields if needed
}

/**
 * Represents a specific type of field: IntField.
 */
class IntField : Field {
    this(string name, bool required = false) {
        super(name, "int", required);
    }

    // Add validation methods specific to integer fields if needed
}

/**
 * Represents a specific type of field: FloatField.
 */
class FloatField : Field {
    this(string name, bool required = false) {
        super(name, "float", required);
    }

    // Add validation methods specific to float fields if needed
}

/**
 * Represents a specific type of field: BoolField.
 */
class BoolField : Field {
    this(string name, bool required = false) {
        super(name, "bool", required);
    }

    // Add validation methods specific to boolean fields if needed
}