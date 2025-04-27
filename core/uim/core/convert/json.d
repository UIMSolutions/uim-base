module uim.core.convert.json;

import uim.core;
@safe:

version (test_uim_core) {
  unittest {
    writeln("-----  ", __MODULE__, "\t  -----");
  }
}

string toJSONString(T)(T[string] values, bool sorted = NOTSORTED) {
  string result = "{" ~ MapHelper.sortedKeys(values)
    .map!(key => `"%s": %s`.format(key, values[key]))
    .join(",") ~ "}";

  return result;
}

unittest {
  // assert(["a": 1, "b": 2].toJSONString(SORTED) == `{"a": 1,"b": 2}`);
}

