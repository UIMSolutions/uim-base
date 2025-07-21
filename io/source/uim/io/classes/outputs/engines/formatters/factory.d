/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.consoles.classes.outputs.engines.formatters.factory;

mixin(Version!"test_uim_consoles");

import uim.consoles;

@safe:

class DOutputEngineFormatterFactory : DFactory!IOutputEngineFormatter {
}

auto OutputEngineFormatterFactory() {
  return DOutputEngineFormatterFactory.instance;
}

static this() {
  OutputEngineFormatterFactory.set("standard", (Json[string] options = new Json[string]) @safe {
    return new DTextEngineFormatterFactory(options);
  });

  OutputEngineFormatterFactory.set("text", (Json[string] options = new Json[string]) @safe {
    return new DTextEngineFormatterFactory(options);
  });

  OutputEngineFormatterFactory.set("html", (Json[string] options = new Json[string]) @safe {
    return new DHtmlEngineFormatterFactory(options);
  });

  OutputEngineFormatterFactory.set("json", (Json[string] options = new Json[string]) @safe {
    return new DJsonEngineFormatterFactory(options);
  });

  OutputEngineFormatterFactory.set("yaml", (Json[string] options = new Json[string]) @safe {
    return new DYamlEngineFormatterFactory(options);
  });

  OutputEngineFormatterFactory.set("xml", (Json[string] options = new Json[string]) @safe {
    return new DXmlEngineFormatterFactory(options);
  });
}

unittest {
  assert(OutputEngineFormatterFactory);
  assert(OutputFactory.create("standard").name == TextEngineFormatterFactory.name);
  assert(OutputFactory.create("text").name == TextEngineFormatterFactory.name);
  assert(OutputFactory.create("html").name == HtmlEngineFormatterFactory.name);
  assert(OutputFactory.create("json").name == JsonEngineFormatterFactory.name);
  assert(OutputFactory.create("yaml").name == YamlEngineFormatterFactory.name);
  assert(OutputFactory.create("xml").name == XmlEngineFormatterFactory.name);
}
