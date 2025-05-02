module uim.core.convert.html;

mixin(Version!("test_uim_core"));

import uim.core;
@safe:

string toHTML(string tag) {
  return "<%s>".format(tag);
}
unittest {
  assert("test".toHTML == "<test>");
}

/* string toHTML(Json json) {
  if (json.isString) {
    return "<%s>".format(tag);
  }
  // TODO
  return null; 
}
 */

 string toHTML(K, V)(V[K] items, SORTORDERS sortorder = SORTORDERS.NONE) {
  auto keys = items.keys;
  if (keys.length == 0) {
    return "";
  }
  if (sortorder == SORTORDERS.ASCENDING) keys.sort!("a < b");
  if (sortorder == SORTORDERS.DESCENDING) keys.sort!("b < a");

  return keys
    .map!(key => `%s="%s"`.format(key.toString, items[key].toString))
    .join(" ");
}

unittest {
  assert(["a": 1, "b": 2].toHTML(SORTORDERS.ASCENDING) == `a="1" b="2"`);
}
