/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.debuggers.debugger;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

// Provide custom logging and error handling.
class DDebugger : UIMObject, IErrorDebugger {
  this() {
    super("Debugger");
  }

  this(Json[string] initData) {
    super("Debugger", initData);
  }

  this(string name, Json[string] initData = null) {
    super(name, initData);
  }

  // Hook method
  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    configuration
      .setEntry("outputMask", Json.emptyArray)
      .setEntry("exportFormatter", Null!Json)
      .setEntry("editor", "vscode");

  // A map of editors to their link templates.
    _editors = [
      "atom": "atom://core/open/file?filename={file}&line={line}",
      "emacs": "emacs://open?url=file://{file}&line={line}",
      "macvim": "mvim://open/?url=file://{file}&line={line}",
      "sublime": "subl://open?url=file://{file}&line={line}",
      "textmate": "txmt://open?url=file://{file}&line={line}",
      "vscode": "vscode://file/{file}:{line}",
    ];

  /**
     * Mapping for error renderers.
     *
     * Error renderers are replacing output formatting with
     * an object based system. Having Debugger handle and render errors
     * will be deprecated and the new DErrorTrap system should be used instead.
     */
    _renderers = [
        "txt": TextErrorRenderer.name,
        // The html alias currently uses no JS and will be deprecated.
        "js": HtmlErrorRenderer.name
    ];

    _stringContents = null;

    // These templates are not actually used, as Debugger.log() is called instead.
    setStringContent("log", MapHelper.create!(string, Json)
      .set("trace", "{:reference} - {:path}, line {:line}")
      .set("error", "{:error} ({:code}): {:description} in [{:file}, line {:line}]"));

    setStringContent("log", MapHelper.create!(string, Json)
      .set("trace", "{:reference} - {:path}, line {:line}")
      .set("error", "{:error} ({:code}): {:description} in [{:file}, line {:line}]"));

    setStringContent("js", MapHelper.create!(string, Json)
      .set(["error", "info", "code", "dumpContext"], "")
      .set("trace", htmlDoubleTag("pre", ["stack-trace"], "{:trace}"))
      .set("links", Json.emptyArray)
      .set("escapeContext", true));

    setStringContent("html", MapHelper.create!(string, Json)
      .set("trace", htmlDoubleTag("pre", ["uim-error trace"], "<b>Trace</b> <p>{:trace}</p>"))
      .set("dumpContext", htmlDoubleTag("pre", [
            "uim-error dumpContext"
          ], "<b>Context</b> <p>{:dumpContext}</p>"))
      .set("escapeContext", true));

    setStringContent("txt", MapHelper.create!(string, Json)
      .set(["code", "info"], "")
      .set("error", "{:error}: {:code} . {:description} on line {:line} of {:path}\n{:info}"));

    setStringContent("base", MapHelper.create!(string, Json)
      .set("traceLine", "{:reference} - {:path}, line {:line}")
      .set("trace", "Trace:\n{:trace}\n")
      .set("dumpContext", "Context:\n{:dumpContext}\n"));

    return true;
  }

  // The current output format.
  protected string _outputFormat = "js";

  // Getter for outputFormat
  string outputFormat() const {
    return _outputFormat;
  }

  // Setter for outputFormat
  void outputFormat(string value) {
    _outputFormat = value;
  }

  // Returns a reference to the Debugger singleton object instance.
  protected static DDebugger _debugger;
  static DDebugger debugger() {
    if (_debugger is null) {
      _debugger = new DDebugger();
    }
    return _debugger;
  }

  // #region editors
  /**
     * A map of editors to their link templates.
     *
     * The keys are editor names, and the values are either a string template
     * or a closure that returns a string. The template can use `{file}` and `{line}`
     * placeholders.
     */
  // A map of editors to their link templates.
  protected STRINGAA _editors;

  // Getter for editors
  STRINGAA editors() {
    return _editors;
  }
  string editor(string name) {
    return name in _editors ? _editors[name] : null;
  }

  // Setter for editors
  void editors(STRINGAA values) {
    _editors = values;
  }
    /**
     * Add an editor link format
     *
     * Template strings can use the `{file}` and `{line}` placeholders.
     * Closures templates must return a string, and accept two parameters:
     * The file and line.
     */
  void addEditor(string editorName, string templateText) {
    _editors[editorName] = templateText;
  }

  // Choose the editor link style you want to use.
  void setEditor(string editorName) {
    if (editorName !in _editors) {
      auto known = editors.keys.join(", ");
      throw new DInvalidArgumentException(
        "Unknown editor `%s`. Known editors are `%s`."
          .format(editorName, known)
      );
    }
    configuration.setEntry("editor", name);
  }

  bool hasEditor(string editorName) {
    return editorName in _editors ? true : false;
  }

  // Get a formatted URL for the active editor.
  string editorUrl(string filename, int lineNumber) {
    auto editorName = configuration.getStringEntry("editor");
    if (!hasEditor(editorName)) {
      throw new DInvalidArgumentException(
        "Cannot format editor URL `%s` is not a known editor."
          .format(editorName));
    }

    auto templateText = editor(editorName);
    return templateText
      .mustache(["file", "line"], [filename, to!string(lineNumber)]);
  }

