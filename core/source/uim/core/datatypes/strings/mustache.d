module uim.core.datatypes.strings.mustache;

import uim.core;

mixin(Version!("test_uim_core"));
@safe:

string mustache(string text, Json[string] items) {
  items.byKeyValue.each!(item => text = text.mustache(item.key, item.value));
  return text;
}

string mustache(string text, Json map, string[] selectedKeys = null) {
  if (!map.isObject) {
    return text; // If items is not an object, return the original text
  }
  map.keys
    .filter!(key => map.hasKey(key))
    .filter!(key => selectedKeys.length == 0 || selectedKeys.has(key))
    .each!(key => text = text.mustache(key, map[key]));
  return text;
}

string mustache(string text, string[string] items) {
  items.byKeyValue.each!(item => text = text.mustache(item.key, item.value));
  return text;
}

string mustache(string text, string[] keys, string[] values) {
  if (keys.length != values.length) {
    throw new Exception("Keys and values must have the same length.");
  }
  for (size_t i = 0; i < keys.length; i++) {
    text = text.mustache(keys[i], values[i]);
  }
  return text;
}

string mustache(string text, string key, Json value) {
  return value.isString 
    ? mustache(text, key, value.getString)
    : mustache(text, key, value.toString);
}

string mustache(string text, string key, string value) {
  return std.string.replace(text, "{" ~ key ~ "}", value);
}
