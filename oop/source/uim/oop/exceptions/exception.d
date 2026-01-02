/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.exceptions.exception;

import uim.oop;

mixin(Version!("test_uim_oop"));

@safe:

/// Base class that all UIM Exceptions extend.
class UIMException : UIMObject, IException {
  mixin(ExceptionThis!());

  override bool initialize(Json[string] options = new Json[string]) {
    _attributes.set(options);
    messageTemplate("default", "");
    _messageTemplates = new UIMDirectory!string;

    return true;
  }

  mixin(TProperty!("string", "message"));
  mixin(TProperty!("string", "registerPath"));

  /**
     * Array of attributes that are passed in from the constructor, and
     * made available in the view when a development error is displayed.
     */
  mixin(TProperty!("Json[string]", "attributes"));

  // Default exception code
  protected int _defaultCode = 0;

  protected STRINGAA _stringContents;

  // #region messageTemplate
  // Template string that has attributes format() into it.
  protected string _messageTemplate = "";
  // #region messageTemplates
  protected IDirectory!string _messageTemplates;
  // Gets all message templates.
  string[] messageTemplates() {
    string[] keys = _messageTemplates.keys();
    return _messageTemplates.values(keys);
  }

  /** 
    * Sets multiple message templates at once.
    *
    * Params:
    *   templates - An associative array of template names to template strings.
    */
  void messageTemplates(string[string] newTemplates) {
    _messageTemplates(newTemplates.dup);
  }
  ///
  unittest {
    // Test: messageTemplates sets multiple templates
    auto ex1 = new UIMException;
    ex1.messageTemplates(["error": "Error: %s", "warning": "Warning: %s"]);
    assert(ex1.messageTemplate("error") == "Error: %s");
    assert(ex1.messageTemplate("warning") == "Warning: %s");

    // Test: messageTemplates overwrites existing templates
    auto ex2 = new UIMException;
    ex2.messageTemplate("info", "Old info");
    ex2.messageTemplates(["info": "New info", "debug": "Debug: %s"]);
    assert(ex2.messageTemplate("info") == "New info");
    assert(ex2.messageTemplate("debug") == "Debug: %s");
  
    // Test: messageTemplates with empty map
    auto ex3 = new UIMException;
    ex3.messageTemplate("test", "Test message");
    ex3.messageTemplates(null);
    // Should clear or set to empty

    // Test: messageTemplates preserves duplicates
    auto ex4 = new UIMException;
    string[string] templates = ["key1": "value1", "key2": "value2"];
    ex4.messageTemplates(templates);
    templates["key1"] = "modified";
    // Verify original is not affected due to .dup
    assert(ex4.messageTemplate("key1") == "value1");

    // Test: messageTemplates with special characters
    auto ex5 = new UIMException;
    ex5.messageTemplates([
      "special": "Error with %s and %d",
      "unicode": "Ошибка: %s"
    ]);
    assert(ex5.messageTemplate("special") == "Error with %s and %d");
    assert(ex5.messageTemplate("unicode") == "Ошибка: %s");
  }
  // #endregion messageTemplates
  
  // #region messageTemplate
  /** 
   * Sets multiple message templates at once.
   * Params:
   *   newTemplates = An associative array of template names to template strings.
   */
  string messageTemplate(string templateName = "default") {
    return _messageTemplates(templateName);
  }

  void messageTemplate(string templateName, string templateText) {
    _stringContents[templateName] = templateText;
  }
  // #endregion messageTemplate

  /* Json toJson(string[] showKeys = null, string[] hideKeys = null) {
    Json json = Json.emptyObject;
    json
      .set("name", name)
      .set("classname", this.classname);

    return json;
  } */

  /*  Json[string] debugInfo(string[] showKeys = null, string[] hideKeys = null) {
    Json[string] info;
    return info
      .set("name", name)
      .set("classname", this.classname);
  } */
}

/**
 * Base class that all UIM Exceptions extend.
 *
 * @method int getCode() Gets the Exception code.
 */
//class UIMException : IException /* : RuntimeException */ {
/**
     * Array of attributes that are passed in from the constructor, and
     * made available in the view when a development error is displayed.
     */
// --- protected string _messageTemplate = "";

// Array of headers to be passed to {@link uim.Http\Response.withHeader()}
//protected STRINGAA _responseHeaders;

// --- protected int _defaultCode = 0;

/**
     * Constructor.
     *
     * Allows you to create exceptions that are treated as framework exceptions and disabled
     * when // debugmode is off.
     * /
this( /* string[] * / string myMessage = "", int errorCode = null, Throwable previousException = null) {
  if (myMessage.isArray) {
    _attributes = myMessage;
    myMessage = vsprintf(_messageTemplate, myMessage);
  }
  super(myMessage, errorCode ?  ? _defaultCode, previousException);
}
*/
