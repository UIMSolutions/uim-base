/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.datatypes.objects.obj;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

/// Basic implementation of the IObject interface.
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
  /// Get the unique object ID.
  UUID objId() {
    return _objId;
  }
  /// 
  unittest {
    auto obj = new UIMObject;
    assert(obj.objId != NULL_UUID);
  }

  /// Set the unique object ID.
  void objId(UUID newId) {
    _objId = newId;
  }
  ///
  unittest {
    // Test objId setter with valid UUID
    auto obj = new UIMObject;
    auto newId = randomUUID;
    obj.objId(newId);
    assert(obj.objId == newId);
  }
  // #endregion Object ID

  // #region object member
  /// Get the names of all members of the object.
  string[] memberNames() {
    return [__traits(allMembers, typeof(this))];
  }
  ///
  unittest {
    // Test memberNames returns non-empty array
    auto obj1 = new UIMObject;
    auto members1 = obj1.memberNames();
    assert(members1.length > 0);

    // Test memberNames contains expected base members
    auto obj2 = new UIMObject;
    auto members2 = obj2.memberNames();
    assert(members2.canFind("name"));
    assert(members2.canFind("objId"));
    assert(members2.canFind("initialize"));
  }

  /** 
  Check if the object has all specified members. 
  
  Params: 
    names = The names to check 

  Returns: 
    Returns 'true' if all members exist, 'false' otherwise
  */
  bool hasAllMember(string[] names) {
    return names.all!(name => hasMember(name));
  }
  /// 
  unittest {
    // Test hasAllMember with all existing members
    auto obj1 = new UIMObject;
    assert(obj1.hasAllMember(["name", "objId"]));

    // Test hasAllMember with some non-existing members
    auto obj2 = new UIMObject;
    assert(!obj2.hasAllMember(["name", "nonExistentMember"]));
  }

  /** 
  Check if the object has any of the specified members.

  Params: 
    names = The names to check

  Returns: 
    Returns 'true' if any member exists, 'false' otherwise
  */
  bool hasAnyMember(string[] names) {
    return names.any!(name => hasMember(name));
  }
  ///
  unittest {
    // Test hasAnyMember with at least one existing member
    auto obj1 = new UIMObject;
    assert(obj1.hasAnyMember(["name", "nonExistentMember"]));

    // Test hasAnyMember with all existing members
    auto obj2 = new UIMObject;
    assert(obj2.hasAnyMember(["name", "objId", "initialize"]));
  }

  /**
  Checks if the object has a member with the specified name.
  
  Params:
    checkName = The name of the member to search for.
  
  Returns:
    true if a member with the given name exists, false otherwise.
  */
  bool hasMember(string checkName) {
    return memberNames.any!(name => name == checkName);
  }
  ///
  unittest {
    auto obj1 = new UIMObject;
    assert(obj1.hasMember("name")); // existing member
    assert(obj1.hasMember("objId")); // existing member
    assert(obj1.hasMember("initialize")); // existing member
    assert(!obj1.hasMember("nonExistentMember")); // non-existing member

    auto obj2 = new UIMObject;
    assert(!obj2.hasMember("Name")); // case sensitivity
    assert(obj2.hasMember("name")); // correct case
  }
  // #region object member

  // #region name
  protected string _name;
  // Get the name of the object.
  string name() {
    return _name;
  }

  // Get or set the name of the object.
  void name(string newName) {
    _name = newName.dup;
  }
  // #endregion name

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

  // #region debugInfo
  // Provides debug information about the object.
  Json[string] debugInfo(string[] showKeys = null, string[] hideKeys = null) {
    Json[string] info;

    return info
      .set("name", name)
      .set("classname", this.classname)
      .set("classFullname", this.classFullname);
  }
  // #region debugInfo

  // #region IObject

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
