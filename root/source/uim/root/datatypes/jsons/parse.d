module uim.root.datatypes.jsons.parse;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json[] parseToJson(string[] jsonStrings) {
  return jsonStrings.map!(s => s.parseJsonString).array;
}

Json parseToJson(string jsonString) {
  return jsonString.parseJsonString;
}