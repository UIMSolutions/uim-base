/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.events.event;

import uim.core;
import uim.oop;

import std.datetime : SysTime, Clock;

@safe:

/**
 * Event interface that defines the contract for all events
 */
interface IEvent {
    // Properties
    string name();
    IEvent name(string value);
    
    SysTime timestamp();
    IEvent timestamp(SysTime value);
    
    bool stopped();
    IEvent stopped(bool value);
    
    STRINGAA data();
    IEvent data(STRINGAA value);
    
    // Methods
    void stopPropagation();
    bool isPropagationStopped();
    IEvent setData(string key, string value);
    string getData(string key, string defaultValue = "");
    bool hasData(string key);
}

/**
 * Base event class that all events should inherit from.
 * Provides common event functionality including name, timestamp, and propagation control.
 */
class DEvent : UIMObject, IEvent {
    mixin(OProperty!("string", "name"));
    mixin(OProperty!("SysTime", "timestamp"));
    mixin(OProperty!("bool", "stopped"));
    mixin(OProperty!("STRINGAA", "data"));
    
    protected bool _propagationStopped = false;
    
    this() {
        super();
        this.timestamp(Clock.currTime());
    }
    
    this(string eventName) {
        this();
        this.name(eventName);
    }
    
    /**
     * Stop event propagation to subsequent listeners
     */
    void stopPropagation() {
        _propagationStopped = true;
        this.stopped(true);
    }
    
    /**
     * Check if propagation has been stopped
     */
    bool isPropagationStopped() {
        return _propagationStopped;
    }
    
    /**
     * Set event data
     */
    DEvent setData(string key, string value) {
        auto currentData = this.data();
        currentData[key] = value;
        this.data(currentData);
        return this;
    }
    
    /**
     * Get event data
     */
    string getData(string key, string defaultValue = "") {
        auto currentData = this.data();
        return (key in currentData) ? currentData[key] : defaultValue;
    }
    
    /**
     * Check if event has data key
     */
    bool hasData(string key) {
        auto currentData = this.data();
        return (key in currentData) !is null;
    }
}

// Factory function
auto Event(string name = "") {
    return new DEvent(name);
}

unittest {
    writeln("Testing DEvent class...");
    
    auto event = Event("test.event");
    assert(event.name() == "test.event");
    assert(!event.isPropagationStopped());
    
    event.stopPropagation();
    assert(event.isPropagationStopped());
    
    event.setData("key1", "value1");
    assert(event.hasData("key1"));
    assert(event.getData("key1") == "value1");
    assert(event.getData("nonexistent", "default") == "default");
    
    writeln("DEvent tests passed!");
}
