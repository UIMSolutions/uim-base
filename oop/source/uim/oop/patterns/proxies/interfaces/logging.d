module uim.oop.patterns.proxies.interfaces.logging;

/**
 * Interface for logging proxy.
 */
interface ILoggingProxy : IProxy {
  /**
   * Get the access log.
   */
  string[] getLog() @safe;

  /**
   * Clear the log.
   */
  void clearLog() @safe;
}