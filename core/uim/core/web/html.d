/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.web.html;

import uim.core;

@safe:

version (test_uim_core) {
  unittest {
    writeln("-----  ", __MODULE__, "\t  -----");
  }
}

// #region startTag
string htmlStartTag(A, B)(string name, string id, A classes, B attributes /* , bool isClosed = false */ )
    if (
      is(A == Json) || is(A == Json[]) ||
    is(B == Json) || is(B == Json[string])) {
  return htmlStartTag(name, id, classes.toStringArray, attributes.toStringMap /* , bool isClosed = false */ );
}

string htmlStartTag(string name, string id, string[] classes, string[string] attributes /* , bool isClosed = false */ ) {
  if (id.length > 0) {
    attributes.remove("id");
  }
  return htmlStartTag(
    name.strip,
    id.strip,
    classes.map!(cl => cl.strip)
      .uniq
      .array
      .sort!("a < b")
      .join(" "),
      attributes.keys
      .sort!("a < b")
      .map!(key => `%s="%s"`.format(key.strip, attributes[key]))
      .join(" ")
  );
}

/* string htmlStartTag(string tag, bool isClosed = false) {
  return isClosed
    ? "<" ~ tag ~ "/>"
    : "<" ~ tag ~ ">";
}

string htmlStartTag(string tag, string attributes, bool isClosed = false) {
  return attributes
    ? (isClosed 
      ? "<%s %s/>".format(tag, attributes) 
      : "<%s %s>".format(tag, attributes)
    )
    : htmlStartTag(tag, isClosed);
}
 */

string htmlStartTag(string name, string id = null, string classes = null, string attributes = null) {
  string startTag;
  startTag ~= "<" ~ name;
  startTag ~= id.length > 0 ? ` id="` ~ id ~ `"` : null;
  startTag ~= classes.length > 0 ? ` class="` ~ classes ~ `"` : null;
  startTag ~= attributes.length > 0 ? ` ` ~ attributes : null;
  startTag ~= ">";
  return startTag;
}

unittest {
  assert(htmlStartTag("hello") == "<hello>");
  assert(htmlStartTag("hello", "x") == `<hello id="x">`);
  assert(htmlStartTag("hello", "x", "abc def") == `<hello id="x" class="abc def">`);
  assert(htmlStartTag("hello", "x", "abc def", `alpha="Alpha" beta="Beta"`) == `<hello id="x" class="abc def" alpha="Alpha" beta="Beta">`);
  assert(htmlStartTag("hello", null, "abc def") == `<hello class="abc def">`);
  assert(htmlStartTag("hello", null, "abc def", `alpha="Alpha" beta="Beta"`) == `<hello class="abc def" alpha="Alpha" beta="Beta">`);
  assert(htmlStartTag("hello", null, null, `alpha="Alpha" beta="Beta"`) == `<hello alpha="Alpha" beta="Beta">`);
}
// #region startTag

unittest {
}

// #region htmlEndTag 
string htmlEndTag(string tag) {
  return "</" ~ tag ~ ">";
}
// #endregion htmlEndTag 

// #region htmlDoubleTag
string htmlDoubleTag(string tag) {
  return htmlStartTag(tag, null) ~ htmlEndTag(tag);
}

string htmlDoubleTag(string tag, string id) {
  return htmlStartTag(tag, id) ~ htmlEndTag(tag);
}

string htmlDoubleTag(string tag, string id, string content = null) {
  return htmlStartTag(tag, id) ~ content ~ htmlEndTag(tag);
}

unittest {
  assert(htmlDoubleTag("p") == "<p></p>");
  assert(htmlDoubleTag("p", "", "some content") == "<p>some content</p>");
}

string htmlDoubleTag(string tag, string[] classes, string content = null) {
  return htmlStartTag(tag, null, classes, null) ~ content ~ htmlEndTag(tag);
}

unittest {
  assert(htmlDoubleTag("p", ["x", "b"], "some content") == "<p class=\"b x\">some content</p>");
  assert(htmlDoubleTag("p", "", "some content") == "<p>some content</p>");
}

string htmlDoubleTag(string tag, string id, string[] classes, string content = null) {
  return htmlStartTag(tag, id, classes, null) ~ content ~ htmlEndTag(tag);
}

string htmlDoubleTag(string tag, Json[string] attributes, string content = null) {
  return htmlStartTag(tag, null, null, attributes.toStringMap) ~ content ~ htmlEndTag(tag);
}

string htmlDoubleTag(string tag, string[string] attributes, string content = null) {
  return htmlStartTag(tag, null, null, attributes) ~ content ~ htmlEndTag(tag);
}

string htmlDoubleTag(string tag, string[] classes, Json[string] attributes, string content = null) {
  return htmlStartTag(tag, null, classes, attributes.toStringMap) ~ content ~ htmlEndTag(tag);
}

string htmlDoubleTag(string tag, string[] classes, string[string] attributes, string content = null) {
  return htmlStartTag(tag, null, classes, attributes) ~ content ~ htmlEndTag(tag);
}

