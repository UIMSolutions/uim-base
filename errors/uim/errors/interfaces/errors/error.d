/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.interfaces.errors.error;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:

interface IError {
  string loglabel();
  IError loglabel(string newLabel);

  // Read-Only
  string loglevel();
  // Read-Only
  string line();

  string message();
  IError message(string newMessage);

  string fileName();
  IError fileName(string newFileName);

  size_t lineNumber();
  IError lineNumber(size_t newLineNumber);

  STRINGAA[] trace();
  IError trace(STRINGAA[] newTrace);
  string traceAsString();
}
