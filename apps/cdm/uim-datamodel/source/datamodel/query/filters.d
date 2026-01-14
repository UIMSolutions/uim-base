module datamodel.query.filters;

/**
 * Defines various filters that can be applied to queries.
 */

import datamodel.core.model; // Importing the model for filter definitions

// Example filter interface
interface IFilter {
    bool apply(Model model);
}

// Example filter implementations
class EqualsFilter : IFilter {
    string field;
    string value;

    this(string field, string value) {
        this.field = field;
        this.value = value;
    }

    bool apply(Model model) {
        return model.getField(field) == value;
    }
}

class RangeFilter : IFilter {
    string field;
    int minValue;
    int maxValue;

    this(string field, int minValue, int maxValue) {
        this.field = field;
        this.minValue = minValue;
        this.maxValue = maxValue;
    }

    bool apply(Model model) {
        auto fieldValue = model.getField(field);
        return fieldValue >= minValue && fieldValue <= maxValue;
    }
}

// Additional filters can be defined here as needed.