unittest {
    // Test getter and setter for editors
    // DDebugger dbg = new DDebugger();

    // Prepare a test editors map
    // STRINGAA testEditors = [
    //     "vscode": "vscode://file/{file}:{line}",
    //     "sublime": "subl://open?url=file://{file}&line={line}"
    // ];

    /* dbg.editors(testEditors);
    assert(dbg.editors().equal(testEditors), "Editors getter/setter failed");

    // Test addEditor
    dbg.addEditor("atom", "atom://core/open/file?filename={file}&line={line}");
    assert("atom" in dbg.editors(), "addEditor did not add new editor");
    assert(dbg.editors()["atom"] == "atom://core/open/file?filename={file}&line={line}", "addEditor value mismatch");

    // Overwrite an existing editor
    dbg.addEditor("vscode", "custom://{file}:{line}");
    assert(dbg.editors()["vscode"] == "custom://{file}:{line}", "addEditor did not overwrite existing editor");
 */
 }  
// #endregion editors

  // #region stringContents
  /**
     * Templates used when generating trace or error strings. Can be global or indexed by the format
     * value used in _outputFormat.
     */
  protected Json[string][string] _stringContents;

  // Getter for _stringContents
  Json[string][string] stringContents() {
    return _stringContents;
  }

  // Setter for _stringContents
  void stringContents(Json[string][string] value) {
    _stringContents = value;
  }

  void setStringContent(string name, Json[string] values) {
    _stringContents[name] = values;
  }
  // #endregion stringContents

  // #region renderers
  protected STRINGAA _renderers; 

  // Getter for _renderers
  STRINGAA renderers() {
    return _renderers;
  }

  // Setter for _renderers
  void renderers(STRINGAA value) {
    _renderers = value;
  }
  // #endregion renderers

  // #region data
  protected Json[string] _data = null;

  // Getter for _data
  Json[string] data() {
    return _data;
  }

  // Setter for _data
  void data(Json[string] value) {
    _data = value;
  }
  // #endregion data

  /*
    //Holds current output data when outputFormat is false.
    this() {
        docRef = ini_get("docref_root");
        if (isEmpty(docRef) && function_hasKey("ini_set")) {
            ini_set("docref_root", "https://secure.d.net/");
        }
        if (!defined("ERRORS.RECOVERABLE_ERROR")) {
            define("ERRORS.RECOVERABLE_ERROR", 4096);
        }
        aConfig = intersectinternalKey(configuration.getArrayEntry("Debugger"), _defaultConfigData);
        configuration.setEntry(aConfig);
    }
    
  /**
     * Read or write configuration options for the Debugger instance.
     * Params:
     * Json[string]|string key The key to get/set, or a complete array of configs.
     */
  Json[string] nullInstance(string[] key = null, Json aValue = null, bool shouldMerge = true) {
    if (key.isNull) {
      // return debugger.configuration.getEntry(key);
    }

    /*         if (key.isArray || func_num_args() >= 2) {
            return debugger.setConfig(key, aValue, shouldMerge);
        }
 */
    // return debugger.configuration.getEntry(key);
    return null;
  }

  // #region outputMask
  // Reads the current output masking.
  STRINGAA outputMask() {
    return configuration.getStringMapEntry("outputMask");
  }

  /**
     * Sets configurable masking of debugger output by property name and array key names.
     * ### Example
     * Debugger.setOutputMask(["password": '[*************]");
     */
  void setOutputMask(Json[string] keyReplaceData) {
    configuration.setEntry("outputMask", keyReplaceData);
  }
  void mergeOutputMask(Json[string] keyReplaceData) {
    configuration.mergeEntry("outputMask", keyReplaceData);
  }
  void updateOutputMask(Json[string] keyReplaceData) {
    configuration.updateEntry("outputMask", keyReplaceData);
  }

  /**
     * Sets configurable masking of debugger output by property name and array key names.
     *
     * ### Example
     * Debugger.setOutputMask(["password": "[*************]");
     */
  void outputMask(Json[string] values, bool shouldMerge = true) {
    if (shouldMerge) {
      mergeOutputMask(values);
    } else {
      setOutputMask(values);
    }
  }
  // #endregion outputMask

  // #region trace
    /**
     * Outputs a stack trace based on the supplied options.
     *
     * ### Options
     *
     * - `depth` - The number of stack frames to return. Defaults to 999
     * - `format` - The format you want the return. Defaults to the currently selected format. If
     *  format is 'array' or 'points' the return will be an array.
     * - `args` - Should arguments for functions be shown? If true, the arguments for each method call
     * will be displayed.
     * - `start` - The stack frame to start generating a trace from. Defaults to 0
     */
  string[] trace(Json[string] options = new Json[string]) {
    import core.runtime;

    Throwable.TraceInfo traceInfo = null;
    () @trusted { traceInfo = core.runtime.defaultTraceHandler(); }();

    return formatTrace(traceInfo, options);
  }

  /**
     * Formats a stack trace based on the supplied options.
     *
     * ### Options
     *
     * - `depth` - The number of stack frames to return. Defaults to 999
     * - `format` - The format you want the return. Defaults to 'text'. If
     *  format is 'array' or 'points' the return will be an array.
     * - `args` - Should arguments for functions be shown? If true, the arguments for each method call
     * will be displayed.
     * - `start` - The stack frame to start generating a trace from. Defaults to 0
     */
  static string[] formatTrace(Throwable throwable, Json[string] options = new Json[string]) {
    import core.runtime;

    return (throwable is null)
      ? null
      : formatTrace(throwable.info, options);
  }
  
  static string[] formatTrace(Throwable.TraceInfo traceInfo, Json[string] options = new Json[string]) {
    /* if (cast(Throwable) traceInfo) {
      traceInfo = traceInfo.getTrace();
    }

    options
      .merge("depth", 999)
      .merge("format", "text")
      .merge("args", false)
      .merge("start", 0)
      .merge("scope", Null!Json)
      .merge("exclude", ["call_user_func_array", "trigger_error"]); */

    /* auto count = count(traceInfo) + 1;
    string[] back = null; */

    /*     for (index = options.getLong("start"); index < count && index < options.getLong("depth");
      index++) {
      frame = ["file": "[main]", "line": ""];
      if (isSet(traceInfo[index])) {
        frame = traceInfo[index] ~ ["file": "[internal]", "line": "??"];
      }
      string signature = frame.getString("file");
      string reference = frame.getString("file");
      if (!frame.isEmpty("class")) {
        string signature = frame.getString("class") ~ frame.getString(
          "type") ~ frame.getString("function");
        string reference = signature ~ "(";
        if (options.hasKey("args") && frame.hasKey("args")) {
          reference ~= frame["args"].map!(arg => Debugger.exportVar(arg)).join(", ");
        }
        reference ~= ")";
      }
      if (isIn(signature, options.get("exclude"), true)) {
        continue;
      }

      if (options.getString("format") == "points") {
        back ~= [
          "file": frame("file"),
          "line": frame("line"),
          "reference": reference
        ];
      } else if (options.getString("format") == "array") {
        if (!options.hasKey("args")) {
          frame.removeKey("args");
        }
        back ~= frame;
      } else if (options.getString("format") == "text") {
        somePath = trimPath(frame["file"]);
        back ~= "%s - %s, line %d".format(reference, somePath, frame["line"]);
      } else {
        /* debug (options);
                throw new DInvalidArgumentException(
                    "Invalid trace format of `{options.get(\"format\"]}` chosen. Must be one of `array`, `points` or `text`."
               ); * /
      }
    }
    if (options.getString("format") == "array" || options.getString("format") == "points") {
      return back;
    } */
    // return back.join("\n");
    return null;
  }

  /**
     * Formats a stack trace based on the supplied options.
     *
     * ### Options
     *
     * - `depth` - The number of stack frames to return. Defaults to 999
     * - `format` - The format you want the return. Defaults to the currently selected format. If
     *   format is "array" or "points" the return will be an array.
     * - `args` - Should arguments for functions be shown? If true, the arguments for each method call
     *  will be displayed.
     * - `start` - The stack frame to start generating a trace from. Defaults to 0
     * /
  string formatTrace(Throwable backtrace, Json[string] options = null) {
    auto trace = backtrace.info;

/*     options = options.merge([
      "depth": 999.toJson,
      "format": _outputFormat.toJson,
      "args": toJson(false),
      "start": 0.toJson,
      "scope": null.toJson,
      "exclude": [
        "call_user_func_array",
        "trigger_error"
      ].toJson
    ]);

    auto count = count(backtrace);
    string back = null;
    _trace = MapHelper.create!(string, Json)
      .set("line", "??")
      .set("file", "[internal]")
      .set("class", Null!Json)
      .set("function", "[main]");

    auto start = options.getLong("start");
    auto depth = options.getLong("depth");
    for (i = start; i < count && i < depth; i++) {
      formattedTrace ~= formatTraceValue();
  }

  auto optionFormat = options.getString("format"); * /
    string formattedTrace;
  return formattedTrace;
/*   optionFormat == "array" || optionFormat == "points"
    ? formattedTrace 
    : formattedTrace.join("\n"); * /
}

string formatTraceValue(long index, Json[] backtrace, Json[string] options = null) {
  auto trace = backtrace[index].merge([
    "file": "[internal]",
    "line": "??"
  ]);
  string signature = "[main]";
  string reference = "[main]";

  if (backtrace[index + 1] != Null!Json) {
    auto next = backtrace[index + 1].merge(trace);
    signature = next["function"].getString;
    // string signature = reference;

    if (!next.isEmpty("class")) {
      signature = next.getString("class") ~ "." ~ next.getString("function");
      reference = signature ~ "(";
      if (options.isNull("args") && next.hasKey("args")) {
        // reference ~= next["args"].getArray.map!(arg => exportVar(arg)).join(", ");
      }
      reference ~= ")";
    }
  }
/*   if (hasAllValues(options, signature/* , options.getBoolean("exclude", true) * /)) {
    return reference;
  }
 * /
  auto formatValue = options.getString("format");
  Json back = Json.emptyObject;
  if (formatValue == "points") {
    back.set([
      "file": trace["file"],
      "line": trace["line"],
      "reference": reference.toJson
    ]);
  } else if (formatValue == "array") {
    if (!options.hasKey("args")) {
      trace.removeKey("args");
    }
    back.set(trace);
  } else {
    formatValue = options.getString(
      "format");
    auto tpl = _stringContents.path([
        formatValue,
        "traceLine"
      ], _stringContents.path([
          "base",
          "traceLine"
        ]));
  }
  trace.set("path", trace["file"].getString/* trimPath(trace["file"]) * /);
  trace.set("reference", reference);
  trace.removeKeys(["object", "args"]);
  /* back ~= Text.insert(tpl, trace, [
      "before": "{:",
      "after": "}"
    ]); * /
  return back.toString;
} */
  // #endregion trace

  // #region typename
  static string getTypeName(Json value) {
  auto type = value.getString("typeName");

  if (type == "NULL") {
    return "null";
  }

  if (type == "double") {
    return "float";
  }

  if (
    type == "unknown type") {
    return "unknown";
  }

  return type;
}
  // #endregion typename

  // #region dump
  // Recursively formats and outputs the contents of the supplied variable.
  void dump(Json valueToDump, int maxOutputDepth = 3) {
    // pr(exportVar(valueToDump, maxOutputDepth));
  }
  // #endregion dump

  // #region export
  // Get the configured export formatter or infer one based on the environment.
