module css.examples.example;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
import std.stdio;
import uim.css;

void main() {
    writeln("=== CSS Library Example ===\n");
    
    // Example 1: Building CSS using the fluent builder
    writeln("1. Building CSS with fluent API:");
    auto builder = css()
        .rule("body")
            .margin("0")
            .padding("0")
            .fontWeight("Segoe UI, sans-serif")
            .fontSize("16px")
            .color("#333")

































































































































}    writeln("=== Example Complete ===");        writeln();    writeln(responsive.toString());            .endMedia();            .endRule()                .property("grid-template-columns", "1fr")            .rule(".grid")        .media("screen", ["max-width: 480px"])        .endMedia()            .endRule()                .property("gap", "10px")                .property("grid-template-columns", "repeat(2, 1fr)")            .rule(".grid")        .media("screen", ["max-width: 768px"])        .endMedia()            .endRule()                .property("grid-template-columns", "repeat(3, 1fr)")            .rule(".grid")        .media("screen", ["max-width: 1200px"])        .endRule()            .property("gap", "20px")            .property("grid-template-columns", "repeat(4, 1fr)")            .display("grid")        .rule(".grid")    auto responsive = css()    writeln("5. Complex responsive design:");    // Example 5: Complex responsive design        writeln();    writeln(varSheet.toString());            .endRule();            .property("margin", "var(--spacing)")            .property("color", "var(--primary-color)")        .rule(".theme-element")        .variable("spacing", "1rem")        .variable("secondary-color", "#6c757d")        .variable("primary-color", "#007bff")    auto varSheet = css()    writeln("4. CSS Variables:");    // Example 4: CSS Variables        }        writeln();        writeln(rule.toString());        writeln("Modified rule:");                rule.setProperty("border", "1px solid #ccc");        rule.setProperty("background-color", "#f0f0f0");        // Add new properties                writeln();        writeln(rule.toString());        writeln("Original rule:");        auto rule = rules[0];    if (rules.length > 0) {    auto rules = sheet.findRules(".box");    // Find and modify a rule        auto sheet = parseCSS(".box { width: 100px; height: 100px; }");    writeln("3. Manipulating parsed CSS:");    // Example 3: Manipulating CSS        writeln();    writeln(stylesheet.toString());    writeln("Parsed stylesheet:");    auto stylesheet = parseCSS(cssCode);        `;        }            }                margin: 5px;                padding: 10px;            .card {        @media (max-width: 600px) {                }            margin-bottom: 10px;            font-weight: bold;            font-size: 20px;        .card-title {                }            box-shadow: 0 2px 4px rgba(0,0,0,0.1);            background-color: white;            margin: 10px;            padding: 15px;            border-radius: 8px;            border: 1px solid #ddd;        .card {                }            font-family: Arial, sans-serif;            color: #2c3e50;        h1, h2 {        /* Main styles */    string cssCode = `    writeln("2. Parsing existing CSS:");    // Example 2: Parsing existing CSS        writeln();    writeln(builder.toString());            .endMedia();            .endRule()                .padding("10px")                .width("100%")            .rule(".container")        .media("screen", ["max-width: 768px"])        .endRule()            .backgroundColor("#0056b3")        .rule(".button:hover")        .endRule()            .property("cursor", "pointer")            .borderRadius("4px")            .border("none")            .color("#fff")            .backgroundColor("#007bff")            .padding("10px 20px")            .display("inline-block")        .rule(".button", ".btn")        .endRule()            .padding("20px")            .margin("0 auto")            .width("1200px")        .endRule()
        .rule(".container")