module uim.io.classes.outputs.formatters.helpers.tests;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

bool testOutputFormatter(DOutputFormatter formatter) {
    // Test the formatter's initialization
    if (!formatter.initialize()) {
        return false;
    }

    // Additional tests can be added here as needed
    return true;
}