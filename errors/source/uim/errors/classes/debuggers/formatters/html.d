/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.errors.classes.debuggers.formatters.html;

import uim.errors;

mixin(ShowModule!());

@safe:

/**
 * A Debugger formatter for generating interactive styled HTML output.
 *
 * @internal
 */
class DHtmlErrorFormatter : UIMErrorFormatter {
  mixin(ErrorFormatterThis!("Html"));

  protected static bool outputHeader = false;

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    _id = randomUUID.toString;
    return true;
  }

  // Random id so that HTML ids are not shared between dump outputs.
  protected string _id;
  string id() {
    return _id;
  }

  // Check if the current environment is not a CLI context
  static bool environmentMatches() {
    /*     return UIM_SAPI == "cli" || UIM_SAPI == "Ddbg"
      ? false : true; */
    return false;
  }

  string formatWrapper(string acontents, Json[string] location) {
    string lineInfo = "";
    if (location.hasAllKey(["file", "line"])) {
      /* lineInfo = htmlDoubleTag("span", "<strong>{file}</strong> (line <strong>{line}</strong>)")
        .mustache(location, ["file", "line"]); */
    }

    /*     return [
      `<div class="uim-debug-output uim-debug" style="direction:ltr">`,
      lineInfo,
      contents,
      "</div>",
    ].join("\n"); */
    return null;
  }

  /**
     * Generate the CSS and Javascript for dumps
     * Only output once per process as we don`t need it more than once.
     */
  protected string dumpHeader() {
    /* ob_start();
        include __DIR__~ DIR_SEPARATOR ~ "dumpHeader.html";

        return to!string(ob_get_clean()); */
    return null;
  }

  // Convert a tree of IErrorNode objects into HTML
  override string dump(IErrorNode node) {
    auto content = super.export_(node, 0);
    string head = "";
    if (!outputHeader) {
      outputHeader = true;
      head = this.dumpHeader();
    }
    return head ~ htmlDoubleTag("div", ["uim-debug"], content);
  }

  // #region export
  protected override string exportArray(DArrayErrorNode node, size_t indentLevel) {
    super.exportArray(node, indentLevel);

    if (node is null) {
      return null;
    }

    string[] items = node.children.map!(item => exportArrayItem(item, indentLevel)).array;
    return htmlDoubleTag("span", `class="uim-debug-array"`, style("punct", "[") ~
        htmlDoubleTag("samp", `class="uim-debug-array-items"`, items.join("")) ~
        endBreak ~ style("punct", "]"));
  }

  protected override string exportArrayItem(IErrorNode node, size_t indentLevel) {
    super.exportArrayItem(node, indentLevel);

    if (node is null) {
      return null;
    }

    auto arrow = style("punct", ": ");
    auto value = node.value();
    return startBreak ~ htmlDoubleTag("span", ["uim-debug-array-item"],
      export_(node.value, indentLevel) ~ arrow ~ export_(node.value, indentLevel) ~
        style("punct", ","));
  }

  protected override string exportReference(DReferenceErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }

    auto objectId = "uim-db-object-{id}-{nodeid}".mustache([
      "id": id,
      "nodeid": node.id.toString
    ]);

    auto result = `<span class="uim-debug-object" id="%s">`.format(objectId);
    auto startBreak = "\n" ~ " ".repeatTxt(indentLevel);
    auto endBreak = "\n" ~ " ".repeatTxt(indentLevel - 1);

    auto link = `<a class="uim-debug-ref" href="#%s">id: %s</a>`
      .format(objectId, node.id());

    return htmlDoubleTag("span", ["uim-debug-ref"],
      style("punct", "object(") ~
        style("class", node.classname) ~
        style("punct", ") ") ~
        link ~
        style("punct", " {}"));
  }

  protected override string exportClass(DClassErrorNode node, size_t indentLevel) {
    super.exportClass(node, indentLevel);

    if (node is null) {
      return null;
    }

    auto objectId = "uim-db-object-{this.id}-{node.id()}";
    auto result = `<span class="uim-debug-object" id="%s">`.format(objectId) ~
      style("punct", "object(") ~
      style("class", node.classname) ~
      style("punct", ") id:") ~
      style("number", node.id.toString) ~ style("punct", " {") ~
      `<samp class="uim-debug-object-props">`;

    string[] props = node.children.map!(property => exportProperty(cast(DPropertyErrorNode) property, indentLevel)).array;

    auto endTag = "</samp>" ~
      endBreak ~
      style("punct", "}") ~
      "</span>";

    return result ~ (props.length > 0 ? props.join("") : "") ~ endTag;
  }

  protected override string exportProperty(DPropertyErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }

    auto arrow = style("punct", ": ");
    auto visibility = node.visibility;
    auto name = node.name;
    return visibility != "public"
      ? startBreak ~
      htmlDoubleTag("span", ["uim-debug-prop"],
        style("visibility", visibility) ~ ' ' ~ style("property", name) ~ arrow ~ export_(node.value(), indentLevel))
      : startBreak ~
      htmlDoubleTag("span", ["uim-debug-prop"],
        style("property", name) ~ arrow ~ export_(node.value(), indentLevel));
  }

  protected override string exportScalar(DScalarErrorNode node, size_t indentLevel) {
    if (node is null) {
      return null;
    }

    switch (node.type) {
    case "bool":
      return style("const", node.data.getBoolean ? "true" : "false");
    case "null":
      return style("const", "null");
    case "string":
      return style("string", "'" ~ node.data.getString ~ "'");
    case "int", "float":
      return style("visibility", "({"~node.type~"})") ~
        " " ~ style("number", "{"~node.data.getLong.toString~"}");
    default:
      return "({"~node.type~"}) {"~node.data.toString~"}";
    };
  }

  protected override string exportSpecial(DSpecialErrorNode node, size_t indentLevel) {
    return null;
  }
  // #endregion export

  // Style text with HTML class names
  protected string style(string styleToUse, string testToStyle) {
    return htmlDoubleTag("span", ["uim-debug-%s"], "%s")
      .format(styleToUse, escapeHtmlAttribute(testToStyle));
  }
}
