/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.exceptions.interfaces.exception;

import uim.exceptions;

@safe:

interface IException {
  /*     // This interface is used to define the contract for all exception classes in the UIManufaktur framework.
    // It ensures that all exceptions have a message and a code, and provides methods for getting and setting these values.
    // The interface also defines a method for getting the exception type, which can be used to categorize exceptions.
    int getCode();
    string getType(); */

  // Exception message
  string message();

  // The file name of the D source code corresponding with where the error was thrown from.
  string file();

  // The line number of the D source code corresponding with where the error was thrown from.
  size_t line();

  // Template string that has attributes formateded into it.
  string messageTemplate(string templateName = "default");
  void messageTemplate(string templateName, string templateText);

  STRINGAA messageTemplates();
  void messageTemplates(string[string] templates);
}
