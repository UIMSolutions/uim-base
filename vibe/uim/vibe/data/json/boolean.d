module uim.vibe.data.json.boolean;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:



// #region getBoolean 
bool getBoolean(Json value, size_t index) {
  return !value.isNull && value.isArray && value.length > index
    ? value[index].getBoolean : false;
}

bool getBoolean(Json value, string key) {
  return !value.isNull && value.isObject && value.hasKey(key)
    ? value[key].getBoolean : false;
}

bool getBoolean(Json value) {
  return !value.isNull && value.isBoolean
    ? value.get!bool : false;
}

unittest {
  Json jValue = Json(true);

  Json jArray = Json.emptyArray;
  jArray ~= true;
  jArray ~= false;

  Json jObject = Json.emptyObject;
  jObject["true"] = true;
  jObject["false"] = false;

  assert(jValue.getBoolean); // == true
  assert(jArray.getBoolean(0)); // == true
  assert(jObject.getBoolean("true")); // == true
}
// #endregion getBoolean