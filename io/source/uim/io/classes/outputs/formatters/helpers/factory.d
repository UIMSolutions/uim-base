/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.helpers.factory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputFormatterFactory : DFactory!IOutputFormatter {
  mixin(FactoryThis!("OutputFormatter"));
}
mixin(FactoryCalls!("OutputFormatter"));

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
  assert(OutputFormatterFactory.create("standard").name == TextEngineFormatterFactory.name);
  assert(OutputFormatterFactory.create("text").name == TextEngineFormatterFactory.name);
  assert(OutputFormatterFactory.create("html").name == HtmlEngineFormatterFactory.name);
  assert(OutputFormatterFactory.create("json").name == JsonEngineFormatterFactory.name);
  assert(OutputFormatterFactory.create("yaml").name == YamlEngineFormatterFactory.name);
  assert(OutputFormatterFactory.create("xml").name == XmlEngineFormatterFactory.name);
}
