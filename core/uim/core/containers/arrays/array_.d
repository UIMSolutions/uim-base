/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.containers.arrays.array_;

import uim.core;

@safe:

version (test_uim_core) {
  unittest {
    writeln("-----  ", __MODULE__, "\t  -----");
  }
}

// #region size
size_t size(T)(T[] anArray) {
  return anArray.length;
}
// #region size

// #region count
size_t[T] countDuplicates(T)(in T[] baseArray...) {
  return countDuplicates(baseArray.dup);
}

size_t[T] countDuplicates(T)(in T[] someValues) {
  size_t[T] results;
  someValues
    .each!(value => results[value] = value in results ? results[value] + 1 : 1);

  return results;
}

size_t countDuplicate(T)(T[] someValues, T aValue) {
  size_t result;
  result = someValues.filter!(value => value == aValue).count;

  return result;
}

unittest {
  assert([1, 2, 3].countDuplicate(2) == 1);
  assert([1, 2, 3].countDuplicate(4) == 0);
  assert([1, 2, 2].countDuplicate(2) == 2);

  assert(countDuplicates([1]) == [1: 1uL]);
  assert(countDuplicates([1, 1]) == [1: 2uL]);
  assert(countDuplicates([1, 2]) == [1: 1uL, 2: 1uL]);

  assert(countDuplicates(1) == [1: 1uL]);
  assert(countDuplicates(1, 1) == [1: 2uL]);
  assert(countDuplicates(1, 2) == [1: 1U, 2: 1UL]);
}
// #endregion countDuplicate

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

/// Creates a associative array with all positions of a value in an array
auto positions(T)(in T[] baseArray...) {
  size_t[][T] results = positions(baseArray, null);
  return results;
}

///
unittest {
  assert(positions(1) == [1: [0UL]]);
  assert(positions(1, 1) == [1: [0UL, 1UL]]);
  assert(positions(1, 2) == [1: [0UL], 2: [1UL]]);
}

/// Creates a associative array with all positions of a value in an array
size_t[][T] positions(T)(in T[] baseArray, in T[] validValues = null) {
  size_t[][T] results;
  auto checkValues = (validValues ? baseArray.filters(validValues) : baseArray);
  foreach (pos, v; checkValues) {
    results[v] = v in results
      ? results[v] ~ pos : [pos];
  }
  return results;
}

unittest {
  assert(positions([1]) == [1: [0UL]]);
  assert(positions([1, 1]) == [1: [0UL, 1UL]]);
  assert(positions([1, 2]) == [1: [0UL], 2: [1UL]]);
  assert(positions([1, 2], [1]) == [1: [0UL]]);
}

/// adding items into array
T[] add(T)(in T[] baseArray, in T[] newItems...) {
  return add(baseArray, newItems);
}

unittest {
  assert([1, 2, 3].add(4) == [1, 2, 3, 4]);
  assert([1, 2, 3].add(4, 5) == [1, 2, 3, 4, 5]);
  assert([1.0, 2.0, 3.0].add(4.0, 5.0) == [1.0, 2.0, 3.0, 4.0, 5.0]);
  assert(["1", "2", "3"].add("4", "5") == ["1", "2", "3", "4", "5"]);
}

/// Adds items into array - same like "baseArray~newItems"
T[] add(T)(in T[] baseArray, in T[] newItems) {
  T[] results = baseArray.dup;
  results ~= newItems;
  return results;
}

unittest {
  assert([1, 2, 3].add([4, 5]) == [1, 2, 3, 4, 5]);
  assert([1.0, 2.0, 3.0].add([4.0, 5.0]) == [1.0, 2.0, 3.0, 4.0, 5.0]);
  assert(["1", "2", "3"].add(["4", "5"]) == ["1", "2", "3", "4", "5"]);
}

/// Changes positions
void change(T)(auto ref T left, ref T right) {
  T buffer = left;
  left = right;
  right = buffer;
}
/// Changs positions of elements in array
T[] change(T)(T[] values, size_t firstPosition, size_t secondPosition) {
  if ((firstPosition >= values.length) || (secondPosition >= values.length) || (
      firstPosition == secondPosition))
    return values;

  T[] results = values.dup;
  T buffer = results[firstPosition];
  results[firstPosition] = results[secondPosition];
  results[secondPosition] = buffer;
  return results;
}

unittest {
  assert(change([1, 2, 3, 4], 1, 2) == [1, 3, 2, 4]);
  assert(change(["a", "b", "c", "d"], 3, 2) == ["a", "b", "d", "c"]);
  assert(change(["a", "b", "c", "d"], 1, 1) == ["a", "b", "c", "d"]);
  assert(change(["a", "b", "c", "d"], 1, 9) == ["a", "b", "c", "d"]);
}

