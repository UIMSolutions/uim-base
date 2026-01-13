module uim.root.datatypes.booleans.translate;

import uim.root;

mixin(ShowModule!());

@safe:

/// Translates boolean to defined values
pure T translateTo(T)(bool value, T trueValue, T falseValue) {
  return (value) ? trueValue : falseValue;
}

unittest {
  mixin(ShowTest!"Testing translateTo function");

  assert(translateTo!"string"(true, "Yes", "No") == "Yes");
  assert(translateTo!"string"(false, "Yes", "No") == "No");

  assert(translateTo!"int"(true, 1, 0) == 1);
  assert(translateTo!"int"(false, 1, 0) == 0);

  assert(translateTo!"double"(true, 3.14, 0.0) == 3.14);
  assert(translateTo!"double"(false, 3.14, 0.0) == 0.0);
}