IErrorFormatter exportFormatter() {
        string formatterName = configuration.getStringEntry("exportFormatter");
        if (!formatterName) {
            formatterName = "text"; // TextErrorFormatter is the default.
        }

        return ErrorFormatterFactory(formatterName);
    }
    
// Converts a variable to a plain text string.
/* static string exportVarAsPlainText(Json value, int maxOutputDepth = 3) {
        return (new DTextFormatter()).dump(
            export_(
                value, new DDebugContext(
                maxOutputDepth))
        );
    } */

/**
     * Convert the variable to the internal node tree.
     *
     * The node tree can be manipulated and serialized more easily
     * than many object graphs can.
     */
/* static IErrorNode exportVarAsNodes(
        Json varToConvert, int maxOutputDepth = 3) {
        return export_(varToConvert, new DDebugContext(
                maxOutputDepth));
    } */

/**
     * Converts a variable to a string for debug output.
     *
     * *Note:* The following keys will have their contents
     * replaced with `*****`:
     *
     * - password
     * - login
     * - host
     * - database
     * - port
     * - prefix
     * - schema
     *
     * This is done to protect database credentials, which could be accidentally
     * shown in an error message if UIM is deployed in development mode.
     */
/* static string exportVar(Json value, int maxOutputDepth = 3) {
        auto dumpContext = new DDebugContext(
            maxOutputDepth);
        return debugger.exportFormatter()
            .dump(
                export_(value, dumpContext));
    } */

