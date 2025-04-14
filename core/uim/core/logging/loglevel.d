module uim.core.logging.loglevel;

import uim.core;

@safe:

class LogLevel {
  this() {
    _logLevels = [
      "log", "trace", "info", "warning", "error", "critical", "fatal",
      "unknown"
    ];
    _defaultLogLevel = "info";
  }

  // #region defaultLogLevel
  // Get/Set the default log level.
  protected string _defaultLogLevel;
  void defaultLogLevel(string level) {
    _defaultLogLevel = (level in _logLevels) ? level : "unknown";
  }

  string defaultLogLevel() {
    return _defaultLogLevel;
  }
  // #endregion defaultLogLevel

  // #region logLevels
  string[] _logLevels;
  void logLevels(string[] levels) {
    _logLevels = levels.dup;
  }

  string[] logLevels() {
    return _logLevels;
  }
  // #endregion logLevels
}