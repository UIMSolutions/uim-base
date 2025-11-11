/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.configuration;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

/* private alias KeyValue = Tuple!(string, "key", Json, "value");
@property auto byKeyValue(Json[string] data)
@trusted {
  return data.byKeyValue.map!(kv => KeyValue(kv.key, kv.value)).array;
} */

// Configuration for handling config data = key: string / value: Json
class DConfiguration : IConfiguration {
  this() {
    this.initialize();
    this.name(this.classname);
  }

  this(Json[string] initData) {
    this.initialize(initData);
    this.name(this.classname);
  }

  this(string newName, Json[string] initData = null) {
    this.initialize(initData);
    this.name(newName);
  }

  bool initialize(Json[string] initData = null) {
    engine("default");
    if (initData !is null) {
      if (initData.hasKey("name")) {
        name(initData.getString("name"));
      }
      if (initData.hasKey("engine")) {
        engine(initData.getString("engine"));
      }
      /* if (initData.hasKey("entries")) {
        entries(initData.getJson("entries"));
      } */
    }
    return true;
  }

  // #region name
  protected string _name;
  string name() {
    return _name.dup;
  }

  IConfiguration name(string newName) {
    _name = newName.dup;
    return this;
  }
  // #endregion name

  // #region engine
  protected IConfigEngine _engine;
  void engine(string name) {
    _engine = ConfigEngineFactory.create(name);
  }

  /* IConfiguration engine(IConfigEngine newEngine) {
    _engine = newEngine.dup;
    return this;
  }
  */

  IConfigEngine engine() {
    return _engine; // .dup;
  }
  // #endregion engine

  // #region entries
  Json[string] entries() {
    return engine is null ? new Json[string] : engine.entries.dup;
  }

  IConfiguration entries(Json[string] newEntries) {
    if (engine !is null) {
      engine.entries = newEntries.dup;
    }
    return this;
  }
  // #endregion entries

  // #region keys
  string[] entryKeys() {
    return entries.keys.dup;
  }
  // #endregion keys

  // #region values
  Json[] entryValues() {
    return entries.values.dup;
  }
  // #endregion values

  // #region has
  mixin(HasMethods!("Entries", "Entry", "string"));

  mixin(HasMethods!("EntryValues", "EntryValue", "bool"));
  mixin(HasMethods!("EntryValues", "EntryValue", "long"));
  mixin(HasMethods!("EntryValues", "EntryValue", "double"));
  mixin(HasMethods!("EntryValues", "EntryValue", "string"));
  mixin(HasMethods!("EntryValues", "EntryValue", "Json[]"));
  mixin(HasMethods!("EntryValues", "EntryValue", "Json[string]"));
  mixin(HasMethods!("EntryValues", "EntryValue", "Json"));

  bool hasEntry(string key) {
    return entries.hasKey(key);
  }

  bool hasEntryValue(bool value) {
    return hasEntryValue(value.toJson);
  }

  bool hasEntryValue(long value) {
    return hasEntryValue(value.toJson);
  }

  bool hasEntryValue(double value) {
    return hasEntryValue(value.toJson);
  }

  bool hasEntryValue(string value) {
    return hasEntryValue(value.toJson);
  }

  bool hasEntryValue(Json[] value) {
    return hasEntryValue(value.toJson);
  }

  bool hasEntryValue(Json[string] value) {
    return hasEntryValue(value.toJson);
  }

  bool hasEntryValue(Json value) {
    return entries.values.any!(v => v == value);
  }

  unittest {
    auto config = new DConfiguration;

    // TODO
  }
  // #endregion has

  // #region is
  mixin(IsMethods!("NullEntries", "NullEntry", "string"));
  mixin(IsMethods!("EmptyEntries", "EmptyEntry", "string"));
  mixin(IsMethods!("BooleanEntries", "BooleanEntry", "string"));
  mixin(IsMethods!("LongEntries", "LongEntry", "string"));
  mixin(IsMethods!("DoubleEntries", "DoubleEntry", "string"));
  mixin(IsMethods!("StringEntries", "StringEntry", "string"));
  mixin(IsMethods!("ArrayEntries", "ArrayEntry", "string"));
  mixin(IsMethods!("MapEntries", "MapEntry", "string"));

  bool isNullEntry(string key) {
    return getEntry(key).isNull;
  }

  bool isEmptyEntry(string key) {
    return hasEntry(key)
      ? getEntry(key).isEmpty : false;
  }

  bool isBooleanEntry(string key) {
    return hasEntry(key)
      ? getEntry(key).isBoolean : false;
  }

  bool isLongEntry(string key) {
    return hasEntry(key)
      ? getEntry(key).isLong : false;
  }

  bool isDoubleEntry(string key) {
    return hasEntry(key)
      ? getEntry(key).isDouble : false;
  }

  bool isStringEntry(string key) {
    return hasEntry(key)
      ? getEntry(key).isString : false;
  }

  bool isArrayEntry(string key) {
    return hasEntry(key)
      ? getEntry(key).isArray : false;
  }

