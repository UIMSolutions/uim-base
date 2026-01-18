module uim.events.interfaces.subscriber;

import uim.core;
import uim.oop;

import std.datetime : SysTime, Clock;

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
