/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.formatters.text;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

/**
 * A Debugger formatter for generating unstyled plain text output.
 *
 * Provides backwards compatible output with the historical output of
 * `Debugger.exportVar()`
 *
 * @internal
 */
class DTextErrorFormatter : DErrorFormatter {
  mixin(ErrorFormatterThis!("Text"));

  string formatWrapper(string content, Json[string] location) {
    string templateTxt = "
%s
########## DEBUG ##########
%s
###########################
";
    string lineInfo = "";

    if (location.hasAllKeys(["file", "line"])) {
      lineInfo = "%s (line %s)".format(location.getString("file"), location.getString("line"));
    }
    return templateTxt.format(lineInfo, content);
  }

  // Convert a tree of IErrorNode objects into a plain text string.
  override string dump(IErrorNode node) {
    auto indentLevel = 0;
    return export_(node, indentLevel);
  }

  // #region export
  override protected string exportArray(DArrayErrorNode node, size_t indentLevel) {
    super.exportArray(node, indentLevel);

    auto result = "[";

    auto nodes = node.children
      .map!(item => breakText ~ export_(item.getKey(), indentLevel) ~ ": " ~ export_(item.getValue, indentLevel))
      .array;

    return result ~ (!nodes.isEmpty
      ? nodes.join(",") ~ end : "") ~ "]";
  }

  override protected string exportReference(DReferenceErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }

    return "object({" ~ node.value.getString ~ "}) id:{node.id()} {}";
  }

  override protected string exportClass(DClassErrorNode node, size_t indentLevel) {
    super.exportClass(node, indentLevel);
    _endText ~= "}";

    if (node is null) {
      return null;
    }

    string result = "object({" ~ node.value().getString ~ "}) id:{" ~ node.id() ~ "} {";
    auto props = node.children()
      .map!(property => exportProperty(cast(DPropertyErrorNode) property, indentLevel))
      .array;

    return !props.isEmpty
      ? result ~ breakText ~ props.join(breakText) ~ endText : result ~ "}";
  }

  override protected string exportProperty(DPropertyErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }

    auto propVisibility = node.visibility();
    auto propName = node.name;

    return propVisibility != "public"
      ? "[{propVisibility}] {propName}: " ~ export_(node.value(), indentLevel) : "{propName}: " ~ export_(
        node.value(), indentLevel);
  }

  override protected string exportScalar(DScalarErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }
    switch (node.type) {
    case "bool":
      return node.value.getBoolean() ? "true" : "false";
    case "null":
      return "null";
    case "string":
      return "'" ~ node.value.getString ~ "'";
    default:
      return "({" ~ node.type ~ "}) {" ~ node.value.toString ~ "}";
    }
  }

  override protected string exportSpecial(DSpecialErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }

    return null;
  }
  // #endregion export
}
