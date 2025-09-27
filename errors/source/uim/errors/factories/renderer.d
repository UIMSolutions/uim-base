/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.factories.renderer;

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:

class UIMErrorRendererFactory : DFactory!UIMErrorRenderer {
  mixin(FactoryThis!("ErrorRenderer"));
}
auto ErrorRendererFactory() { return UIMErrorRendererFactory.instance; }

static this() {
  ErrorRendererFactory.setKey("console", (Json[string] options = null) @safe {
    return new DConsoleErrorRenderer(options);
  });

  ErrorRendererFactory.setKey("html", (Json[string] options = null) @safe {
    return new DHtmlErrorRenderer(options);
  });

  ErrorRendererFactory.setKey("json", (Json[string] options = null) @safe {
    return new DJsonErrorRenderer(options);
  });

  ErrorRendererFactory.setKey("text", (Json[string] options = null) @safe {
    return new DTextErrorRenderer(options);
  });

  ErrorRendererFactory.setKey("xml", (Json[string] options = null) @safe {
    return new DXmlErrorRenderer(options);
  });

  ErrorRendererFactory.setKey("web", (Json[string] options = null) @safe {
    return new DWebErrorRenderer(options);
  });

  ErrorRendererFactory.setKey("yaml", (Json[string] options = null) @safe {
    return new DYamlErrorRenderer(options);
  });
}
