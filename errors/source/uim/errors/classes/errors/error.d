module uim.errors.classes.errors.error;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:


// This class is used to represent errors in UIM applications.
class DError : UIMObject, IError {
  mixin(ErrorThis!());

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    return true;
  }

  // #region loglabel
  protected string _loglabel;
  string loglabel() {
    return _loglabel;
  }
  // Set the error code.
  IError loglabel(string newLabel) {
    _loglabel = newLabel;
    return this;
  }
  // #endregion loglabel

  // #region loglevel
  string loglevel() {
    return uim.core.logging.LogLevels.level(loglabel());
  }
  // #endregion loglevel

  // #region line
  string line() {
    return to!string(_lineNumber);
  }
  // #endregion line

  // #region message
  protected string _message;
  // Get the error message.
  string message() {
    return _message;
  }

  // Set the error message.
  IError message(string newMessage) {
    _message = newMessage;
    return this;
  }
  // #endregion message

  // #region filemname
  protected string _fileName;
  // Get the filename.
  string fileName() {
    return _fileName;
  }

  // Set the filename.
  IError fileName(string name) {
    _fileName = name;
    return this;
  }
  // #endregion filename

  // #region lineNumber
  protected size_t _lineNumber;
  size_t lineNumber() {
    return _lineNumber;
  }

  IError lineNumber(size_t newLineNumber) {
    _lineNumber = newLineNumber;
    return this;
  }
  // #endregion lineNumber

  // #region trace
  // Get the stacktrace.
  protected STRINGAA[] _trace;
  STRINGAA[] trace() {
    return _trace;
  }

  IError trace(STRINGAA[] newTrace) {
    _trace = newTrace;
    return this;
  }
  // Add a trace entry.
  IError addTrace(STRINGAA[] newTrace) {
    _trace ~= newTrace;
    return this;
  }
  // Add a trace entry.
  IError addTrace(string reference, string file, string line) {
    STRINGAA newTrace;
    newTrace["reference"] = reference;
    newTrace["file"] = file;
    newTrace["line"] = line;
    addTrace(newTrace);

    return this;
  }
  // Add a trace entry.
  IError addTrace(STRINGAA newTrace) {
    _trace ~= newTrace;
    return this;
  }

  // Get the stacktrace as a string.
  string traceAsString() {
    return trace
      .map!(entry => "{%s} {%s, %s}".format(
          entry["reference"],
          entry["file"],
          entry["line"]))
      .join("\n");
  }
  // #endregion trace

  // #region throwError
  void throwError() {
    throw new Error(message);
  }
  // #endregion throwError
}

/* 
unittest {
  auto error = new DError();
  assert(error !is null);

  assert(error.initialize());
  /* assert(error.loglevel() == "error");
  assert(error.message == null);
  assert(error.fileName == null);
  assert(error.lineNumber == 0);
  assert(error.trace() == null);
  assert(error.traceAsString() == null); */

  /* error.message = "This is a test message";
  assert(error.message == "This is a test message");
  assert(error.loglevel() == "error");
  assert(error.fileName == null);
  assert(error.lineNumber == 0);
  assert(error.trace() == null);
  assert(error.traceAsString() == null);

  error.fileName = "test.d";
  assert(error.message == "This is a test message");
  assert(error.loglevel() == "error");
  assert(error.fileName == "test.d");
  assert(error.lineNumber == 0);
  assert(error.trace() == null);
  assert(error.traceAsString() == null);

  error.lineNumber = 42;
  assert(error.message == "This is a test message");
  assert(error.loglevel() == "error");
  assert(error.fileName == "test.d");
  assert(error.lineNumber == 42);
  assert(error.trace() == null);
  assert(error.traceAsString() == null); * /
}
*/
/* Old code
 this(
    ERRORS errorCode,
    string errorMessage,
    string filenameOfError = "",
    size_t lineOfError = 0,
    size_t[string][] traceDataForError = null
  ) {
    code(errorCode);
    message(errorMessage);
    fileName(filenameOfError);
    lineNumber(lineOfError);
    trace(traceDataForError);
  }
*/