module uim.root.mixins.version_;

template Version(string name) {
  const char[] Version = `
version (`
    ~ name ~ `) {
  import std.stdio;
  import std.string;

  unittest {
    string mod = leftJustify(__MODULE__, 50, ' ');
    writeln("-----  ", mod, " -----");
  }
}  
`;
}