// Protected export function used to keep track of indentation and recursion.
/*     protected static IErrorNode export_(Json varToDump, DDebugContext dumpContext) {
        auto type = varToDump.getString("type");
        switch (type) {
        case "float":
        case "string":
        case "resource":
        case "resource (closed)":
        case "null":
            return new DScalarErrorNode(type, varToDump);
        case "boolean":
            return new DScalarErrorNode("bool", varToDump);
        case "integer":
            return new DScalarErrorNode("int", varToDump);
        case "array":
            return exportArray(varToDump, dumpContext
                    .withAddedDepth());
        case "unknown":
            return new DSpecialErrorNode(
                "(unknown)");
        default:
            return exportObject(varToDump, dumpContext
                    .withAddedDepth());
        }
    }
 */
/**
     * Export an array type object. Filters out keys used in datasource configuration.
     *
     * The following keys are replaced with ***"s
     *
     * - password
     * - login
     * - host
     * - database
     * - port
     * - prefix
     * - schema
     */
// protected static DArrayErrorNode exportArray(Json[string] valueToExport, DDebugContext dumpContext) {
/*
    auto items = null;

    autp remaining = dumpContext
        .remainingDepth();
    if (remaining >= 0) {
        outputMask = outputMask();
        foreach (valueToExport as key : val) {
            if (hasKey(key, outputMask)) {
                node = new DScalarErrorNode(
                    "string", outputMask[key]);
            } else if (
                val != valueToExport) {
                // Dump all the items without increasing depth.
                node = export_(val, dumpContext);
            } else {
                // Likely recursion, so we increase depth.
                node = export_(val, dumpContext
                        .withAddedDepth());
            }
            items ~= new DArrayItemErrorNode(
                export_(key, dumpContext), node);
        }
    } else {
        items ~= new DArrayItemErrorNode(
            new DScalarErrorNode(
                "string", ""),
            new DSpecialErrorNode(
                "[maximum depth reached]")
        );
    } 

    return new DArrayErrorNode(
        items); * /
        return null;
    } */

// Handles object to node conversion.
/* protected static IErrorNode exportObject(Object objToConvert, DDebugContext dumpContext) {
    /* auto isRef = dumpContext.hasReference(
        objToConvert);
    auto refNum = dumpContext
        .getReferenceId(
            objToConvert);

    auto classnameName = get_class(
        objToConvert); */
/*     if (isRef) {
        return new DReferenceErrorNode(null, refNum);
    }
 */
