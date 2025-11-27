module uim.oop.exceptions.tests.test_exception;

import uim.oop;

@safe:

unittest {
    // Test: messageTemplates sets multiple templates
    auto ex = new UIMException;
    ex.messageTemplates(["error": "Error: %s", "warning": "Warning: %s"]);
    assert(ex.messageTemplate("error") == "Error: %s");
    assert(ex.messageTemplate("warning") == "Warning: %s");
}

unittest {
    // Test: messageTemplates overwrites existing templates
    auto ex = new UIMException;
    ex.messageTemplate("info", "Old info");
    ex.messageTemplates(["info": "New info", "debug": "Debug: %s"]);
    assert(ex.messageTemplate("info") == "New info");
    assert(ex.messageTemplate("debug") == "Debug: %s");
}

unittest {
    // Test: messageTemplates with empty map
    auto ex = new UIMException;
    ex.messageTemplate("test", "Test message");
    ex.messageTemplates(null);
    // Should clear or set to empty
}

unittest {
    // Test: messageTemplates preserves duplicates
    auto ex = new UIMException;
    string[string] templates = ["key1": "value1", "key2": "value2"];
    ex.messageTemplates(templates);
    templates["key1"] = "modified";
    // Verify original is not affected due to .dup
    assert(ex.messageTemplate("key1") == "value1");
}

unittest {
    // Test: messageTemplates with special characters
    auto ex = new UIMException;
    ex.messageTemplates(["special": "Error with %s and %d", "unicode": "Ошибка: %s"]);
    assert(ex.messageTemplate("special") == "Error with %s and %d");
    assert(ex.messageTemplate("unicode") == "Ошибка: %s");
}