  bool isMapEntry(string key) {
    return hasEntry(key)
      ? getEntry(key).isMap : false;
  }

  unittest {
    auto config = new DConfiguration;

    /*         Json[string] values = ["a": Json(1), "b": Json(2), "c": Json(3)];
        config.set("a", true);
        assert(config.hasEntry("a") && !config.hasEntry("b"));

        config.set(["b", "c"], values);
        assert(config.hasEntry("b") && config.hasEntry("c")); */
  }
  // #endregion is

  // #region get
  // #region boolean
  mixin(GetMethods!("bool", "BooleanEntries", "BooleanEntry", "string"));

  bool getBooleanEntry(string key) {
    return hasEntry(key) ? getEntry(key).getBoolean : false;
  }
  // #endregion boolean

  // #region long
  mixin(GetMethods!("long", "LongEntries", "LongEntry", "string"));

  long getLongEntry(string key) {
    return hasEntry(key) ? getEntry(key).getLong : 0;
  }
  // #endregion long

  mixin(GetMethods!("double", "DoubleEntries", "DoubleEntry", "string"));

  double getDoubleEntry(string key) {
    return hasEntry(key) ? getEntry(key).getDouble : 0.0;
  }

  mixin(GetMethods!("string", "StringEntries", "StringEntry", "string"));
  string getStringEntry(string key) {
    return hasEntry(key) ? getEntry(key).getString : null;
  }

  mixin(GetMethods!("Json[]", "ArrayEntries", "ArrayEntry", "string"));

  Json[] getArrayEntry(string key) {
    return hasEntry(key) && getEntry(key).isArray
      ? getEntry(key).getArray : null;
  }

  mixin(GetMethods!("string[string]", "StringMapEntries", "StringMapEntry", "string"));

  string[string] getStringMapEntry(string key) {
    return hasEntry(key) && getEntry(key).isMap
      ? getEntry(key).getStringMap : null;
  }

  mixin(GetMethods!("Json[string]", "MapEntries", "MapEntry", "string"));

  Json[string] getMapEntry(string key) {
    return hasEntry(key) && getEntry(key).isMap
      ? getEntry(key).getMap : null;
  }

  mixin(GetMethods!("Json", "Entries", "Entry", "string"));
  Json opCall(string key) {
    return getEntry(key);
  }

  abstract Json getEntry(string key);

  unittest {
    auto config = new DConfiguration;
    // TODO
  }
  // #endregion get

  // #region shift
  mixin(ShiftMethods!("Json", "Entries", "Entry", "string"));

  Json shiftEntry(string key) {
    if (!hasEntry(key)) {
      return Json(null);
    }

    auto value = getEntry(key);
    removeEntry(key);
    return value;
  }

  unittest {
    auto config = new DConfiguration;
    // TODO
  }
  // #endregion shift

  // #region set
  mixin(SetMethods!("IConfiguration", "Entries", "Entry", "string", "bool"));
  mixin(SetMethods!("IConfiguration", "Entries", "Entry", "string", "long"));
  mixin(SetMethods!("IConfiguration", "Entries", "Entry", "string", "double"));
  mixin(SetMethods!("IConfiguration", "Entries", "Entry", "string", "string"));
  mixin(SetMethods!("IConfiguration", "Entries", "Entry", "string", "Json[string]"));

  // #region Json[]
  mixin(SetMethods!("IConfiguration", "Entries", "Entry", "string", "Json[]"));

  IConfiguration opCall(string key, Json[] value) {
    return setEntry(key, value);
  }

  IConfiguration setEntry(string key, Json[] value) {
    return setEntry(key, value.toJson);
  }

  unittest {
    // Create a MemoryConfiguration instance (assuming MemoryConfiguration is a concrete implementation)
    auto config = new DConfiguration();

    // Prepare Json[] value
    Json[] arr = [Json(1), Json(2), Json(3)];

    // Test setEntry(string, Json[])
    config.setEntry("numbers", arr);
    assert(config.hasEntry("numbers"), "Entry 'numbers' should exist after setEntry.");
    assert(config.getEntry("numbers").isArray, "Entry 'numbers' should be a Json array.");
    assert(config.getArrayEntry("numbers").length == 3, "Array entry should have 3 elements.");
    assert(config.getArrayEntry("numbers")[0].getLong == 1, "First element should be 1.");

    // Test opCall(string, Json[])
    config("letters", [Json("a"), Json("b")]);
    assert(config.hasEntry("letters"), "Entry 'letters' should exist after opCall.");
    assert(config.getEntry("letters").isArray, "Entry 'letters' should be a Json array.");
    assert(config.getArrayEntry("letters")[1].getString == "b", "Second element should be 'b'.");

    // Test that setEntry(string, Json[]) and opCall(string, Json[]) are equivalent
    Json[] testArr = [Json(true), Json(false)];
    config.setEntry("bools", testArr);
    assert(config.getArrayEntry("bools")[0].getBoolean == true, "First bool should be true.");
    config("bools2", testArr);
    assert(config.getArrayEntry("bools2")[1].getBoolean == false, "Second bool should be false.");
  }
  // #endregion Json[]