/* auto node = new DClassErrorNode(null, refNum);
    auto remaining = dumpContext
        .remainingDepth();
    if (remaining > 0) {
        if (hasMethod(objToConvert, "debugInfo")) {
            try {
                foreach (key, val;  /* (array) * / objToConvert
                    .debugInfo(string[] showKeys = null, string[] hideKeys = null)) {
                    node.addProperty(
                        new DPropertyErrorNode(
                            "" {
                            key
                        }
                    "", null, export_(val, dumpContext)));
                }

                return node;
            } catch (
                Error e) {
                return new DSpecialErrorNode("(unable to export object: {e.message()})");
            }
        }

        auto outputMask = outputMask();
        auto objectVars = get_object_vars(
            objToConvert);
        foreach (key, value; objectVars) {
            if (hasKey(key, outputMask)) {
                value = outputMask[key];
            }
            /** @psalm-suppress RedundantCast * /
            node.addProperty(
                new DPropertyErrorNode(key, "public", export_(
                    value, dumpContext
                    .withAddedDepth()))
            );
        }

        auto reflectionObject = new DReflectionObject(
            objToConvert);

        auto filters = [
            ReflectionProperty
            .IS_PROTECTED: "protected",
            ReflectionProperty
            .IS_PRIVATE: "private",
        ];
        foreach (filter, visibility; filters) {
            reflectionProperties = reflectionObject
                .getProperties(
                    filter);
            foreach (
                reflectionProperty; reflectionProperties) {
                reflectionProperty
                    .setAccessible(
                        true);

                auuto value = hasMethod(
                    reflectionProperty, "isInitialized") && !reflectionProperty
                    .isInitialized(
                        objToConvert)
                    ? new DSpecialErrorNode("[uninitialized]") : export_(
                        reflectionProperty
                            .value(objToConvert), dumpContext
                            .withAddedDepth());

                node.addProperty(
                    new DPropertyErrorNode(
                        reflectionProperty
                        .getName(),
                        visibility,
                        value
                )
                );
            }
        }
    }

    return node; * /
    return null;
  } */
  // #endregion export

  /**
     * Creates an entry in the log file. The log entry will contain a stack trace from where it was called.
     * as well as export the variable using exportVar. By default, the log is written to the debug log.
     */
  void log(Json varToLog, string levelType = "debug", int maxDepth = 3) {
    /* string source = trace(["start": 1]);
    source ~= "\n";

    Log.write(
      levelType,
      "\n" ~ source ~ exportVarAsPlainText(varToLog, maxDepth)
    ); */
  }

  // Get the frames from error that are not present in parent
   Json[string] getUniqueFrames(Throwable error, Throwable parent) {
    /* if (parent.isNull) {
      return error.getTrace();
    } */
    /* parentFrames = parent.getTrace();
    frames = error.getTrace();

    parentCount = count(parentFrames) - 1;
    frameCount = count(frames) - 1; */

    // Reverse loop through both traces removing frames that
    // are the same.
    /*     for (index = frameCount, p = parentCount; index >= 0 && p >= 0; p--) {
      parentTail = parentFrames[p];
      tail = frames[index];

      // Frames without file/line are never equal to another frame.
      isEqual = (
        (
          tail.hasAllKeys(["file", "line"]) &&
          parentTail.hasAllKeys(["file", "line"])
      ) &&
        (tail["file"] == parentTail["file"]) &&
        (tail["line"] == parentTail["line"])
      );
      if (isEqual) {
        removeKey(frames[index]);
        index--;
      }
    }
    return frames; */
    return null;
  }



  // Shortens file paths by replacing the application base path with 'APP", and the UIM core path with 'CORE'.
  static string trimPath(string pathToShorten) {
    /* if (defined("APP") && pathToShorten.startsWith(APP)) {
      return pathToShorten.replace(APP, "APP/");
    }
    if (defined("uim_CORE_INCLUDE_PATH") && pathToShorten.startsWith(uim_CORE_INCLUDE_PATH)) {
      return pathToShorten.replace(uim_CORE_INCLUDE_PATH, "CORE");
    }
    return defined("ROOT") && pathToShorten.startsWith(ROOT)
      ? pathToShorten.replace(ROOT, "ROOT") : pathToShorten; */
    return null;
  }

  /**
     * Grabs an excerpt from a file and highlights a given line of code.
     *
     * Usage:
     *
     * ```
     * Debugger.excerpt("/path/to/file", 100, 4);
     * ```
     *
     * The above would return an array of 8 items. The 4th item would be the provided line,
     * and would be wrapped in `<span class="code-highlight"></span>`. All the lines
     * are processed with highlight_string() as well, so they have basic UIM syntax highlighting
     * applied.
     */
  static string[] excerpt(string filePath, int lineToHighlight, int numberOfLinesToExtract = 2) {
    string[] lines = null;
    /* if (!filehasKey(filePath)) {
      return null;
    } */

    /* string[] contents = file_get_contents(filePath);
    if (contents.isEmpty) {
      return lines;
    }
    if (contents.contains("\n")) {
      contents = someData.split("\n");
    }
    lineToHighlight--;
    if (contents.isNull(lineToHighlight)) {
      return lines;
    } */

    /* for (index = lineToHighlight - numberOfLinesToExtract; index < lineToHighlight + numberOfLinesToExtract + 1;
      index++) {
      if (contents[index]!is null) {
        continue;
      }
      string lineToHighlight = _highlight(someData[index]).replace([
        "\r\n", "\n"
      ], "");
      lines ~= index == lineToHighlight
        ? htmlDoubleTag("span", ["code-highlight"], "string") : lineToHighlight;
    } */
    return lines;
  }

  /**
     * Wraps the highlight_string auto in case the server API does not
     * implement the auto as it is the case of the HipHop interpreter
     */
  protected string _highlight(string stringToConvert) {
    /* if (function_hasKey("hD_log") || function_hasKey("hD_gettid")) {
      return htmlentities(stringToConvert);
    }

    bool added = false;
    if (!stringToConvert.contains("")) {
      added = true;
      stringToConvert = " \n" ~ stringToConvert;
    }

    string highlight = highlight_string(stringToConvert, true);
    if (added) {
      highlight = highlight.replace(
        ["&lt;?D&nbsp;<br/>", "&lt;?D&nbsp;<br />"],
        "");
    } */
    string highlight = stringToConvert; // Placeholder for actual highlighting logic.
    return highlight;
  }



  /**
     * Converts a variable to a string for debug output.
     *
     * *Note:* The following keys will have their contents
     * replaced with `*****`:
     *
     * - password
     * - login
     * - host
     * - database
     * - port
     * - prefix
     * - schema
     *
     * This is done to protect database credentials, which could be accidentally
     * shown in an error message if UIM is deployed in development mode.
     */
  static string exportVar(Json value, int maxDepth = 3) {
    /* auto context = new DDebugContext(maxDepth);
    auto node = export_(value, context);

    return debugger.exportFormatter().dump(node); */
    return null;
  }

  // Converts a variable to a plain text string.
  static string exportVarAsPlainText(Json value, int maxOutputDepth = 3) {
    /*     return (new DTextFormatter()).dump(
      export_(value, new DDebugContext(maxOutputDepth))
    ); */
    return null;
  }

  /**
     * Convert the variable to the internal node tree.
     *
     * The node tree can be manipulated and serialized more easily
     * than many object graphs can.
     */
  static IErrorNode exportVarAsNodes(Json value, int maxOutputDepth = 3) {
    // return export_(value, new DDebugContext(maxOutputDepth));
    return null;
  }

  /**
     * Protected export auto used to keep track of indentation and recursion.
     * Params:
     * Json var The variable to dump.
     */
  /* protected static IErrorNode export_(Json valueToDump, DDebugContext context) {
    string type = getType(valueToDump);

    if (type.startsWith("resource ")) {
      return new DScalarErrorNode(type, valueToDump);
    }
    return null; // TODO 
    /* return match(type) {
            "float", "string", "null" : new DScalarErrorNode(type, valueToDump),
            "bool" : new DScalarErrorNode("bool", valueToDump),
            "int" : new DScalarErrorNode("int", valueToDump),
            "array" : exportArray(valueToDump, context.withAddedDepth()),
            "unknown" : new DSpecialErrorNode("(unknown)"),
            default : exportObject(valueToDump, context.withAddedDepth()),
        }; * /
  } */

  /**
     * Export an array type object. Filters out keys used in datasource configuration.
     *
     * The following keys are replaced with ***
     *
     * - password
     * - login
     * - host
     * - database
     * - port
     * - prefix
     * - schema
     */
  /* protected static DArrayErrorNode exportArray(Json[string] exportValues, DDebugContext dumpContext) {
    auto someItems = null;

    auto remaining = dumpContext.remainingDepth();
    if (remaining >= 0) {
      outputMask = outputMask();
      exportValues.byKeyValue((item) {
        if (hasKey(item.key, outputMask)) {
          node = new DScalarErrorNode("string", outputMask[item.key]);
        } else if (item.value != exportValues) {
          // Dump all the items without increasing depth.
          node = export_(item.value, dumpContext);
        } else {
          // Likely recursion, so we increase depth.
          node = export_(item.value, dumpContext.withAddedDepth());
        }
        someItems ~= new ArrayItemNode(export_(item.key, dumpContext), node);
      });
    } else {
      someItems ~= new ArrayItemNode(
        new DScalarErrorNode("string", ""),
        new DSpecialErrorNode("[maximum depth reached]")
      );
    }
    return new DArrayErrorNode(someItems);
  } */

  // Handles object to node conversion.
  /* protected static IErrorNode exportObject(UIMObject objToConvert, DDebugContext dumpContext) {
    /* auto isRef = dumpContext.hasReference(objToConvert);
        auto refNum = dumpContext.getReferenceId(objToConvert);

        auto objClassname = var.classname;
        if (isRef) {
            return new DReferenceErrorNode(classname, refNum);
        }

        auto node = new DClassErrorNode(classname, refNum);
        auto remaining = dumpContext.remainingDepth();
        if (remaining > 0) {
            if (hasMethod(objToConvert, "debugInfo")) {
                 try {
                    foreach (key, val; /* (array) * / objToConvert.debugInfo(string[] showKeys = null, string[] hideKeys = null)) {
                        node.addProperty(new DPropertyErrorNode("'{key}'", null, export_(val, dumpContext)));
                    }
                    return node;
                } catch (Error anError) {
                    return new DSpecialErrorNode(
                        "(unable to export object: { anError.message()})");
                }
             }
            auto outputMask = outputMask();
            auto objectVars = get_object_vars(objToConvert);
            objectVars.byKeyValue
                .each!((kv) {
                    if (outputMask.hasKey(kv.key)) {
                        kv.value = outputMask[kv.key];
                    }
                    node.addProperty(
                        new DPropertyErrorNode((string) kv.key, "public", export_(kv.value, dumpContext.withAddedDepth()))
                   );
                });
            ref = new DReflectionObject(objToConvert);

            filters = [
                ReflectionProperty.IS_PROTECTED: "protected",
                ReflectionProperty.IS_PRIVATE: "private",
            ];
            foreach (filter, visibility; filters) {
                reflectionProperties = ref.getProperties(filter);
                foreach (reflectionProperty; reflectionProperties) {
                    reflectionProperty.setAccessible(true);

                    if (
                        hasMethod(reflectionProperty, "isInitialized") &&
                        !reflectionProperty.isInitialized(objToConvert)
                       ) {
                        aValue = new DSpecialErrorNode("[uninitialized]");
                    } else {
                        aValue = export_(reflectionProperty.value(objToConvert), dumpContext.withAddedDepth());
                    }
                    node.addProperty(
                        new DPropertyErrorNode(
                            reflectionProperty.name,
                            visibility,
                            aValue
                   )
                   );
                }
            }
        }
        return node; * /
    return null;
  } */

  // Get the type of the given variable. Will return the class name for objects.
  static string getType(Json variableToCheck) {
    /*     string variableType = get_debug_type(variableToCheck);

    switch (variableType) {
    case "double":
      return "float";
    case "unknown type":
      return "unknown";
    default:
      return variableType;
    } */
    return null;
  }

  // Prints out debug information about given variable.
