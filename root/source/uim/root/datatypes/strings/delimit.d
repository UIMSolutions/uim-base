module uim.root.datatypes.strings.delimit;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

/**
  Converts dashes and spaces to the specified delimiter in the given text(s).
  
  Params:
      texts = The text(s) to convert.
      delimiter = The delimiter to use (default is underscore).
  
  Returns:
      The converted text(s) with the specified delimiter.
  */
string[] delimit(string[] texts, string delimiter = "_") pure {
  return texts.map!(text => text.delimit(delimiter)).array;
}
///
unittest {
  auto result = delimit(["hello-world", "foo bar"], "_");
  assert(result.length == 2);
  assert(result[0] == "hello_world");
  assert(result[1] == "foo_bar");
}

/** 
  Converts dashes and spaces to the specified delimiter in the given text.
  
  Params:
      text = The text to convert.
      delimiter = The delimiter to use (default is underscore).
  
  Returns:
      The converted text with the specified delimiter.
  */
string delimit(string text, string delimiter = "_") pure {
  string result; 

  if (result.isEmpty) {
    dchar lastChar;
    foreach (index, c; text) {
      result ~= std.uni.isUpper(c) && index > 0 && !std.uni.isWhite(lastChar)
        ? delimiter ~ c : "" ~ c;
      lastChar = c;
    }
  }
  return result.toLower;
}
///
unittest {
  assert(delimit("hello-world", "_") == "hello_world");
  assert(delimit("foo bar", "-") == "foo-bar");
}
