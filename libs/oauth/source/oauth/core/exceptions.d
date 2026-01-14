/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module oauth.core.exceptions;

@safe:

/**
 * Base OAuth exception
 */
class OAuthException : Exception {
  this(string msg, string file = __FILE__, size_t line = __LINE__) {
    super(msg, file, line);
  }
}

/**
 * Authorization exception
 */
class AuthorizationException : OAuthException {
  string errorCode;
  string errorDescription;

  this(string errorCode, string errorDescription, string file = __FILE__, size_t line = __LINE__) {
    super(errorCode ~ ": " ~ errorDescription, file, line);
    this.errorCode = errorCode;
    this.errorDescription = errorDescription;
  }
}

/**
 * Token exception
 */
class TokenException : OAuthException {
  this(string msg, string file = __FILE__, size_t line = __LINE__) {
    super(msg, file, line);
  }
}

/**
 * Invalid state exception (CSRF protection)
 */
class InvalidStateException : OAuthException {
  this(string msg = "Invalid state parameter", string file = __FILE__, size_t line = __LINE__) {
    super(msg, file, line);
  }
}