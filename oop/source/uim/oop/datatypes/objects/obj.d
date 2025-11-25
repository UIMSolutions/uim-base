/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.datatypes.objects.obj;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class UIMObject : IObject {
  // mixin TConfigurable;

  this() {
    this.initialize;
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
    objId(randomUUID);
    name("Object");

    /* auto config = ConfigurationFactory.create("memory");
    configuration(config);
    configuration.entries(initData is null ? new Json[string] : initData);
    */ 
    return true;
  }

  // #region Object ID
  protected UUID _objId;
  UUID objId() {
    return _objId;
  }
  void objId(UUID newId) {
    _objId = newId;
  }
  // #endregion Object ID

  // #region object member
  // Get the names of all members of the object.
  string[] memberNames() {
    return [__traits(allMembers, typeof(this))];
  }
  bool hasAllMember(string[] names) {
    return names.all!(name => hasMember(name));
  }
  bool hasAnyMember(string[] names) {
    return names.any!(name => hasMember(name));
  }
  bool hasMember(string checkName) {
    return memberNames.any!(name => name == checkName);
  }
  // #region object member


  /*   void opIndexAssign(T)(T value, string name) {
    switch(name) {
      case "name": this.name(value.toString);
      default: break;
    }
    return;
  } */

  /* Json opIndex(string name) {
    switch (name) {
    case "name":
      return name.toJson;
    case "classname":
      return this.classname.toJson;
    case "classFullname":
      return this.classFullname.toJson;
    case "memberNames":
      return memberNames.toJson;
    default:
      return Json(null);
    }
  } */

  Json toJson(string[] showKeys = null, string[] hideKeys = null) {
    Json json = Json.emptyObject;
    json
      .set("name", name)
      .set("classname", this.classname);

    return json;
  }

  Json[string] debugInfo(string[] showKeys = null, string[] hideKeys = null) {
    Json[string] info;

    return info
      .set("name", name)
      .set("classname", this.classname)
      .set("classFullname", this.classFullname);
  }

  // #region IObject
  protected string _name;
  // Get the name of the object.
  string name() {
    return _name;
  }

  // Get or set the name of the object.
  void name(string newName) {
    _name = newName.dup;
  }

  // Compares two IObject instances for equality based on their names.
  bool isEqual(IObject other) {
    if (this !is other) {
      return false;
    }
    if (this.name is null || other.name is null) {
      return false;
    }
    if (cast(IObject)other is null) {
      return false;
    }

/*  if (this.classinfo !is other.classinfo) {
      return false;
    }
    if (other is null) {
      return false;
    } */
    return this.name == other.name;
    // TODO: Consider adding more properties for comparison if needed.
  }

  // Returns a string representation comparing two IObject instances.
  override string toString() {
    return "Object: " ~ this.name;
  }

  // Creates a clone of the current object.
  IObject clone() {
    auto obj = new UIMObject;
    obj.name(this.name);
    return obj;
  }
  // #endregion IObject

}

class Test : UIMObject {
  this() {
    super();
  }

  string newMethod() {
    return null;
  }

  override string[] memberNames() {
    return [__traits(allMembers, typeof(this))];
  }
}

unittest {
  //   auto obj = new IMObject;

}
