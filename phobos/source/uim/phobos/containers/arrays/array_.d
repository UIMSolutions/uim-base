/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.phobos.containers.arrays.array_;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:




// #region firstPosition
size_t firstPosition(T)(in T[] baseArray, in T value) {
  foreach (index, item; baseArray)
    if (item == value)
      return index;
  return -1;
}
///
unittest {
  assert(["1", "3", "5"].firstPosition("3") == 1);
}
// #endregion firstPosition


// #region add
// adding items into array
auto ref addValuesNotNull(T)(auto ref T[] items, in T[] values) {
  values
    .filter!(value => !value.isNull)
    .each!(value => items.addValue(value));
  return items;
}

auto ref addValues(T)(auto ref T[] items, in T[] values) {
  values.each!(value => items.addValue(value));
  return items;
}

auto ref addValue(T)(auto ref T[] items, in T value) {
  items ~= value;
  return items;
}

unittest {
  auto test1 = [1, 2, 3];
  assert(test1.addValue(4) == [1, 2, 3, 4] && test1 == [1, 2, 3, 4]);

  assert([1, 2, 3].addValue(4) == [1, 2, 3, 4]);
  assert([1, 2, 3].addValue(4).addValue(5) == [1, 2, 3, 4, 5]);

  test1 = [1, 2, 3];
  assert(test1.addValues([4, 5]) == [1, 2, 3, 4, 5] && test1 == [1, 2, 3, 4, 5]);
  assert(test1.addValue(6) == [1, 2, 3, 4, 5, 6] && test1 == [1, 2, 3, 4, 5, 6]);
  // writeln(test1.addValues(7, 8).addValues(9, 10));
  assert(test1.addValues([7, 8]).addValues([9, 10]) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  assert(test1 == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

  auto test2 = [1.0, 2.0, 3.0];
  assert(test2.addValues([4.0, 5.0]) == [1.0, 2.0, 3.0, 4.0, 5.0]);

  auto test3 = ["1", "2", "3"];
  assert(test3.addValues(["4", "5"]) == ["1", "2", "3", "4", "5"]);
}
// #endregion add



// #region sub
T[] sub(T)(T[] lhs, T rhs, bool multiple = false) {
  auto result = lhs.dup;
  if (multiple) {
    while (rhs.isIn(result))
      result = result.sub(rhs);
  } else
    foreach (i, value; result) {
      if (value == rhs) {
        result = result.remove(i);
        break;
      }
    }
  return result;
}

unittest {
  assert([1, 2, 3].sub(2) == [1, 3]);
  assert([1, 2, 3, 2].sub(2, true) == [1, 3]);
}

// sub(T)(T[] lhs, T[] rhs, bool multiple = false)
T[] sub(T)(T[] lhs, T[] rhs, bool multiple = false) {
  auto result = lhs.dup;
  rhs.each!(value => result = result.sub(value, multiple));
  return result;
}
/// 
unittest {
  assert([1, 2, 3].sub([2]) == [1, 3]);
  assert([1, 2, 3, 2].sub([2], true) == [1, 3]);
  assert([1, 2, 3, 2].sub([2, 3], true) == [1]);
  assert([1, 2, 3, 2, 3].sub([2, 3], true) == [1]);
}
// #endregion sub


OUT[] castTo(OUT, IN)(IN[] values) {
  OUT[] results;
  results.length = values.length;
  foreach (i, value; value) {
    result[i] = to!OUT(value);
  }

  return results;
}

/* unittest {
  auto values = [1, 2, 3, 4];
  change(values[2], values[3]);
  assert(values == [1, 2, 4, 3]);
  assert([1, 2, 3, 4].change([1, 3]) == [1, 4, 3, 2]);
} */

// #region index
size_t index(T)(T[] values, T value) {
  foreach (count, key; values) {
    if (key == value) {
      return count;
    }
  }

  return -1;
}
/// 
unittest {
  assert([1, 2, 3, 4].index(1) == 0);
  assert([1, 2, 3, 4].index(0) == -1);
}
// #endregion index

// #region indexes
size_t[] indexes(T)(T[] values, T value) {
  size_t[] results;
  foreach (count, key; values)
    if (key == value)
      results ~= count;
  return results;
}
///
unittest {
  assert([1, 2, 3, 4].indexes(1) == [0]);
  assert([1, 2, 3, 4].indexes(0) == null);
  assert([1, 2, 3, 4, 1].indexes(1) == [0, 4]);
}

size_t[][T] indexes(T)(T[] values, T[] keys) {
  size_t[][T] results;
  keys.each!(key => results[key] = indexes(values, key));
  return results;
}

unittest {
  assert([1, 2, 3, 4].indexes([1]) == [1: [0UL]]);
  assert([1, 2, 3, 4, 1].indexes([1]) == [1: [0UL, 4UL]]);
}
// #endregion indexes

// #endregion Searching



T[] ifNull(T)(T[] values, T[] defaultValues) {
  return values.isNull ? defaultValues : values;
}

unittest {
  // TODO create tests
}

T ifEmpty(T)(T value, T defaultValue) {
  return value.isEmpty
    ? defaultValue : value;
}

T[] ifEmpty(T)(T[] values, T[] defaultValues = null) {
  return values.isEmpty
    ? defaultValues : values;
}

unittest {
  // TODO create test
}

// #region isNull
bool isNull(T)(T[] values) {
  return values is null;
}

unittest {
  string[] values;
  assert(values.isNull);

  values ~= "x";
  assert(!values.isNull);
}
// #endregion isNull



// #region intersect 
T[] intersect(T)(T[] left, T[] right) {
  return left.filter!(item => right.hasValue(item)).array;
}
// #endregion intersect 



// Pop the element off the end of array
// #region pop
T pop(T)(auto ref T[] values) {
  switch (values.length) {
  case 0:
    return Null!T;
  case 1:
    T value = values[0];
    values = null;
    return value;
  default:
    T value = values[$ - 1];
    values = values[0 .. $ - 1];
    return value;
  }
}

unittest {
  string[] testValues;
  assert(testValues.pop is null);

  testValues = ["a"];
  assert(testValues.length == 1);
  assert(testValues.pop == "a");
  assert(testValues.length == 0);

  testValues = ["a", "b", "c"];
  assert(testValues.length == 3);
  assert(testValues.pop == "c");
  assert(testValues.length == 2);
}
// #endregion pop




// #region unique
/// Unique - Reduce duplicates in array
T[] unique(T)(T[] values) {
  T[] results;
  values.each!((value) {
    if (!results.has(value)) {
      results ~= value;
    }
  });
  return results;
}

unittest {
  assert(["a", "b", "c"].unique.length == 3);
  assert(["a", "b", "c"].unique == ["a", "b", "c"]);
  assert(["a", "b", "c", "c"].unique.length == 3);
  assert(["a", "b", "c", "c"].unique == ["a", "b", "c"]);
}
// #endregion unique

pure V[] createArray(V)() {
  V[] values = null;
  return values;
}

V[] clear(V)(ref V[] items) {
  items.length = 0;
  return items;
}

unittest {
  writeln("--- clear");
  string[] testMap = ["a", "b", "c"];
  assert(testMap.length == 3);
  assert(testMap.clear.length == 0);
  writeln(testMap);
  assert(testMap.length == 0);
}

// #region push
T[] push(T)(auto ref T[] items, T[] values) {
  values.each!(value => items.push(value));
  return items;
}

T[] push(T)(auto ref T[] items, T value) {
  items ~= value;
  return items;
}

unittest {
  string[] testMap = push(["a", "b", "c"], ["d", "e"]);
  assert(testMap == ["a", "b", "c", "d", "e"]);
  assert(testMap.length == 5);

  assert(testMap.push(["x", "y"]) == ["a", "b", "c", "d", "e", "x", "y"]);
  assert(testMap.length == 7);
}
// #endregion push

string[] getStringArray(T)(T[] values) {
  static if (is(T == string)) {
    return values;
  } else {
    return null;
  }
}

string[] toStringArray(string[] values) {
  static if (is(T == Object)) {
    return values.map!(value => value.toString).array;
  } else {
    return values.map!(value => to!string(value)).array;
  }
}

unittest {
  // assert(["a", "b", "c"] == )
}

// #region isIn
bool isIn(T)(T value, T[] values) {
  return values.any!(v => v == value);
}
/// 
unittest {
  assert(1.isIn([1, 2, 3, 4]));
  assert(!10.isIn([1, 2, 3, 4]));
}
// #endregion isIn

// #region remove
auto ref removeAllValue(T)(auto ref T[] items, T[] values) {
  T[] items = values.filter!(v => !items.hasValue(v)).array;
  return results;
}

auto ref removeValue(T)(auto ref T[] items, T value) {
  items = items.filter!(v => v != value).array;
  return items;
}

auto ref removeFirst(T)(auto ref T[] values) {
  if (values.isEmpty) {
    return values;
  }
  if (values.length == 1) {
    values = null;
  } else {
    values = values[1 .. $];
  }

  return values;
}

unittest {
  assert(["a", "b", "c"].removeFirst.length == 2);
  assert(["a", "b", "c"].removeFirst == ["b", "c"]);

  string[] testArray = ["a", "b", "c"];
  testArray.removeFirst;
  assert(testArray == ["b", "c"]);
}

T[] removeLast(T)(auto ref T[] values) {
  if (values.isEmpty) {
    return values;
  }
  if (values.length == 1) {
    values = null;
  } else {
    values = values[0 .. $ - 1];
  }

  return values;
}

unittest {
  assert(["a", "b", "c"].removeLast == ["a", "b"]);
  assert(["a", "b", "c"].removeLast.length == 2);

  string[] testArray = ["a", "b", "c"];
  testArray.removeLast;
  assert(testArray == ["a", "b"]);
}

// #endregion remove
