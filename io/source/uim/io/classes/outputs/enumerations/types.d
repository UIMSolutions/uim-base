module uim.io.classes.outputs.enumerations.types;

enum OutputTypes : string {
  RAW = "raw",
  PLAIN = "plain",
  RENDER = "render"
}

string toString(OutputTypes type) {
  return type.to!string();
}

OutputTypes toOutputTypes(string type) {
  return type.to!OutputTypes();
}

unittest {
  // Test toString
  assert(toString(OutputTypes.RAW) == "raw");
  assert(toString(OutputTypes.PLAIN) == "plain");
  assert(toString(OutputTypes.RENDER) == "render");

  // Test toOutputTypes
  assert(toOutputTypes("raw") == OutputTypes.RAW);
  assert(toOutputTypes("plain") == OutputTypes.PLAIN);
  assert(toOutputTypes("render") == OutputTypes.RENDER);

  // Test invalid string throws
  assertThrown!Exception(toOutputTypes("invalid"));
}
