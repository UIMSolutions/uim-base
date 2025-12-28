module uim.root.datatypes.strings.endswith;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool allEndsWith(string[] values, string text) {
  if (text.length == 0 || values.length == 0) {
    return false;
  }

  return values.all!(value => endsWith(value, text));
}

bool anyEndsWith(string[] values, string text) {
  if (text.length == 0 || values.length == 0) {
    return false;
  }

  return values.any!(value => endsWith(value, text));
}