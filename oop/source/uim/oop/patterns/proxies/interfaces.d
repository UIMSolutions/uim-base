/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.patterns.proxies.interfaces;

/**
 * Base interface for subjects that can be proxied.
 */
interface ISubject {
  /**
   * Execute the subject's main operation.
   */
  string execute() @safe;
}

/**
 * Interface for proxy objects.
 * Provides the same interface as the real subject.
 */
interface IProxy : ISubject {
  /**
   * Get the real subject.
   */
  ISubject getRealSubject() @safe;
}

/**
 * Interface for virtual proxy (lazy initialization).
 */
interface IVirtualProxy : IProxy {
  /**
   * Check if real subject has been created.
   */
  bool isInitialized() @safe;
}

/**
 * Interface for protection proxy (access control).
 */
interface IProtectionProxy : IProxy {
  /**
   * Check if access is allowed.
   */
  bool isAccessAllowed() @safe;

  /**
   * Set access permission.
   */
  void setAccessAllowed(bool allowed) @safe;
}

/**
 * Interface for caching proxy.
 */
interface ICachingProxy : IProxy {
  /**
   * Clear the cache.
   */
  void clearCache() @safe;

  /**
   * Check if result is cached.
   */
  bool isCached() @safe;
}

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

/**
 * Interface for remote proxy.
 */
interface IRemoteProxy : IProxy {
  /**
   * Get the remote endpoint.
   */
  string getEndpoint() @safe;

  /**
   * Check connection status.
   */
  bool isConnected() @safe;
}