// Prints out debug information about given variable.
void printVar(Json varToShow, Json[string] location = null, bool showHtml = false) {
  location = location.merge([
      "file": Json(""),
      "line": Json(0)
    ]);

  location.set("file", trimPath(location.getString("file")));

  /*   auto debugger = debugger;
    auto restore = null;
    if (showHtml != null) {
      restore = debugger.getConfig(
        "exportFormatter");
      debugger.configuration.setEntry(
        "exportFormatter", showHtml ? HtmlFormatter.classname : TextFormatter
          .classname);
    }
    auto contents = exportVar(varToShow, 25);
    auto formatter = debugger
      .exportFormatter();

    if (restore) {
      debugger.setConfig(
        "exportFormatter", restore);
    }
    writeln(formatter.formatWrapper(contents, location)); */
}

  /**
     * Format an error message to be HTML formatted.
     *
     * Does the following formatting operations:
     * - HTML escape the message.
     * - Convert `bool` into `<code>bool</code>`
     * - Convert newlines into `<br>`
     */
  static string formatHtmlMessage(string message) {
    message = escapeHtmlAttribute(message);
    // message = (string) preg_replace("/`([^`]+)`/", "<code>0</code>", message);

    return message.replace("\n", "<br>"); 
  }

  // Verifies that the application`s salt and cipher seed value has been changed from the default value.
  static void checkSecurityKeys() {
    /*     auto salt = Security.getSalt();
    if (salt == "__SALT__" || salt.length < 32) {
      trigger_error(
        "Please change the value of `Security.salt` in `ROOT/config/app_local.d` " ~
          "to a random value of at least 32 characters.",
          ERRORS.USER_NOTICE
      );
    } */
  }

  // Holds current output data when outputFormat is false.
  /* this() {
        auto docRef = ini_get("docref_root");
        if (docRef.isEmpty && function_hasKey("ini_set")) {
            ini_set("docref_root", "https://secure.D.net/");
        }
        if (!defined("ERRORS.RECOVERABLE_ERROR")) {
            define("ERRORS.RECOVERABLE_ERROR", 4096);
        }

        aConfig = intersectinternalKey( /* (array) * / Configure.read("Debugger"), _defaultConfig);
        configuration.setEntry(aConfig);
        e = `<pre class="uim-error">`;
        e ~= `<a href="javascript:void(0);" onclick="document.getElementById(\"{:id}-trace\")`;
        e ~= `.style.display = (document.getElementById(\"{:id}-trace\").style.display == `;
        e ~= `\"none\" ? \"\" : \"none\");"><b>{:error}</b> ({:code})</a>: {:description} `;
        e ~= `[<b>{:path}</b>, line <b>{:line}</b>]`;
        e ~= htmlDoubleTag("div", "{:id}-trace", [
                "uim-stack-trace"
            ], ["style": "display: none;"], "{:links}{:info}");
        e ~= `</pre>`;
        _stringContents.set("js.error", e);
        t = `<div id="{:id}-trace" class="uim-stack-trace" style="display: none;">`;
        t ~= `{:dumpContext}{:code}{:trace}</div>`;
        _stringContents.set("js.info", t);

        Json[string] links;
        string link = "<a href=\"javascript:void(0);\" onclick=\"document.getElementById(\"{:id}-code\")";
        link ~= ".style.display = (document.getElementById(\"{:id}-code\").style.display == ";
        link ~= "\"none\" ? \"\" : \"none\")\">Code</a>";
        links.set("code", link);

        link = "<a href=\"javascript:void(0);\" onclick=\"document.getElementById(\"{:id}-dumpContext\")";
        link ~= ".style.display = (document.getElementById(\"{:id}-dumpContext\").style.display == ";
        link ~= "\"none\" ? \"\" : \"none\")\">Context</a>";
        links.set("dumpContext", link);

        _stringContents.set("js.links", links);
        _stringContents.set("js.dumpContext", htmlDoubleTag("pre", "{:id}-dumpContext", [
                    "uim-dumpContext", "uim-debug"
                ], ["style": "display: none;"], "{:dumpContext}"));
        _stringContents.set("js.code", htmlDoubleTag("pre", "{:id}-code", [
                    "uim-code-dump"
                ], ["style": "display: none;"], "{:code}"));
        _stringContents.set("html.error", htmlDoubleTag("pre", [
                    "uim-error"
                ],
                htmlDoubleTag("b", "{:error}") ~ "({:code}) : {:description} [<b>{:path}</b>, line <b>{:line}]</b>"));

        _stringContents.set("html.dumpContext", htmlDoubleTag("pre", [
                    "uim-dumpContext uim-debug"
                ],
                htmlDoubleTag("b", "Context") ~
                htmlDoubleTag("p", "{:dumpContext}")));
    } */




  // Recursively formats and outputs the contents of the supplied variable.
  /*     static void dump(Json dumpValue, int maxOutputDepth = 3) {
        pr(exportVar(dumpValue, maxOutputDepth));
    } */

  /**
     * Creates an entry in the log file. The log entry will contain a stack trace from where it was called.
     * as well as export the variable using exportVar. By default, the log is written to the debug log.
     * /
  static void log(Json varToLog, string logLevel = "debug", size_t maxOutputDepth = 3) {
    // string source = trace(["start": 1]) ~ "\n";

    /* Log.write(
      logLevel,
      "\n" ~ source ~ exportVarAsPlainText(varToLog, maxOutputDepth)
    ); * /
  }

  /**
     * Outputs a stack trace based on the supplied options.
     *
     * ### Options
     *
     * - `depth` - The number of stack frames to return. Defaults to 999
     * - `format` - The format you want the return. Defaults to the currently selected format. If
     *   format is "array" or "points" the return will be an array.
     * - `args` - Should arguments for functions be shown? If true, the arguments for each method call will be displayed.
     * - `start` - The stack frame to start generating a trace from. Defaults to 0
     */