string htmlDoubleTag(string tag, string id, Json[string] attributes, string content = null) {
  return htmlStartTag(tag, id, null, attributes.toStringMap) ~ content ~ htmlEndTag(tag);
}

string htmlDoubleTag(string tag, string id, string[string] attributes, string content = null) {
  return htmlStartTag(tag, id, null, attributes) ~ content ~ htmlEndTag(tag);
}

string htmlDoubleTag(string tag, string id, string[] classes, Json[string] attributes, string content = null) {
  return htmlStartTag(tag, id, classes, attributes.toStringMap) ~ content ~ htmlEndTag(tag);
}

string htmlDoubleTag(string tag, string id, string[] classes, string[string] attributes, string content = null) {
  return htmlStartTag(tag, id, classes, attributes) ~ content ~ htmlEndTag(tag);
}
// #endregion htmlDoubleTag

// #region htmlSingleTag
string htmlSingleTag(string tag) {
  return htmlStartTag(tag);
}

string htmlSingleTag(string tag, string id) {
  return htmlStartTag(tag, id);
}

// #region htmlSingleTag - Json[string]
string htmlSingleTag(string tag, Json[string] attributes) {
  return htmlStartTag(tag, null, null, attributes.toStringMap);
}

string htmlSingleTag(string tag, string id, Json[string] attributes) {
  return htmlStartTag(tag, id, null, attributes.toStringMap);
}

string htmlSingleTag(string tag, string[] classes, Json[string] attributes) {
  return htmlStartTag(tag, null, classes, attributes.toStringMap);
}

string htmlSingleTag(string tag, string id, string[] classes, Json[string] attributes) {
  return htmlStartTag(tag, id, classes, attributes.toStringMap);
}
// #endregion htmlSingleTag - Json[string]

// #region htmlSingleTag - string[string]
string htmlSingleTag(string tag, string[string] attributes) {
  return htmlStartTag(tag, null, null, attributes);
}

string htmlSingleTag(string tag, string id, string[string] attributes) {
  return htmlStartTag(tag, id, null, attributes);
}

string htmlSingleTag(string tag, string[] classes, string[string] attributes) {
  return htmlStartTag(tag, null, classes, attributes);
}

string htmlSingleTag(string tag, string id, string[] classes, string[string] attributes) {
  return htmlStartTag(tag, id, classes, attributes);
}
// #endregion htmlSingleTag - string[string]
// #endregion htmlSingleTag

// #region escapeHtmlAttributes 
string[] escapeHtmlAttribute(string[] htmls) {
  return htmls.map!(html => escapeHtmlAttribute(html)).array;
}

string escapeHtmlAttribute(string html) {
  return htmlAttribEscape(html);
}

unittest {
  // Test escapeHtmlAttribute(string)
  assert(escapeHtmlAttribute("") == "");
  assert(escapeHtmlAttribute("Hello, world!") == "Hello, world!");
  assert(escapeHtmlAttribute("<div>") == "&lt;div&gt;");
  assert(escapeHtmlAttribute("&") == "&amp;");
  assert(escapeHtmlAttribute("\"quoted\"") == "&quot;quoted&quot;");
  assert(escapeHtmlAttribute("'single'") == "&#39;single&#39;");
  assert(escapeHtmlAttribute("<>&'\"") == "&lt;&gt;&amp;&#39;&quot;");

  // Test escapeHtmlAttribute(string[])
  string[] input = [
    "",
    "Hello, world!",
    "<div>",
    "&",
    "\"quoted\"",
    "'single'",
    "<>&'\""
  ];

  string[] expected = [
    "",
    "Hello, world!",
    "&lt;div&gt;",
    "&amp;",
    "&quot;quoted&quot;",
    "&#39;single&#39;",
    "&lt;&gt;&amp;&#39;&quot;"
  ];
  assert(escapeHtmlAttribute(input).equal(expected));
}
// #endregion escapeHtmlAttributes 

// #region escapeHtml
// Escape the HTML of a given string.
string[] escapeHtml(string[] htmls) {
  return htmls.map!(html => escapeHtml(html)).array;
}

string escapeHtml(string html) {
  return htmlAttribEscape(html);
}

unittest { // Test escapeHtml(string)
  assert(escapeHtml("") == "");
  assert(escapeHtml("Hallo! <world>") == "Hallo! &lt;world&gt;");
  assert(escapeHtml("& This is <it>!") == "&amp; This is &lt;it&gt;!");
  assert(escapeHtml("\"quoted\"") == "&quot;quoted&quot;");
  assert(escapeHtml("'single'") == "&#39;single&#39;");
  assert(escapeHtml("<>&'\"") == "&lt;&gt;&amp;&#39;&quot;");
}

unittest { // Test escapeHtml(string[])
  assert(escapeHtml([""]) == [""]);
  string[] input = [
    "& This is <it>!", "Hallo! <world>", "\"quoted\"", "'single'"
  ];
  string[] expected = [
    "&amp; This is &lt;it&gt;!", "Hallo! &lt;world&gt;", "&quot;quoted&quot;",
    "&#39;single&#39;"
  ];
  assert(escapeHtml(input) == expected);
}
// #endregion escapeHtml
