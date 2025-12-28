/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.strings;

public {
  import uim.root.datatypes.strings.camelize;
  import uim.root.datatypes.strings.capitalize;
  import uim.root.datatypes.strings.classify;
  import uim.root.datatypes.strings.delimit;
  import uim.root.datatypes.strings.endswith;
  import uim.root.datatypes.strings.humanize;
  import uim.root.datatypes.strings.lower;
  import uim.root.datatypes.strings.md5;
  import uim.root.datatypes.strings.pascalize;
  import uim.root.datatypes.strings.pluralize;
  import uim.root.datatypes.strings.singularize;
  import uim.root.datatypes.strings.striptext;
  import uim.root.datatypes.strings.startswith;
  import uim.root.datatypes.strings.tableize;
  import uim.root.datatypes.strings.underscore;
  import uim.root.datatypes.strings.upper;
}

static immutable string[string] singularIrregulars;
static immutable string[string] pluralIrregulars;
shared static this() {
  singularIrregulars = [
    "people": "person",
    "men": "man",
    "women": "woman",
    "children": "child",
    "teeth": "tooth",
    "feet": "foot",
    "mice": "mouse",
    "oxen": "ox",
    "geese": "goose"
  ];

  pluralIrregulars = [
    "person": "people",
    "man": "men",
    "woman": "women",
    "child": "children",
    "tooth": "teeth",
    "foot": "feet",
    "mouse": "mice",
    "ox": "oxen",
    "goose": "geese"
  ];
}