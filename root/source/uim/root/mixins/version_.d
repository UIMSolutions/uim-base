module uim.root.mixins.version_;

template ShowModule() {
  const char[] ShowModule = `
version (show_module) {
  import std.stdio;
  import std.string;
  import consolecolors;

  unittest {
    string mod = leftJustify(__MODULE__, 100, ' ');
    cwritefln(("Loading " ~ mod).black.on_white);
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

  cwritefln(("  | Testing " ~ leftJustify(`~msg~`, 100, ' ')).black.on_grey);
}  
`;
}

template ShowFunction() {
  const char[] ShowTest = `
version (show_test) {
  import std.stdio;
  import std.string;
  import consolecolors;

  cwritefln(("    | Calling  " ~ leftJustify(__PRETTY_FUNCTION__, 100, ' ')).white);
}  
`;
}