/**
     * Shortens file paths by replacing the application base path with "APP", and the UIM core
     * path with "CORE".
     */
/* static string trimPath(
        string pathToShorten) {
        if (defined("APP") && indexOf(path, APP) == 0) {
            return replace(APP, "APP/", path);
        }
        if (defined("UIM_CORE_INCLUDE_PATH") && indexOf(path, UIM_CORE_INCLUDE_PATH) == 0) {
            return replace(uim_CORE_INCLUDE_PATH, "CORE", path);
        }
        if (defined("ROOT") && indexOf(path, ROOT) == 0) {
            return replace(ROOT, "ROOT", path);
        }

        return path;
    } */

/**
     * Grabs an excerpt from a file and highlights a given line of code.
     *
     * Usage:
     *
     * ```
     * Debugger.excerpt("/path/to/file", 100, 4);
     * ```
     *
     * The above would return an array of 8 items. The 4th item would be the provided line,
     * and would be wrapped in `<span class="code-highlight"></span>`. All the lines
     * are processed with highlight_string() as well, so they have basic UIM syntax highlighting
     * applied.
     */
/* static string[] excerpt(string absPathToFile, int lineNumber, int numberLinesContext = 2) {
        auto lines = null;
        if (
            !filehasKey(
                absPathToFile)) {
            return [
            ];
        }
        auto data = file_get_contents(
            absPathToFile);
        if (data.isEmpty) {
            return lines;
        }

        if (indexOf(data, "\n") == true) {
            data = explode("\n", data);
        }

        lineNumber--;
        if (
            data.isNull(
                lineNumber)) {
            return lines;
        }
        for (
            i = lineNumber - numberLinesContext; i < lineNumber + numberLinesContext + 1;
            i++) {
            if (data.isNull(i)) {
                continue;
            }
            string text = replace([
                    "\r\n",
                    "\n"
                ], "", _highlight(
                    data[i]));
            lines ~= i == lineNumber
                ? htmlDoubletag("span", [
                        "code-highlight"
                    ], text) : text;
        }

        return lines;
    }

*/
}


 /* string getStackTrace() {
	import core.runtime;

	version(Posix) {
		// druntime cuts out the first few functions on the trace as they are internal
		// so we'll make some dummy functions here so our actual info doesn't get cut
		Throwable.TraceInfo f5() { return defaultTraceHandler(); }
		Throwable.TraceInfo f4() { return f5(); }
		Throwable.TraceInfo f3() { return f4(); }
		Throwable.TraceInfo f2() { return f3(); }
		auto stuff = f2();
	} else {
		auto stuff = defaultTraceHandler();
	}

	return stuff.toString();
}
 */
 /*
unittest {
  /* 
  import core.runtime;

  try {
    throw new Exception("Test exception");
    // throw new Exception("Test exception", "Test error", 500, "test.d", 42);
  }
  catch (Exception e) {
    writeln (e.file);
    writeln (e.message);

    string info;
    () @trusted { info = core.runtime.defaultTraceHandler().toString; }();
    writeln(info.split("\n"));

    () @trusted { info = e.info.toString; }();
    writeln(info);

/*     auto Throwable.TraceInfo traceInfo = e.info;
	  writeln(stuff.getStackTrace);
 * /  }
} */