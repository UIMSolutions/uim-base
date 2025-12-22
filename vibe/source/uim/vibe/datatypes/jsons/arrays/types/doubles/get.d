module uim.vibe.datatypes.jsons.arrays.types.doubles.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

double getDouble(Json[] jsons, size_t index, double defaultValue = 0.0) {
  import uim.vibe.datatypes.jsons.json.get;

  return jsons.length > index && jsons[index].isDouble
    ? uim.vibe.datatypes.jsons.json.get.getDouble(jsons[index], defaultValue) : defaultValue;
}
