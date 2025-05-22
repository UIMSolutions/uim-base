/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.formatters.console;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

// Debugger formatter for generating output with ANSI escape codes
class DConsoleErrorFormatter : DErrorFormatter {
  mixin(ErrorFormatterThis!("Console"));

  // text colors used in colored output.
  protected STRINGAA styles = [
    // bold yellow
    "const": "1;33",
    // green
    "string": "0;32",
    // bold blue
    "number": "1;34",
    // cyan
    "class": "0;36",
    // grey
    "punct": "0;90",
    // default foreground
    "property": "0;39",
    // magenta
    "visibility": "0;35",
    // red
    "special": "0;31",
  ];

  // Check if the current environment supports ANSI output.
  static bool environmentMatches() {
    /* if (UIM_SAPI != "cli") {
            return false;
        }
        // NO_COLOR in environment means no color.
        if (enviroment("NO_COLOR")) {
            return false;
        }
        // Windows environment checks
        if (
            DIR_SEPARATOR == "\\" &&
            !D_uname("v").lower.contains("windows 10") &&
            !strtolower((string)enviroment("SHELL")).contains("bash.exe") &&
            !(bool)enviroment("ANSICON") &&
            enviroment("ConEmuANSI") != "ON"
       ) {
            return false;
        }
        return true; */
    return false;
  }

  string formatWrapper(string contents, Json[string] locations) {
    string lineInfo = "";
    if (locations.hasAllKeys(["file", "line"])) {
      lineInfo = "%s (line %s)".format(locations.getString("file"), locations.getString("line"));
    }

    return [
      style("const", lineInfo),
      style("special", "########## DEBUG ##########"),
      contents,
      style("special", "###########################"),
      "",
    ].join("\n");
  }

  // Convert a tree of IErrorNode objects into a plain text string.
  override string dump(IErrorNode node) {
    size_t indentLevel = 0;
    return export_(node, indentLevel);
  }

  // #region export 
  // Export an array type object
  override protected string exportArray(DArrayErrorNode node, size_t indentLevel) {
    super.exportArray(node, indentLevel);

    if (node is null) {
      return null;
    }
    auto result = style("punct", "[");

    /*         auto arrowTxt = style("punct", ": ");
        auto vars = node.children()
            .map!(item => exportArrayItem(item, indentLevel))
            .array;

        auto closeTxt = style("punct", "]");
        return !vars.isEmpty
            ? result ~ vars.join(style("punct", ",")) ~ endText ~ closeTxt : result ~ closeTxt; */
    return null;
  }

  override protected string exportArrayItem(IErrorNode node, size_t indentLevel) {
    super.exportArray(node, indentLevel);

    if (node is null) {
      return null;
    }

    return breakText ~ export_(item.getKey(), indentLevel) ~ arrowTxt ~ export_(item.value(), indentLevel);
  }
  
  override protected string exportReference(DReferenceErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }
    // object(xxx) id: xxx{}
    /* return _style("punct", "object(") ~
            style("class", node.value()) ~
            style("punct", ") id:") ~
            style("number", to!string(node.id())) ~
            style("punct", " {}"); */
    return null;
  }

  override protected string exportClass(DClassErrorNode node, size_t indentLevel) {
    string breakText = "\n" ~ " ".repeatTxt(indentLevel);
    string endText = "\n" ~ " ".repeatTxt(indentLevel - 1) ~ style("punct", "}");

    if (node is null) {
      return null;
    }

    string[] props;

    auto result = style("punct", "object(") ~
      style("class", node.value.toString) ~
      style("punct", ") id:") ~
      style("number", to!string(node.id)) ~ style("punct", " {");

    string[] exportedProperties = node.children
      .map!(prop => exportProperty(cast(DPropertyErrorNode) prop, indentLevel)).array;

    return result ~ (exportedProperties.length > 0
        ? breakText ~ exportedProperties.join(breakText) ~ endText : style("punct", "}"));
  }

  override protected string exportProperty(DPropertyErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }

    auto visibility = node.visibility;
    auto name = node.name;
    auto arrow = style("punct", ": ");

    return visibility != "public"
      ? style("visibility", visibility) ~ " " ~ style("property", name) ~ arrow ~ export_(node.value(), indentLevel)
      : style("property", name) ~ arrow ~ export_(node.value(), indentLevel);
  }

  override protected string exportScalar(DScalarErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }

    /*  switch (node.getType()) {
        case "bool":
            return style("const", node.getBoolean() ? "true" : "false");
        case "null":
            return style("const", "null");
        case "string":
            return style("string", "'" ~ node.getString() ~ "'");
        case "int", "float":
            return style("visibility", "({node.getType()})") ~ " " ~ style("number", "{node.value()}");
        default:
            return "({node.getType()}) {node.value()}";
        }; */
    return null;
  }

  override protected string exportSpecial(DSpecialErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }
    return null;
  }
  // #endregion export 

  // Style text with ANSI escape codes.
  protected string style(string styleToUse, string textToStyle) {
    /* auto code = _styles[styleToUse];
        return "\033[{code}m{textToStyle}\033[0m"; */
    return null;
  }
}
