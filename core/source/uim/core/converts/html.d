/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.converts.html;

import uim.core;

mixin(Version!("test_uim_core"));
@safe:

// #region attributes
string readAttributes(Json json, bool sorted = false) {
  if (json.isString) {
    return json.getString;
  }

  string[] attributes;
  if (json.isObject) {
    attributes = json.convert((string key, Json value) {
      return "%s=\"%s\"".format(key, value.getString);
    });
  }

  if (json.isArray) {
    attributes = json.convert((Json value) { return value.getString; });
  }

  return readAttributes(attributes, sorted);
}

string readAttributes(string[string] items, bool sorted = false) {

  return readAttributes(items.convert((string key, string value) => "%s=\"%s\"".format(key, value)), sorted);
}

string readAttributes(string[] items, bool sorted = false) {
  if (sorted) {
    items.sort!((a, b) => a < b);
  }
  return items.join(" ");
}
// #endregion attributes

string readContent(Json json) {
  if (json.isString) {
    return json.getString;
  }

  string[] content;
  if (json.isObject) {
    content = json.convert((string key, Json value) { return value.getString; });
  }

  if (json.isArray) {
    content = json.convert((Json value) { return value.getString; });
  }

  return content.join;
}
// #region startTag
string startTag(Json[string] items) {
  if (items.length == 0) {
    return null;
  }

  string tag = items.getString("tag");
  string attributes = ("attributes" in items) ? readAttributes(items["attributes"]) : null;

  return startTag(tag, attributes);
}

string startTag(Json json) {
  if (json.isString) {
    return startTag(json.getString);
  }

  string tag;
  if (json.isObject) {
    tag = json.getString("tag");
    if (tag.length == 0) {
      return null;
    }

    string attributes;
    if ("attributes" in json) {
      attributes = readAttributes(json["attributes"]);
    }

    return startTag(tag, attributes);
  }

  return null;
}

string startTag(string tag, string[string] attributes) {
  return startTag(tag, attributes.byKeyValue.map!(kv => "%s=\"%s\"".format(kv.key, kv.value))
      .array);
}

string startTag(string tag, string[] attributes) {
  tag = tag.strip;
  return attributes.length == 0
    ? "<%s>".format(tag) : "<%s %s>".format(tag, attributes.join(" "));
}

string startTag(string tag, string attributes) {
  return attributes.strip.length == 0
    ? startTag(tag) : "<%s %s>".format(tag.strip, attributes.strip);
}

string startTag(string tag) {
  return "<%s>".format(tag.strip);
}

unittest {
  assert("test".startTag == "<test>");
  assert("test".startTag(["a", "b"]) == "<test a b>");
  assert("test".startTag(["a": "b"]) == "<test a=\"b\">");

  Json json = Json("test");
  assert(json.startTag == "<test>");

  json = Json.emptyObject;
  json["tag"] = "test";
  json["attributes"] = ["a": "b"].toJson;
  assert(json.startTag == "<test a=\"b\">");

  Json[string] map;
  map["tag"] = Json("test");
  map["attributes"] = Json(["a": Json("b")]);
  writeln("TEST3\t", map.startTag);
  assert(map.startTag == "<test a=\"b\">");
}
// #endregion startTag

// #region endTag
string endTag(Json[string] map) {
  return "tag" in map
    ? endTag(map["tag"]) : null;
}

string endTag(Json json) {
  return json.isString
    ? "</%s>".format(json.getString) : json.isObject
    ? endTag(json["tag"].getString) : null;
}

string endTag(string[string] map) {
  return "tag" in map
    ? endTag(map["tag"]) : null;
}

string endTag(string tag) {
  tag = tag.strip;
  return tag.length > 0
    ? "</%s>".format(tag.strip) : null;
}

unittest { // Test endTag(string)
  assert(endTag("div") == "</div>");
  assert(endTag("  span  ") == "</span>");
  assert(endTag("") is null);
  assert(endTag("   ") is null);
}

unittest { // endTag(string[string])
  string[string] map1 = ["tag": "section"];
  assert(endTag(map1) == "</section>");
  string[string] map2 = ["notag": "foo"];
  assert(endTag(map2) is null);
}

unittest { // Test endTag(Json[string])
  Json[string] jmap1;
  jmap1["tag"] = Json("header");
  assert(endTag(jmap1) == "</header>");
  Json[string] jmap2;
  jmap2["notag"] = Json("foo");
  assert(endTag(jmap2) is null);
}

unittest { // Test endTag(Json)
  Json jString = Json("footer");
  assert(endTag(jString) == "</footer>");
  Json jObj = Json.emptyObject;
  jObj["tag"] = "nav";
  assert(endTag(jObj) == "</nav>");
  Json jempty = Json.emptyObject;
  assert(endTag(jempty) is null);
}
// #endregion endTag

// #region htmlTag
string htmlTag(Json[string] map) {
  string start = startTag(map);
  string end = endTag(map);
  string content = map.getString("content");

  return start ~ content ~ end;
}

string htmlTag(Json json) {
  string start = startTag(json);
  string end = endTag(json);
  string content = "content" in json ? readContent(json["content"]) : null;

  return start ~ content ~ end;
}

string htmlTag(string tag, string[string] attributes, string[] content) {
  return htmlTag(tag, attributes, content.join);
}

