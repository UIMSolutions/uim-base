/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.events.subscriber;

import uim.core;
import uim.oop;
import uim.events.event;
import uim.events.listener;
import uim.events.dispatcher;

@safe:

/**
 * Event subscriber interface for registering multiple event listeners at once
 */
interface IEventSubscriber {
    /**
     * Get subscribed events as an associative array
     * Key: event name
     * Value: callback or listener
     */
    void subscribe(DEventDispatcher dispatcher);
}

/**
 * Base event subscriber class
 */
abstract class DEventSubscriber : UIMObject, IEventSubscriber {
    this() {
        super();
    }
    
    /**
     * Override this method to register event listeners
     */
    abstract void subscribe(DEventDispatcher dispatcher);
}

unittest {
    writeln("Testing DEventSubscriber class...");
    
    class TestSubscriber : DEventSubscriber {
        int callCount = 0;
        
        override void subscribe(DEventDispatcher dispatcher) {
            dispatcher.on("test.event1", (IEvent event) {
                callCount++;
            });
            
            dispatcher.on("test.event2", (IEvent event) {
                callCount++;
            });
        }
    }
    
    auto dispatcher = EventDispatcher();
    auto subscriber = new TestSubscriber();
    subscriber.subscribe(dispatcher);
    
    dispatcher.dispatch(Event("test.event1"));
    assert(subscriber.callCount == 1);
    
    dispatcher.dispatch(Event("test.event2"));
    assert(subscriber.callCount == 2);
    
    writeln("DEventSubscriber tests passed!");
}
