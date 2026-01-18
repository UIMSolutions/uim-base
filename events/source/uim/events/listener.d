/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.events.listener;

import uim.core;
import uim.oop;
import uim.events.event;

@safe:

/**
 * Event listener callback type
 */
alias EventCallback = void delegate(IEvent event) @safe;

/**
 * Event listener with priority support
 */
class DEventListener : UIMObject {
    mixin(OProperty!("EventCallback", "callback"));
    mixin(OProperty!("int", "priority"));
    mixin(OProperty!("bool", "once"));
    
    protected bool _executed = false;
    
    this() {
        super();
        this.priority(0);
        this.once(false);
    }
    
    this(EventCallback callback, int priority = 0) {
        this();
        this.callback(callback);
        this.priority(priority);
    }
    
    /**
     * Execute the listener callback
     */
    void execute(IEvent event) {
        if (this.once() && _executed) {
            return;
        }
        
        auto cb = this.callback();
        if (cb !is null) {
            cb(event);
            _executed = true;
        }
    }
    
    /**
     * Check if this listener has been executed (for one-time listeners)
     */
    bool hasExecuted() {
        return _executed;
    }
    
    /**
     * Reset execution state
     */
    void reset() {
        _executed = false;
    }
}

// Factory functions
auto EventListener(EventCallback callback, int priority = 0) {
    return new DEventListener(callback, priority);
}

auto EventListenerOnce(EventCallback callback, int priority = 0) {
    auto listener = new DEventListener(callback, priority);
    listener.once(true);
    return listener;
}

unittest {
    writeln("Testing DEventListener class...");
    
    int callCount = 0;
    auto listener = EventListener((DEvent event) {
        callCount++;
    });
    
    auto event = Event("test");
    listener.execute(event);
    assert(callCount == 1);
    
    listener.execute(event);
    assert(callCount == 2);
    
    // Test one-time listener
    int onceCount = 0;
    auto onceListener = EventListenerOnce((DEvent event) {
        onceCount++;
    });
    
    onceListener.execute(event);
    assert(onceCount == 1);
    
    onceListener.execute(event);
    assert(onceCount == 1, "One-time listener should only execute once");
    
    writeln("DEventListener tests passed!");
}