string htmlTag(string tag, string[] attributes, string[] content) {
  return htmlTag(tag, attributes, content.join);
}

string htmlTag(string tag, string attributes, string[] content) {
  return htmlTag(tag, attributes, content.join);
}

string htmlTag(string tag, string[string] attributes, string content = null) {
  return startTag(tag, attributes) ~ content ~ endTag(tag);
}

string htmlTag(string tag, string[] attributes, string content = null) {
  return startTag(tag, attributes) ~ content ~ endTag(tag);
}

string htmlTag(string tag, string attributes, string content) {
  return startTag(tag, attributes) ~ content ~ endTag(tag);
}

string htmlTag(string tag, string attributes) {
  return startTag(tag, attributes) ~ endTag(tag);
}

string htmlTag(string tag) {
  return startTag(tag) ~ endTag(tag);
}

unittest {
  // Test htmlTag(string)
  assert("div".htmlTag == "<div></div>");
  assert("span".htmlTag("class=\"foo\"") == "<span class=\"foo\"></span>");
  assert("p".htmlTag("style=\"color:red\"", "Hello") == "<p style=\"color:red\">Hello</p>");

  // Test htmlTag(string, string[])
  assert("ul".htmlTag(["id=\"list\"", "class=\"main\""]) == "<ul id=\"list\" class=\"main\"></ul>");
  assert("li".htmlTag(["data-x=\"1\""], "Item") == `<li data-x="1">Item</li>`);
  assert("div".htmlTag(["hidden"], ["A", "B"]) == "<div hidden>AB</div>");

  // Test htmlTag(string, string[string])
  string[string] attrs = ["id": "foo", "class": "bar"];
  assert("section".htmlTag(attrs) == "<section id=\"foo\" class=\"bar\"></section>");
  assert("section".htmlTag(attrs, "Content") == "<section id=\"foo\" class=\"bar\">Content</section>");

  // Test htmlTag(string, string[string], string[])
  assert("nav".htmlTag(attrs, ["A", "B"]) == "<nav id=\"foo\" class=\"bar\">AB</nav>");

  // Test htmlTag(Json)
  Json j = Json.emptyObject;
  j["tag"] = "div";
  assert(j.htmlTag == "<div></div>");

  j["attributes"] = [`id="main"`].toJson;
  writeln("test102\t", j.toString);
  writeln("test101\t", j.htmlTag);
  assert(j.htmlTag == `<div id="main"></div>`);

  j["content"] = "Hello".toJson;
  assert(j.htmlTag == `<div id="main">Hello</div>`);

  // Test htmlTag(Json[string])
  Json[string] jmap;
  jmap["tag"] = Json("span");
  assert(jmap.htmlTag == "<span></span>");
  jmap["attributes"] = [`class="x"`].toJson;
  assert(jmap.htmlTag == `<span class="x"></span>`);
  jmap["content"] = Json("World");
  assert(jmap.htmlTag == `<span class="x">World</span>`);

  // Test htmlTag with null/empty attributes and content
  assert("div".htmlTag([`id="foo"`], ["abc", "def"]) == "<div id=\"foo\">abcdef</div>");
}

unittest {
  assert("test".htmlTag == "<test></test>");
  assert("test".htmlTag("a b") == "<test a b></test>");
  assert("test".htmlTag("a b", "xxx") == "<test a b>xxx</test>");

  assert("test".htmlTag(["a", "b"]) == "<test a b></test>");
  assert("test".htmlTag(["a", "b"], "xxx") == "<test a b>xxx</test>");

  assert("test".htmlTag(["a", "b"], ["xxx"]) == "<test a b>xxx</test>");

  Json json = Json.emptyObject;
  json["tag"] = "test";
  assert(json.htmlTag == "<test></test>");

  json["attributes"] = ["a", "b"].toJson;
  writeln("Test4\t", json.htmlTag);
  assert(json.htmlTag == "<test a b></test>");

  json["content"] = "xxx".toJson;
  assert(json.htmlTag == "<test a b>xxx</test>");

  json["attributes"] = Json(null);
  assert(json.htmlTag == "<test>xxx</test>");

  Json[string] map;
  map["tag"] = "test";
  assert(map.htmlTag == "<test></test>");

  map["attributes"] = ["a", "b"].toJson;
  assert(map.htmlTag == "<test a b></test>");

  map["content"] = "xxx".toJson;
  assert(map.htmlTag == "<test a b>xxx</test>");

  map["attributes"] = Json(null);
  assert(map.htmlTag == "<test>xxx</test>");
}
// #endregion htmlTag

string htmlTag(K, V)(V[K] items, SORTORDERS sortorder = SORTORDERS.NONE) {
  auto keys = items.keys;
  if (keys.length == 0) {
    return "";
  }
  if (sortorder == SORTORDERS.ASCENDING)
    keys.sort!("a < b");
  if (sortorder == SORTORDERS.DESCENDING)
    keys.sort!("b < a");

  return keys
    .map!(key => `%s="%s"`.format(key.toString, items[key].toString))
    .join(" ");
}

/* unittest {
  assert(["a": 1, "b": 2].htmlTag(SORTORDERS.ASCENDING) == `a="1" b="2"`);
} */
