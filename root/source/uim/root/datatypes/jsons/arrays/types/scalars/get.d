module uim.root.datatypes.jsons.arrays.types.scalars.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json getScalar(Json[] jsons, size_t index, Json defaultValue = Json(null)) {
  return jsons.length > index && jsons[index].isScalar ? jsons[index].getScalar(defaultValue) : defaultValue;
}