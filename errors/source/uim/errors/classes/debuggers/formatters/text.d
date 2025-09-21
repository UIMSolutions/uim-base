/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.debuggers.formatters.text;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

// A Debugger formatter for generating unstyled plain text output.
class DTextErrorFormatter : UIMErrorFormatter {
  mixin(ErrorFormatterThis!("Text"));

  string formatWrapper(string content, Json[string] location) {
    string templateTxt = "
%s
########## DEBUG ##########
%s
###########################
";
    string lineInfo = "";

    if (location.hasAlls(["file", "line"])) {
      lineInfo = "%s (line %s)".format(location.getString("file"), location.getString("line"));
    }
    return templateTxt.format(lineInfo, content);
  }

  // #region export
  override protected string exportArray(DArrayErrorNode node, size_t indentLevel) {
    super.exportArray(node, indentLevel);

    auto nodes = node.children
      .map!(item => exportArrayItem(node.value, indentLevel))
      .array;

    return "[" ~ (
      !nodes.isEmpty
        ? nodes.join(",") ~ _endBreak : "") ~ "]";
  }

  override protected string exportArrayItem(IErrorNode node, size_t indentLevel) {
    super.exportArrayItem(node, indentLevel);

    return startBreak ~
      export_(node.value, indentLevel) ~ ": " ~ export_(node.value, indentLevel);
  }

  override protected string exportReference(DReferenceErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }

    return "object({nodeClassname}) id:{nodeId} {}".mustache(
      ["nodeClassname": node.classname, "nodeId": node.id.toString]);
  }

  override protected string exportClass(DClassErrorNode node, size_t indentLevel) {
    super.exportClass(node, indentLevel);

    if (node is null) {
      return null;
    }

    string result = "(Object) Name:{nodeClassname} Id:{nodeId} {".mustache(
      ["nodeClassname": node.classname, "nodeId": node.id.toString]);

    auto items = node.children()
      .map!(property => export_(property, indentLevel))
      .array;

    return result ~ (items.length > 0
        ? startBreak(indentLevel+1) ~ items.join(startBreak(indentLevel+1)) ~ endBreak((indentLevel)) : "") ~ "}";
  }

  override protected string exportProperty(DPropertyErrorNode node, size_t indentLevel) {
    super.exportProperty(node, indentLevel);

    if (node is null) {
      return null;
    }

    return "(Property) " ~ (node.visibility != "public"
        ? "[{propVisibility}] Name:{propName} " : "Name:{propName} ").mustache(
      [
        "propVisibility": node.visibility,
        "propName": node.name
      ]) ~ export_(node.value, indentLevel);
  }

  override protected string exportScalar(DScalarErrorNode node, size_t indentLevel) {
    super.exportScalar(node, indentLevel);

    if (node is null) {
      return null;
    }

    switch (node.type) {
    case "bool":
      return "Type:Bool Value:"~node.data.getBoolean() ? "true" : "false";
    case "null":
      return "Type:Null Value:null";
    case "string":
      return "Type:String Value:'" ~ node.data.getString ~ "'";
    default:
      return "Type:" ~ node.type ~ " Value:" ~ node.data.toString;
    }
  }

  override protected string exportSpecial(DSpecialErrorNode node, size_t indentLevel) {
    super.exportSpecial(node, indentLevel);

    if (node is null) {
      return null;
    }

    return null;
  }
  // #endregion export
}

mixin(ErrorFormatterCalls!("Text"));
