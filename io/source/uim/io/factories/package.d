/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.factories;

public {
    import uim.io.factories.console;
    import uim.io.factories.error;
    import uim.io.factories.input;
    import uim.io.factories.output;
}

static this() { // Init factories
  import uim.io;

  InputFactory.set("file", (Json[string] options = new Json[string]) @safe {
      return new DFileInput(options);
  });

  InputFactory.set("rest", (Json[string] options = new Json[string]) @safe {
    return new DRestInput(options);
  });

  InputFactory.set("standard", (Json[string] options = new Json[string]) @safe {
      return new DStandardInput(options);
  });

  OutputFactory.set("file", (Json[string] options = new Json[string]) @safe {
      return new DFileOutput(options);
  });

  OutputFactory.set("rest", (Json[string] options = new Json[string]) @safe {
      return new DRestOutput(options);
  });

  OutputFactory.set("standard", (Json[string] options = new Json[string]) @safe {
    return new DStandardOutput(options);
  });

  ErrorOutputFactory.set("file", (Json[string] options = new Json[string]) @safe {
      return new DFileErrorOutput(options);
  });

  ErrorOutputFactory.set("rest", (Json[string] options = new Json[string]) @safe {
      return new DRestErrorOutput(options);
  });

  ErrorOutputFactory.set("standard", (Json[string] options = new Json[string]) @safe {
    return new DStandardErrorOutput(options);
  });
}
 