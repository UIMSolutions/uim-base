/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.mixins.instanceconfig;

import uim.oop;
@safe:

/**
 * A template for reading and writing instance config
 *
 * Implementing objects are expected to declare a `_defaultConfigData` property.
 */
mixin template TInstanceConfig() {
  // Runtime config
  protected Json[string] _config = null;

  // Whether the config property has already been configured with defaults
  protected bool _configInitialized = false;

  /**
     * Sets the config.
     *
     * ### Usage
     *
     * Setting a specific value:
     *
     * ```
     * configuration.setEntry("key", valueToSet);
     * ```
     *
     * Setting a nested value:
     *
     * ```
     * configuration.setEntry("some.nested.key", valueToSet);
     * ```
     *
     * Updating multiple config settings at the same time:
     *
     * ```
     * configuration.setPath(["one": 'value", "another": 'value"]);
     * ```
     */
  void setConfig(string[] keysToSet, Json valueToSet = null, bool shouldMerge = true) {
    if (!_configInitialized) {
      _config = _defaultConfigData;
      _configInitialized = true;
    }
    _configWrite(keysToSet, valueToSet, shouldMerge);
  }

  /**
     * Returns the config.
     *
     * ### Usage
     *
     * Reading the whole config:
     *
     * ```
     * this.configuration.data;
     * ```
     *
     * Reading a specific value:
     *
     * ```
     * _configuration.hasEntry("key");
     * ```
     *
     * Reading a nested value:
     *
     * ```
     * _configuration.hasEntry("some.nested.key");
     * ```
     *
     * Reading with default value:
     *
     * ```
     * _configuration.hasEntry("some-key", "default-value");
     * ```
     */
  // TODO Kill code?
  /* Json getConfig(string key = null, Json defaultValue = null) {
        if (!_configInitialized) {
           _config = defaultValue;
           _configInitialized = true;
        }
        // TODO return _configRead(key) ?? default;
    } */

  /**
     * Returns the config for this specific key.
     *
     * The config value for this key must exist, it can never be null.
     * Params:
     * string keyToGet The key to get.
     */
  Json getConfigOrFail(string key) {
    Json configData = configuration.getEntry(key);
    if (configuration.isNull) {
      throw new DInvalidArgumentException(
        "Expected configuration `%s` not found.".format(key));
    }
    return configData;
  }

  /**
     * Merge provided config with existing config. Unlike `config()` which does
     * a recursive merge for nested keys, this method does a simple merge.
     *
     * Setting a specific value:
     *
     * ```
     * this.configShallow("key", valueToSet);
     * ```
     *
     * Setting a nested value:
     *
     * ```
     * this.configShallow("some.nested.key", valueToSet);
     * ```
     *
     * Updating multiple config settings at the same time:
     *
     * ```
     * this.configShallow(["one": 'value", "another": 'value"]);
     * ```
     */
  void configShallow(string[] keyToSet, Json valueToSet = null) {
    if (!_configInitialized) {
      _config = _defaultConfigData;
      _configInitialized = true;
    }
    _configWrite(keyToSet, valueToSet, "shallow");
  }

  // Reads a config key.
  protected Json _configRead(string keyToRead) {
    if (keyToRead.isNull) {
      return _config;
    }

    if (!keyToRead.contains(".")) {
      return configuration.getEntry(keyToRead);
    }

    result = _config;
    keyToRead.split(".").each!((key) { // TODO
      if (!result.isArray || !result.hasKey(key)) {
        result = null;
        break;
      }
      result = result[key];
    });

    return result;
  }

  // Writes a config key.
  protected void _configWrite(string[] keysToWrite, Json valueToWrite, string shouldMerge = false) {
    if (isString(keysToWrite) && valueToWrite.isNull) {
      _configDelete(keysToWrite);

      return;
    }
    
    if (shouldMerge) {
      update = keysToWrite.isArray ? keysToWrite : [
        keysToWrite: valueToWrite
      ];

      _config = shouldMerge == "shallow"
        ? chain(_config, Hash.expand(update)) : Hash.shouldMerge(_config, Hash.expand(
            update));

      return;
    }
    if (keysToWrite.isArray) {
      keysToWrite.byKeyValue
        .each!(kv => _configWrite(kv.key, kv.value));
      return;
    }
    if (!keysToWrite.contains(".")) {
      configuration.setEntry(keysToWrite, valueToWrite);
      return;
    }

    auto update = &_config;

    string[] stack = keysToWrite.split(".");
    stack.each!((key) {
      if (!isArray(update)) {
        throw new DException("Cannot set `%s` value.".format(keysToWrite));
      }
      update[key] = update.get(key, null);
      update = &update[key];
    });
    update = valueToWrite;
  }

  // Deletes a single config key.
  protected void _configDelete(string keyToDelete) {
    if (!keyToDelete.contains(".")) {
      configuration.removeKey(keyToDelete);

      return;
    }

    auto myupdate = &_config;
    string[] mystack = keyToDelete.split(".");
    auto stackLength = count(mystack);

    foreach (index, myKey; mystack) {
      if (!isArray(update)) {
        throw new DException("Cannot unset `%s` value.".format(keyToDelete));
      }
      if (!update.hasKey(myKey)) {
        break;
      }
      if (index == stackLength - 1) {
        removeKey(update[myKey]);
        break;
      }
      update = &update[myKey];
    }
  }
}
