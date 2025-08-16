/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.formatters.factory;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

class DOutputFormatterFactory : DFactory!IOutputFormatter {
}

auto OutputFormatterFactory() {
  return DOutputFormatterFactory.instance;
}

static this() {
  OutputFormatterFactory.set("standard", (Json[string] options = new Json[string]) @safe {
    return new DTextEngineFormatterFactory(options);
  });

  OutputFormatterFactory.set("text", (Json[string] options = new Json[string]) @safe {
    return new DTextEngineFormatterFactory(options);
  });

  OutputFormatterFactory.set("html", (Json[string] options = new Json[string]) @safe {
    return new DHtmlEngineFormatterFactory(options);
  });

  OutputFormatterFactory.set("json", (Json[string] options = new Json[string]) @safe {
    return new DJsonEngineFormatterFactory(options);
  });

  OutputFormatterFactory.set("yaml", (Json[string] options = new Json[string]) @safe {
    return new DYamlEngineFormatterFactory(options);
  });

  OutputFormatterFactory.set("xml", (Json[string] options = new Json[string]) @safe {
    return new DXmlEngineFormatterFactory(options);
  });
}

unittest {
  assert(OutputFormatterFactory);
  assert(OutputFactory.create("standard").name == TextEngineFormatterFactory.name);
  assert(OutputFactory.create("text").name == TextEngineFormatterFactory.name);
  assert(OutputFactory.create("html").name == HtmlEngineFormatterFactory.name);
  assert(OutputFactory.create("json").name == JsonEngineFormatterFactory.name);
  assert(OutputFactory.create("yaml").name == YamlEngineFormatterFactory.name);
  assert(OutputFactory.create("xml").name == XmlEngineFormatterFactory.name);
}
