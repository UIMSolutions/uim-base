/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.nodes.node;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

class DErrorNode : UIMObject, IErrorNode {
  mixin(ErrorNodeThis!());

  // #region value
  protected Json _value;
  Json value() {
    return _value;
  }

  IErrorNode value(Json newValue) {
    _value = newValue;
    return this;
  }
  // #endregion value

  // #region children
  // Get Item nodes
  protected IErrorNode[] _children;
  IErrorNode children(IErrorNode[] nodes) {
    _children = nodes;
    return this;
  }

  IErrorNode[] children() {
    return _children;
  }
  // #endregion children
}

unittest {
  Json json = Json.emptyObject;
  json["a"] = 1;

  auto node = new DErrorNode;
  node.value(json);
  assert(node.value["a"] == 1);
  assert(node.children.length == 0);
}