/// Removes
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
  assert([1, 2, 3, 2].sub([2], true) == [
      1, 3
    ]);
  assert([1, 2, 3, 2].sub([2, 3], true) == [1]);
  assert([1, 2, 3, 2, 3].sub([
        2, 3
      ], true) == [1]);
}

// filters(T)(T[] lhs, T[] rhs, bool multiple = false)
T[] filters(T)(T[] baseArray, T[] filterValues...) {
  return filters(baseArray, filterValues);
}

unittest {
  assert([1, 2, 3].filters(2) == [2]);
  assert([1, 2, 3].filters() is null);
  assert([
      1, 2, 3
    ].filters(1, 2) == [1, 2]);
}

T[] filters(T)(T[] baseArray, T[] filterValues) {
  T[] results = baseArray.filter!(item => filterValues.has(item)).array;
  return results;
}

unittest {
  assert([1, 2, 3].filters([2]) == [2]);
  assert([1, 2, 3].filters([]) == [
    ]);
}

OUT[] castTo(OUT, IN)(IN[] values) {
  OUT[] results;
  results.length = values.length;
  foreach (i, value; value) {
    result[i] = to!OUT(value);
  }

  return results;
}

unittest {
  auto values = [1, 2, 3, 4];
  change(values[2], values[3]);
  assert(values == [
      1, 2, 4, 3
    ]);
  assert([1, 2, 3, 4].change(1, 3) == [1, 4, 3, 2]);
}

// #region Searching

bool exist(T)(in T[] values, in T[] checkValues...) {
  return hasAllValues(values, checkValues);
}

bool has(T)(in T[] source, in T[] values...) {
  return hasAllValues(source, values.dup);
}

bool has(T)(in T[] source, in T[] values) {
  return hasAllValues(source, values);
}

bool hasAll(T)(in T[] source, in T[] values...) {
  return hasAllValues(source, values.dup);
}

bool hasAll(T)(in T[] source, in T[] values) {
  return hasAllValues(source, values);
}

bool hasAny(T)(in T[] source, in T[] values...) {
  return hasAnyValues(source, values.dup);
}

bool hasAny(T)(in T[] source, in T[] values) {
  return hasAnyValues(source, values);
}

// #region hasAllValues & hasValue
bool hasAllValues(T)(in T[] source, in T[] values...) {
  return hasAllValues(source, values.dup);
}

bool hasAllValues(T)(in T[] source, in T[] values) {
  return source.isEmpty || values.isEmpty
    ? false : values.all!(value => hasValue(source, value));
}
///
unittest {
  assert([1, 2, 3, 4].hasAllValues(1));
  assert(![
      1, 2, 3, 4
    ].hasAllValues(5));
  assert([1, 2, 3, 4].hasAllValues(1, 2));
  assert(![1, 2, 3, 4].hasAllValues(5, 1));
  assert([
      1, 2, 3, 4
    ].hasAllValues([1]));
  assert(![1, 2, 3, 4].hasAllValues([
        5
      ]));
  assert([1, 2, 3, 4].hasAllValues([1, 2]));
  assert(![
      1, 2, 3, 4
    ].hasAllValues([5, 1]));
}

// similar to has
bool hasAnyValues(T)(in T[] source, in T[] values...) {
  return hasAnyValues(source, values.dup);
}

bool hasAnyValues(T)(in T[] source, in T[] values) {
  if (source.isEmpty || values.isEmpty) {
    return false;
  }

  return values.any!(value => source.hasValue(value));
}
///
unittest {
  assert([1, 2, 3, 4].hasAnyValues(1));
  assert(![
      1, 2, 3, 4
    ].hasAnyValues(5));
  assert([1, 2, 3, 4].hasAnyValues(1, 2, 6));
  assert(![1, 2, 3, 4].hasAnyValues(5, 6));
  assert([
      1, 2, 3, 4
    ].hasAnyValues([1]));
  assert(![
      1, 2, 3, 4
    ].hasAnyValues([5]));
  assert([
      1, 2, 3, 4
    ].hasAnyValues([1, 2]));
  assert([
      1, 2, 3, 4
    ].hasAnyValues([1, 2, 5]));
  assert(![
      1, 2, 3, 4
    ].hasAnyValues([5, 6]));
}

bool hasValue(T)(in T[] source, in T aValue) {
  foreach (myValue; source) {
    if (myValue == aValue) {
      return true;
    }
  }
  return false;
}
// #endregion hasAllValues & hasValue

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
  assert([1, 2, 3, 4, 1].indexes(1) == [
      0, 4
    ]);
}

