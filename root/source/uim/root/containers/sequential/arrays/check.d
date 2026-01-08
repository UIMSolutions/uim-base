/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.containers.sequential.arrays.check;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool isNull(V)(V[] array) {
  return array is null;
}
///
unittest {
  version (show_test)
    writeln("Testing isNull function");

  int[] array = null;
  assert(array.isNull());

  array = [1];
  assert(!array.isNull());
}

bool isEmpty(V)(V[] array) {
  return array.length == 0;
}
///
unittest {
  version (show_test)
    writeln("Testing isEmpty function");

  int[] array = null;
  assert(array.isEmpty());

  array = [1];
  assert(!array.isEmpty());
}

bool isSingle(V)(V[] array) {
  return array.length == 1;
}
///
unittest {
  version (show_test)
    writeln("Testing isSingle function");

  int[] array = [1];
  assert(array.isSingle());

  array = [1, 2];
  assert(!array.isSingle());
} 

bool isMulti(V)(V[] array) {
  return array.length > 1;
}
///
unittest {
  version (show_test)
    writeln("Testing isMulti function");

  int[] array = [1, 2];
  assert(array.isMulti());

  array = [1];
  assert(!array.isMulti());
}
