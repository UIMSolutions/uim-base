module datamodel.core.validation;

import std.exception : enforce;
import std.array : array;

/**
 * Validation rules for data models.
 */
class Validator {
    // Validates that a string is not empty
    static void validateNonEmpty(string value, string fieldName) {
        enforce(!value.empty, fieldName ~ " cannot be empty.");
    }

    // Validates that a number is within a specified range
    static void validateRange(int value, int min, int max, string fieldName) {
        enforce(value >= min && value <= max, fieldName ~ " must be between " ~ to!string(min) ~ " and " ~ to!string(max) ~ ".");
    }

    // Validates that a value matches a specific pattern (e.g., regex)
    static void validatePattern(string value, regex pattern, string fieldName) {
        enforce(value.match(pattern), fieldName ~ " does not match the required pattern.");
    }

    // Validates that a collection is not empty
    static void validateNonEmptyCollection(T)(T[] collection, string fieldName) {
        enforce(collection.length > 0, fieldName ~ " cannot be empty.");
    }
}