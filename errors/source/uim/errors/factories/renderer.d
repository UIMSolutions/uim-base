/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.factories.renderer;

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:

class UIMErrorRendererFactory : DFactory!UIMErrorRenderer {}
auto ErrorRendererFactory() { return UIMErrorRendererFactory.factory; }

static this() {
  ErrorRendererFactory.set("console", (Json[string] options = null) @safe {
    return new DConsoleErrorRenderer(options);
  });

  ErrorRendererFactory.set("html", (Json[string] options = null) @safe {
    return new DHtmlErrorRenderer(options);
  });

  ErrorRendererFactory.set("json", (Json[string] options = null) @safe {
    return new DJsonErrorRenderer(options);
  });

  ErrorRendererFactory.set("text", (Json[string] options = null) @safe {
    return new DTextErrorRenderer(options);
  });

  ErrorRendererFactory.set("xml", (Json[string] options = null) @safe {
    return new DXmlErrorRenderer(options);
  });

  ErrorRendererFactory.set("web", (Json[string] options = null) @safe {
    return new DWebErrorRenderer(options);
  });

  ErrorRendererFactory.set("yaml", (Json[string] options = null) @safe {
    return new DYamlErrorRenderer(options);
  });
}
