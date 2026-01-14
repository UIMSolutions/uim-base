/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module oauth.tokens.token_storage;

import oauth.tokens.access_token;

@safe:

/**
 * Token storage interface
 */
interface ITokenStorage {
  void store(string identifier, AccessToken token);
  AccessToken retrieve(string identifier);
  void remove(string identifier);
  bool exists(string identifier);
}

/**
 * In-memory token storage
 */
class InMemoryTokenStorage : ITokenStorage {
  private AccessToken[string] _tokens;

  void store(string identifier, AccessToken token) {
    _tokens[identifier] = token;
  }

  AccessToken retrieve(string identifier) {
    return _tokens.get(identifier, null);
  }

  void remove(string identifier) {
    _tokens.remove(identifier);
  }

  bool exists(string identifier) {
    return (identifier in _tokens) !is null;
  }
}

/**
 * File-based token storage
 */
class FileTokenStorage : ITokenStorage {
  private string _directory;

  this(string directory = "./tokens") {
    _directory = directory;
    ensureDirectory();
  }

  void store(string identifier, AccessToken token) @trusted {
    import std.file : write;
    import std.path : buildPath;
    
    auto filepath = buildPath(_directory, identifier ~ ".json");
    auto json = token.toJson();
    write(filepath, json.toString());
  }

  AccessToken retrieve(string identifier) @trusted {
    import std.file : readText, exists;
    import std.path : buildPath;
    import vibe.data.json : parseJsonString;
    
    auto filepath = buildPath(_directory, identifier ~ ".json");
    if (!exists(filepath)) return null;
    
    auto content = readText(filepath);
    auto json = parseJsonString(content);
    return AccessToken.fromJson(json);
  }

  void remove(string identifier) @trusted {
    import std.file : remove, exists;
    import std.path : buildPath;
    
    auto filepath = buildPath(_directory, identifier ~ ".json");
    if (exists(filepath)) {
      remove(filepath);
    }
  }

  bool exists(string identifier) @trusted {
    import std.file : exists;
    import std.path : buildPath;
    
    auto filepath = buildPath(_directory, identifier ~ ".json");
    return exists(filepath);
  }

  private void ensureDirectory() @trusted {
    import std.file : exists, mkdirRecurse;
    
    if (!exists(_directory)) {
      mkdirRecurse(_directory);
    }
  }
}