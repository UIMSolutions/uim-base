/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.tests.error;

mixin(Version!"test_uim_errors");

import uim.errors;
@safe:


bool testError(IError error) {
  assert(error !is null, "Error is null");
  return true;
}
