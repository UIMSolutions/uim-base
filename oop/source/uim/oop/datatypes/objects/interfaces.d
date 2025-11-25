/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.datatypes.objects.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IObject {
  // Get the name of the object.
  string name(); 

  // Get or set the name of the object.
  void name(string newName); 

  // Compares two IObject instances for equality based on their names.
  bool isEqual(IObject other); 

  // Returns a string representation comparing two IObject instances.
  string toString(); 

  // Creates a clone of the current object.
  IObject clone(); 
}