size_t[][T] indexes(T)(T[] values, T[] keys) {
  size_t[][T] results;
  foreach (key; keys)
    results[key] = indexes(values, key);
  return results;
}

unittest {
  assert([1, 2, 3, 4].indexes(
      [1]) == [
      1: [0UL]
    ]);

  assert([
      1, 2, 3, 4, 1
    ].indexes([1]) == [
      1: [0UL, 4UL]
    ]);
}

// #endregion Searching

// #region shift
// #region shiftFirst
T shiftFirst(T)(auto ref T[] values) {
  // IN Check
  if (values.isEmpty) {
    return null;
  }

  T value = values[0];
  values = values.length > 1
    ? values[1 .. $] : null;

  return value;
}
///
unittest {
  string[] anArray = ["x", "y", "z"];
  assert(anArray.shiftFirst == "x");
  assert(anArray == ["y", "z"]);
}
// #endregion shiftFirst
// #endregion shift

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

// #region isEmpty
bool isEmpty(T)(T[] values) {
  return values.length == 0;
}

unittest {
  int[] x;
  assert(x.isEmpty);
  assert(![1, 2, 3, 4].isEmpty);
  assert([].isEmpty);
} // #endregion isEmpty

// #region remove
T[] removeFirst(T)(auto ref T[] values) {
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

// #region intersect 
T[] intersect(T)(T[] left, T[] right) {
  return left.filter!(item => right.has(item)).array;
}

T[] intersect(T)(T[] left, Json right) {
  if (right.isArray) {
    return intersect(left,
      right.getArray.map!(val => val.get!T).array);
  }
  return null;
}

unittest {
  assert(intersect(["a", "b", "c"], ["a"]) == ["a"]);
  Json json = Json.emptyArray;
  json ~= "a";
  assert(intersect(["a", "b", "c"], json) == ["a"]);
}
// #endregion intersect 

// #region shift
T shift(T)(auto ref T[] values) {
  switch (values.length) {
  case 0:
    return Null!T;
  case 1:
    T value = values[0];
    values = null;
    return value;
  default:
    T value = values[0];
    values = values[1 .. $].dup;
    return value;
  }
}

unittest {
  string[] testValues;
  assert(testValues.shift is null);

  testValues = ["a"];
  assert(testValues.length == 1);
  assert(testValues.shift == "a");
  assert(testValues.length == 0);

  testValues = ["a", "b", "c"];
  assert(testValues.length == 3);
  assert(testValues.shift == "a");
  assert(testValues.length == 2);
}
// #endregion shift

// #region unshift
T[] unshift(T)(auto ref T[] values, T[] newValues...) {
  return unshift(values, newValues.dup);
}

T[] unshift(T)(auto ref T[] values, T[] newValues) {
  values = newValues ~ values;
  return values;
}

unittest {
  string[] testValues = ["a", "b", "c"];
  assert(testValues.unshift("x").length == 4);

  testValues = ["a", "b", "c"];
  assert(testValues.unshift("x", "y").length == 5);
  assert(testValues.has("x"));

  testValues = ["a", "b", "c"];
  assert(testValues.unshift(["x", "y"]).length == 5);
  assert(testValues == ["x", "y", "a", "b", "c"]);
}
// #endregion unshift

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

T[] slice(T)(T[] values, int startPos, int length = 0) {
  if (values.length == 0) {
    return null;
  }

  if (startPos == 0) {
    return values[0 .. (min(values.length, length))];
  }

  if (abs(startPos) > values.length) {
    return null;
  }

  return startPos > 0
    ? values[0 .. (min(values.length, length))] : values[(min(values.length, length)) .. $];
}

// #region filterValues
T[] filterValues(T)(T[] values) {
  return values.filter!(value => !value.isNull).array;
}

T[] filterValues(T)(T[] values, bool delegate(T value) check) {
  T[] results;
  () @trusted { results = values.filter!(value => check(value)).array; }();
  return results;
}

unittest {
  string[] testString = ["1", null, "3"];
  assert(testString.filterValues().length == 2);

  int[] testValues = [1, 2, 3];
  bool foo(int i) {
    return i > 1;
  }

  assert(testValues.filterValues(&foo).length == 2);
}
// #endregion filterValues

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
V[] push(V)(auto ref V[] items, V[] newItems...) {
  return push(items, newItems.dup);
}

V[] push(V)(auto ref V[] items, V[] newItems) {
  items ~= newItems;
  return items;
}

unittest {
  string[] testMap = push(["a", "b", "c"], "d", "e");
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
