/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.interfaces.runnable;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IRunnable {
  IRunnable run();
  IRunnable run(Json data);
  IRunnable run(Json[string] data);

  IRunnable finalize();
  IRunnable finalize(Json[string] data);

  // True if instance is running.
  bool isRunning();
}