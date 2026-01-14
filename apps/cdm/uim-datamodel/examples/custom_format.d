module examples.custom_format;

import datamodel.io.formats.FormatDetector;
import std.stdio;

void main() {
    // Example filename for demonstration
    string filename = "data/custom_data.yaml";

    // Detect format from filename
    try {
        auto format = FormatDetector.detectFromFilename(filename);
        writeln("Detected format from filename: ", format);
    } catch (Exception e) {
        writeln(e.msg);
    }

    // Example content for demonstration
    string content = "---\nname: John Doe\nage: 30\n";

    // Detect format from content
    try {
        auto formatFromContent = FormatDetector.detectFromContent(content);
        writeln("Detected format from content: ", formatFromContent);
    } catch (Exception e) {
        writeln(e.msg);
    }
}