/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.containers.maps.values.map_;

mixin(Version!("test_uim_phobos"));

import uim.phobos;
@safe:

// #region getValues
V[K] getValues(K, V)(auto ref V[K] items) {
  V[K] values;
  items.byKeyValue
    .each!(item => values[item.key] = item.value);

  return values;
}

V[K] getValues(K, V)(auto ref V[K] items, K[] keys) {
  V[K] values;
  keys.filter!(key => key in items)
    .each!(key => values[key] = item[key]);

  return values;
}

V[K] getValues(K, V)(auto ref V[K] items, bool delegate(K key, V value) check) {
  V[K] values;
  () @trusted {
    items.byKeyValue
      .filter!(item => check(item.key, item.value))
      .each!(item => values[item.key] = item.value);
  }();
  return values;
}

unittest {
  auto testString = ["a": "1", "b": null, "c": "3"];
  assert(testString.filterValues().length == 2);
  writeln(testString.filterValues());

  auto testValues = ["a": 1, "b": 2, "c": 3];
  bool foo(string key, int value) {
    return value > 1;
  }

/*   assert(testValues.filterValues(&foo).length == 2); */
}
// #endregion filterValues

// #region removeByValues
V[K] removeByValues(K, V)(ref V[K] items, Json[] values) {
  values.each!(value => removeByValue(items, value));
  return items;
}

V[K] removeByValue(K, V)(ref V[K] items, Json value) {
  return null; // TODO
  /*   return hasValue(items, value)
    ? items.remove(keyByValue(items, value)) : items; */
}

unittest {
  assert(["a": "A", "b": "B", "c": "C"].length == 3);
  /* 
  assert(["a": "A", "b": "B", "c": "C"].removeByValue("A").length == 2);
  assert(["a": "A", "b": "B", "c": "C"].removeByValue("A")["c"] == "C");

  assert(["a": "A", "b": "B", "c": "C"].removeByValues("A").length == 2);
  assert(["a": "A", "b": "B", "c": "C"].removeByValues(["A", "B"]).length == 1);
  assert(["a": "A", "b": "B", "c": "C"].removeByValues("A", "B").length == 1);

  assert(["a": "A", "b": "B", "c": "C"].removeByValues("A")["c"] == "C");
  assert(["a": "A", "b": "B", "c": "C"].removeByValues(["A", "B"])["c"] == "C");
  assert(["a": "A", "b": "B", "c": "C"].removeByValues("A", "B")["c"] == "C"); */
}
// #endregion removeByValues

// #region hasValue
// Returns true if the map has all values
// Returns true if the map has all values
bool hasAllValues(K, V)(ref V[K] items, V[] values) {
  return values.all!(value => items.hasValue(value));
}

// Returns true if the map has any value
bool hasAnyValue(K, V)(ref V[K] items, V[] values) {
  return values.any!(value => items.hasValue(value));
}

// Returns true if the map has the value
bool hasValue(K, V)(ref V[K] items, V value) {
  return items.byKeyValue.any!(item => item.value == value);
}

unittest {
    string[string] test = ["a": "A", "b": "B", "c": "C"];
    assert(test.hasValue("A"));

    assert(test.hasAnyValue(["A", "B", "C"]));
    assert(test.hasAnyValue("A", "B", "C"));
    assert(test.hasAnyValue(["A", "x", "C"]));
    assert(test.hasAnyValue("A", "x", "C"));
    assert(!test.hasAnyValue(["x", "y", "z"]));
    assert(!test.hasAnyValue("x", "y", "z"));

    assert(test.hasAllValues(["A", "B", "C"]));
    assert(test.hasAllValues("A", "B", "C"));
    assert(!test.hasAllValues(["A", "X", "C"]));
    assert(!test.hasAllValues("A", "X", "C"));

    Json[string] test2 = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
    assert(test2.hasValue(Json("A")));

    assert(test2.hasAnyValue([Json("A"), Json("B"), Json("C")]));
    assert(test2.hasAnyValue(Json("A"), Json("B"), Json("C")));
    assert(test2.hasAnyValue([Json("A"), Json("y"), Json("C")]));
    assert(test2.hasAnyValue(Json("A"), Json("y"), Json("C")));
    assert(!test2.hasAnyValue([Json("x"), Json("y"), Json("z")]));
    assert(!test2.hasAnyValue(Json("x"), Json("y"), Json("z")));

    assert(test2.hasAllValues([Json("A"), Json("B"), Json("C")]));
    assert(test2.hasAllValues(Json("A"), Json("B"), Json("C")));
    assert(!test2.hasAllValues([Json("A"), Json("X"), Json("C")]));
    assert(!test2.hasAllValues(Json("A"), Json("X"), Json("C")));
}
// #endregion hasAllValues
