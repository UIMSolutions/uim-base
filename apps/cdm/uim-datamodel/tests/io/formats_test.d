module uim.datamodel.tests.io.formats_test;

import datamodel.io.formats.format;
import std.stdio;
import std.exception;

void main() {
    // Test format detection from filename
    assert(FormatDetector.detectFromFilename("data.json") == DataFormat.JSON);
    assert(FormatDetector.detectFromFilename("data.xml") == DataFormat.XML);
    assert(FormatDetector.detectFromFilename("data.yaml") == DataFormat.YAML);
    assert(FormatDetector.detectFromFilename("data.csv") == DataFormat.CSV);
    assert(FormatDetector.detectFromFilename("data.toml") == DataFormat.TOML);
    assert(FormatDetector.detectFromFilename("data.ini") == DataFormat.INI);
    assert(FormatDetector.detectFromFilename("data.bin") == DataFormat.Binary);
    assert(FormatDetector.detectFromFilename("data.dat") == DataFormat.Binary);
    
    // Test format detection from content
    assert(FormatDetector.detectFromContent("{ \"key\": \"value\" }") == DataFormat.JSON);
    assert(FormatDetector.detectFromContent("<root></root>") == DataFormat.XML);
    assert(FormatDetector.detectFromContent("---\nkey: value") == DataFormat.YAML);
    
    // Test unknown format exception
    try {
        FormatDetector.detectFromFilename("data.unknown");
        assert(false); // Should not reach here
    } catch (Exception e) {
        writeln("Caught expected exception: ", e.msg);
    }
    
    writeln("All tests passed!");
}