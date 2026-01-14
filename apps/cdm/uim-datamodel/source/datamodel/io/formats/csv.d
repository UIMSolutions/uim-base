module datamodel.io.formats.csv;

import std.array : array;
import std.conv : to;
import std.file : readText;
import std.string : split;
import std.exception : enforce;

/**
 * Function to read CSV data from a file and return it as a 2D array of strings.
 */
string[][] readCSV(string filename) {
    auto content = readText(filename);
    return parseCSV(content);
}

/**
 * Function to parse CSV content from a string and return it as a 2D array of strings.
 */
string[][] parseCSV(string content) {
    auto lines = content.split('\n');
    return lines.map!(line => line.split(',')).array;
}

/**
 * Function to write a 2D array of strings to a CSV file.
 */
void writeCSV(string filename, string[][] data) {
    import std.file : writeText;
    
    auto content = data.map!(row => row.join(",")).join("\n");
    writeText(filename, content);
}

/**
 * Function to convert a 2D array of strings to a CSV formatted string.
 */
string toCSVString(string[][] data) {
    return data.map!(row => row.join(",")).join("\n");
}