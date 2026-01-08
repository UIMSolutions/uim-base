module uim.root.mixins.version_;

template ShowModule() {
  const char[] ShowModule = `
version (show_module) {
  import std.stdio;
  import std.string;
  import consolecolors;

  unittest {
    string inner = leftJustify(__MODULE__, 106, ' ');
    string outer = "| Loading " ~ inner;
    cwritefln(outer.black.on_white);  
  }
}  
`;
}

template ShowTest(string msg) {
  const char[] ShowTest = `
version (show_test) {
  import std.stdio;
  import std.string;
  import consolecolors;

  string inner = leftJustify("`~msg~`", 104, ' ');
  string outer = "  | Testing " ~ inner;
  cwritefln(outer.black.on_grey);  
}  
`;
}

template ShowFunction() {
  const char[] ShowFunction = `
version (show_test) {
  import std.stdio;
  import std.string;
  import consolecolors;

  string inner = leftJustify(__PRETTY_FUNCTION__, 100, ' ');
  string outer = "     | Calling  " ~ inner;
  cwritefln(outer.white.on_blue);  
}  
`;
}