module uim.vibe.helpers.json;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

string typeName(Json json) {
  if (json.isNull) {
    return "null";
  }
  if (json.isDouble) {
    return "double";
  }
  if (json.isLong) {
    return "long";
  }
  if (json.isString) {
    return "string";
  }
  if (json.isArray) {
    return "array";
  }
  if (json.isObject) {
    return "object";
  }
  return "unknown";
}
