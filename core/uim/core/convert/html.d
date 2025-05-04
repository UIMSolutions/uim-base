module uim.core.convert.html;

mixin(Version!("test_uim_core"));

import uim.core;

@safe:

// #region startTag
string startTag(Json[string] map) {
  if (map.length) {
    return null;
  }

  string tag = "tag" in map ? map["tag"].toString : null;
  Json[string] attributeMap = "attributes" in map ? map["attributes"].get!(Json[string]) : null;

  string[] attributes;
  foreach (key, value; attributeMap) {
    attributes ~= "%s=\"%s\"".format(key, value.toString);
  }

  return startTag(tag, attributes);
}

string startTag(Json json) {
  if (json.isString) {
    return "<%s>".format(json.toString);
  }

  if (json.isObject) {
    string tag = json["tag"].toString;
    Json[string] attributeMap = json["attributes"].get!(Json[string]);
    string[] attributes;
    foreach (key, value; attributeMap) {
      attributes ~= "%s=\"%s\"".format(key, value.toString);
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
  return attributes.length == 0
    ? "<%s>".format(tag) : "<%s %s>".format(tag, attributes.join(" "));
}

string startTag(string tag, string attributes = null) {
  return attributes.length == 0
    ? "<%s>".format(tag.strip) 
    : "<%s %s>".format(tag, attributes.strip);
}

unittest {
  assert("test".startTag == "<test>");
  assert("test".startTag([]) == "<test>");
  assert("test".startTag(["a", "b"]) == "<test a b>");
  assert("test".startTag(["a": "b"]) == "<test a=\"b\">");
  assert("test".startTag(["a": "b", "c": "d"]) == "<test a=\"b\" c=\"d\">");

  Json json = Json("test");
  assert(json.startTag == "<test>");
  json = Json.emptyObject;
  json["tag"] = "test";
  json["attributes"] = ["a": "b", "c": "d"];
  assert(json.startTag == "<test a=\"b\" c=\"d\">");

  Json[string] map = Json.emptyObject;
  map["tag"] = Json("test");
  map["attributes"] = Json(["a": Json("b"), "c": Json("d")]);
  assert(map.startTag == "<test a=\"b\" c=\"d\">");
}
// #endregion startTag

// #region endTag
string endTag(Json[string] map) {
  return "tag" in map
    ? endTag(map["tag"]) : null;
}

string endTag(Json json) {
  return json.isString
    ? "</%s>".format(json.toString) : json.isObject
    ? endTag(json["tag"].toString) : null;
}

string endTag(string[string] map) {
  return "tag" in map
    ? endTag(map["tag"]) : null;
}

string endTag(string tag) {
  return tag.length == 0
    ? null : "</%s>".format(tag.strip);
}

unittest {
  assert("test".endTag == "</test>");
  assert("test".endTag([]) == null);

  string[string] map = ["tag": "test"];
  assert(map.endTag == "</test>");

  Json json = Json("test");
  assert(json.endTag == "</test>");

  Json[string] mapx = Json.emptyObject;
  mapx["tag"] = Json("test");
  assert(mapx.endTag == "</test>");
}
// #endregion endTag

// #region htmlTag
string htmlTag(Json[string] map) {
  return htmlTag(map.getString("tag"), map.getString("attributes"), map.getString("content"));
}

string htmlTag(Json json) {
  return htmlTag(json.getString("tag"), json.getString("attributes"), json.getString("content"));
}

string htmlTag(string tag, string[string] attributes = null, string[] content = null) {
  return htmlTag(tag, attributes, content.join);
}

string htmlTag(string tag, string[] attributes = null, string[] content = null) {
  return htmlTag(tag, attributes, content.join);
}

string htmlTag(string tag, string attributes = null, string[] content = null) {
  return htmlTag(tag, attributes, content.join);
}

string htmlTag(string tag, string[string] attributes = null, string content = null) {
  return startTag(tag, attributes) ~ content ~ endTag(tag);
}

string htmlTag(string tag, string[] attributes = null, string content = null) {
  return startTag(tag, attributes) ~ content ~ endTag(tag);
}

string htmlTag(string tag, string attributes = null, string content = null) {
  return startTag(tag, attributes) ~ content ~ endTag(tag);
}

unittest {
  assert("test".htmlTag == "<test></test>");
  assert("test".htmlTag("a b") == "<test a b></test>");
  assert("test".htmlTag("a b", "xxx") == "<test a b>xxx</test>");
  assert("test".htmlTag(null, "xxx") == "<test>xxx</test>");

  assert("test".htmlTag(["a", "b"]) == "<test a b></test>");
  assert("test".htmlTag(["a", "b"], "xxx") == "<test a b>xxx</test>");
  assert("test".htmlTag([], "xxx") == "<test>xxx</test>");

  assert("test".htmlTag(["a", "b"], []) == "<test a b></test>");
  assert("test".htmlTag(["a", "b"], ["xxx"]) == "<test a b>xxx</test>");
  assert("test".htmlTag([], ["xxx"]) == "<test>xxx</test>");

  Json json = Json.emptyObject;
  json["tag"] = "test";
  assert(json.htmlTag == "<test></test>");
  json["attributes"] = ["a", "b"].toJson;
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

unittest {
  assert(["a": 1, "b": 2].htmlTag(SORTORDERS.ASCENDING) == `a="1" b="2"`);
}
