module uim.core.convert.json;

mixin(Version!("test_uim_core"));

import uim.core;
@safe:


string toJSONString(T)(T[string] values, bool sorted = NOTSORTED) {
  string result = "{" ~ MapHelper.sortedKeys(values)
    .map!(key => `"%s": %s`.format(key, values[key]))
    .join(",") ~ "}";

  return result;
}

unittest {
  // assert(["a": 1, "b": 2].toJSONString(SORTED) == `{"a": 1,"b": 2}`);
}
