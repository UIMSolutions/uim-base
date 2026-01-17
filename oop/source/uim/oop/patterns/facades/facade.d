/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.patterns.facades.facade;

import uim.oop;

mixin(ShowModule!());

@safe:

/**
 * Abstract base facade class.
 */
abstract class Facade : IFacade {
  protected bool _initialized;

  /**
   * Check if the facade is ready for operations.
   * Returns: true if ready
   */
  bool isReady() {
    return _initialized;
  }

  /**
   * Initialize the facade and its subsystems.
   * Returns: true if initialization successful
   */
  abstract bool initialize();

  /**
   * Shutdown the facade and cleanup resources.
   */
  abstract void shutdown();
}

/**
 * Generic subsystem component base class.
 */
abstract class SubsystemComponent : ISubsystemComponent {
  protected string _name;
  protected bool _initialized;

  /**
   * Create a subsystem component.
   * Params:
   *   name = Component name
   */
  this(string name) {
    _name = name;
    _initialized = false;
  }

  /**
   * Get component name.
   * Returns: The name of the component
   */
  string name() {
    return _name;
  }

  /**
   * Initialize the component.
   * Returns: true if initialization successful
   */
  abstract bool initialize();

  /**
   * Shutdown the component.
   */
  abstract void shutdown();
}

/**
 * Composite facade that manages multiple subsystems.
 */
class CompositeFacade : Facade, IObservableFacade {
  protected ISubsystemComponent[] _components;
  protected string[string] _componentStatus;

  /**
   * Add a subsystem component to the facade.
   * Params:
   *   component = The component to add
   */
  void addComponent(ISubsystemComponent component) {
    if (component !is null) {
      _components ~= component;
      _componentStatus[component.name()] = "inactive";
    }
  }

  /**
   * Initialize all subsystem components.
   * Returns: true if all components initialized successfully
   */
  override bool initialize() {
    if (_initialized) {
      return true;
    }

    foreach (component; _components) {
      if (component.initialize()) {
        _componentStatus[component.name()] = "active";
      } else {
        _componentStatus[component.name()] = "failed";
        return false;
      }
    }

    _initialized = true;
    return true;
  }

  /**
   * Shutdown all subsystem components.
   */
  override void shutdown() {
    foreach (component; _components) {
      component.shutdown();
      _componentStatus[component.name()] = "inactive";
    }
    _initialized = false;
  }

  /**
   * Get facade status information.
   * Returns: Status string
   */
  string status() {
    import std.conv : to;
    return _initialized ? "Active (" ~ _components.length.to!string ~ " components)" : "Inactive";
  }

  /**
   * Get list of managed components.
   * Returns: Array of component names
   */
  string[] components() {
    import std.algorithm : map;
    import std.array : array;
    return _components.map!(c => c.name()).array;
  }

  /**
   * Check if a specific component is active.
   * Params:
   *   componentName = Name of the component
   * Returns: true if component is active
   */
  bool isComponentActive(string componentName) {
    if (auto status = componentName in _componentStatus) {
      return *status == "active";
    }
    return false;
  }
}

/**
 * Configurable facade with configuration support.
 */
class ConfigurableFacade : CompositeFacade, IConfigurableFacade {
  protected string[string] _configuration;

  /**
   * Configure the facade with options.
   * Params:
   *   options = Configuration options
   */
  void configure(string[string] options) {
    _configuration = options.dup;
  }

  /**
   * Get current configuration.
   * Returns: Current configuration options
   */
  string[string] configuration() {
    return _configuration.dup;
  }

  /**
   * Get a configuration value.
   * Params:
   *   key = Configuration key
   *   defaultValue = Default value if key not found
   * Returns: Configuration value or default
   */
  string getConfig(string key, string defaultValue = "") {
    if (auto value = key in _configuration) {
      return *value;
    }
    return defaultValue;
  }
}

/**
 * Simple facade wrapper for delegate-based operations.
 */
class SimpleFacade : Facade {
  private bool delegate() @safe _initFunc;
  private void delegate() @safe _shutdownFunc;

  /**
   * Create a simple facade.
   * Params:
   *   initFunc = Initialization function
   *   shutdownFunc = Shutdown function
   */
  this(bool delegate() @safe initFunc, void delegate() @safe shutdownFunc) {
    _initFunc = initFunc;
    _shutdownFunc = shutdownFunc;
  }

  /**
   * Initialize using the provided function.
   * Returns: Result of initialization function
   */
  override bool initialize() {
    if (_initialized) {
      return true;
    }

    if (_initFunc) {
      _initialized = _initFunc();
      return _initialized;
    }
    return false;
  }

  /**
   * Shutdown using the provided function.
   */
  override void shutdown() {
    if (_shutdownFunc) {
      _shutdownFunc();
    }
    _initialized = false;
  }
}

/**
 * Helper function to create a simple facade.
 */
SimpleFacade createSimpleFacade(
    bool delegate() @safe initFunc,
    void delegate() @safe shutdownFunc) {
  return new SimpleFacade(initFunc, shutdownFunc);
}

// Unit tests
unittest {
  class TestComponent : SubsystemComponent {
    this(string name) {
      super(name);
    }

    override bool initialize() {
      _initialized = true;
      return true;
    }

    override void shutdown() {
      _initialized = false;
    }
  }

  auto facade = new CompositeFacade();
  facade.addComponent(new TestComponent("Component1"));
  facade.addComponent(new TestComponent("Component2"));

  assert(!facade.isReady(), "Should not be ready before initialization");
  assert(facade.initialize(), "Initialization should succeed");
  assert(facade.isReady(), "Should be ready after initialization");

  auto components = facade.components();
  assert(components.length == 2, "Should have 2 components");
  assert(facade.isComponentActive("Component1"), "Component1 should be active");
  assert(facade.isComponentActive("Component2"), "Component2 should be active");

  facade.shutdown();
  assert(!facade.isReady(), "Should not be ready after shutdown");
  assert(!facade.isComponentActive("Component1"), "Component1 should be inactive");
}

unittest {
  auto facade = new ConfigurableFacade();
  
  string[string] config;
  config["host"] = "localhost";
  config["port"] = "8080";
  
  facade.configure(config);
  
  assert(facade.getConfig("host") == "localhost", "Should get configured value");
  assert(facade.getConfig("port") == "8080", "Should get configured value");
  assert(facade.getConfig("unknown", "default") == "default", "Should return default for unknown key");
}

unittest {
  bool initialized = false;
  bool shutdownCalled = false;

  auto facade = createSimpleFacade(
    () {
      initialized = true;
      return true;
    },
    () {
      shutdownCalled = true;
    }
  );

  assert(!facade.isReady(), "Should not be ready initially");
  assert(facade.initialize(), "Should initialize");
  assert(initialized, "Init function should be called");
  assert(facade.isReady(), "Should be ready after init");

  facade.shutdown();
  assert(shutdownCalled, "Shutdown function should be called");
  assert(!facade.isReady(), "Should not be ready after shutdown");
}