  mixin(SetMethods!("IConfiguration", "Entries", "Entry", "string", "Json"));

  IConfiguration opCall(string key, bool value) {
    return setEntry(key, value);
  }

  IConfiguration setEntry(string key, bool value) {
    return setEntry(key, value.toJson);
  }

  IConfiguration opCall(string key, long value) {
    return setEntry(key, value);
  }

  IConfiguration setEntry(string key, long value) {
    return setEntry(key, value.toJson);
  }

  IConfiguration opCall(string key, double value) {
    return setEntry(key, value);
  }

  IConfiguration setEntry(string key, double value) {
    return setEntry(key, value.toJson);
  }

  IConfiguration opCall(string key, string value) {
    return setEntry(key, value);
  }

  IConfiguration setEntry(string key, string value) {
    return setEntry(key, value.toJson);
  }

  IConfiguration opCall(string key, Json[string] value) {
    return setEntry(key, value);
  }

  IConfiguration setEntry(string key, Json[string] value) {
    return setEntry(key, value.toJson);
  }

  IConfiguration opCall(string key, Json value) {
    return setEntry(key, value);
  }

  abstract IConfiguration setEntry(string key, Json value);

  unittest {
    auto config = new DConfiguration;

    // TODO 
  }
  // #endregion set

  // #region update
  mixin(UpdateMethods!("IConfiguration", "Entries", "Entry", "string", "bool"));
  mixin(UpdateMethods!("IConfiguration", "Entries", "Entry", "string", "long"));
  mixin(UpdateMethods!("IConfiguration", "Entries", "Entry", "string", "double"));
  mixin(UpdateMethods!("IConfiguration", "Entries", "Entry", "string", "string"));
  mixin(UpdateMethods!("IConfiguration", "Entries", "Entry", "string", "Json[string]"));
  mixin(UpdateMethods!("IConfiguration", "Entries", "Entry", "string", "Json[]"));
  mixin(UpdateMethods!("IConfiguration", "Entries", "Entry", "string", "Json"));

  IConfiguration updateEntry(string key, bool value) {
    return updateEntry(key, value.toJson);
  }

  IConfiguration updateEntry(string key, long value) {
    return updateEntry(key, value.toJson);
  }

  IConfiguration updateEntry(string key, double value) {
    return updateEntry(key, value.toJson);
  }

  IConfiguration updateEntry(string key, string value) {
    return updateEntry(key, value.toJson);
  }

  IConfiguration updateEntry(string key, Json[] value) {
    return updateEntry(key, value.toJson);
  }

  IConfiguration updateEntry(string key, Json[string] value) {
    return updateEntry(key, value.toJson);
  }

  IConfiguration updateEntry(string key, Json value) {
    return hasEntry(key)
      ? setEntry(key, value) : this;
  }


  // #endregion update

  // #region merge
  mixin(MergeMethods!("IConfiguration", "Entries", "Entry", "string", "bool"));
  mixin(MergeMethods!("IConfiguration", "Entries", "Entry", "string", "long"));
  mixin(MergeMethods!("IConfiguration", "Entries", "Entry", "string", "double"));
  mixin(MergeMethods!("IConfiguration", "Entries", "Entry", "string", "string"));
  mixin(MergeMethods!("IConfiguration", "Entries", "Entry", "string", "Json[string]"));
  mixin(MergeMethods!("IConfiguration", "Entries", "Entry", "string", "Json[]"));
  mixin(MergeMethods!("IConfiguration", "Entries", "Entry", "string", "Json"));

  IConfiguration mergeEntry(string key, bool value) {
    return mergeEntry(key, value.toJson);
  }

  IConfiguration mergeEntry(string key, long value) {
    return mergeEntry(key, value.toJson);
  }

  IConfiguration mergeEntry(string key, double value) {
    return mergeEntry(key, value.toJson);
  }

  IConfiguration mergeEntry(string key, string value) {
    return mergeEntry(key, value.toJson);
  }

  IConfiguration mergeEntry(string key, Json[] value) {
    return mergeEntry(key, value.toJson);
  }

  IConfiguration mergeEntry(string key, Json[string] value) {
    return mergeEntry(key, value.toJson);
  }

  IConfiguration mergeEntry(string key, Json value) {
    return hasEntry(key)
      ? this : setEntry(key, value);
  }

  unittest {
    auto config = new DConfiguration;

    // TODO 
  }
  // #endregion merge

  // #region remove
  mixin(RemoveMethods!("IConfiguration", "Entries", "Entry", "string"));

  IConfiguration clearEntries() {
    removeEntries(entryKeys);
    return this;
  }

  abstract IConfiguration removeEntry(string key);

  unittest {
    auto config = new DConfiguration;
    // TODO
  }
  // #endregion remove

  // #region clone
  abstract IConfiguration clone();

  unittest {
    auto config = new DConfiguration;
    // TODO
  }
  // #endregion clone
}
