module uim.phobos.datatypes.strings.md5;

import uim.phobos;

mixin(Version!("test_uim_phobos"));

@safe:

string[] md5(string[] values) {
  return values.map!(value => md5(value)).array;
}

string md5(string value) {
  import std.digest.md;

  return toHexString(md5Of(value).dup);
}

unittest {
  assert(md5("abc") == "900150983CD24FB0D6963F7D28E17F72");
  assert("abc".md5 == "900150983CD24FB0D6963F7D28E17F72");
  assert("abc".md5 != "");

  assert(md5(["abc", "xyz"]) == [
      "900150983CD24FB0D6963F7D28E17F72", "D16FB36F0911F878998C136191AF705E"
    ]);
  assert(["abc", "xyz"].md5 == [
      "900150983CD24FB0D6963F7D28E17F72", "D16FB36F0911F878998C136191AF705E"
    ]);
  assert(["abc", "xyz"].md5 != ["", ""]);
}
// #endregion md5