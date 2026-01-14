module datamodel.serialization.deserializer;

import datamodel.io.formats.FormatDetector;
import std.json;
import std.xml;
import std.string;

class Deserializer {
    // Deserialize JSON data into a data model
    static T deserializeJson(T)(string jsonData) {
        return parseJSON(jsonData).cast(T);
    }

    // Deserialize XML data into a data model
    static T deserializeXml(T)(string xmlData) {
        return parseXML(xmlData).cast(T);
    }

    // Deserialize data from a string based on its format
    static T deserializeFromString(T)(string data, string format) {
        import std.string : toLower;

        switch (toLower(format)) {
            case "json":
                return deserializeJson!T(data);
            case "xml":
                return deserializeXml!T(data);
            default:
                throw new Exception("Unsupported format: " ~ format);
        }
    }
}