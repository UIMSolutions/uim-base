/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.events.domain_event;

import std.datetime;
import std.uuid;

@safe:

/**
 * Base domain event
 */
abstract class DomainEvent {
  private UUID _eventId;
  private SysTime _occurredAt;
  private string _eventType;

  this(string eventType) {
    _eventId = randomUUID();
    _occurredAt = Clock.currTime();
    _eventType = eventType;
  }

  UUID eventId() const { return _eventId; }
  SysTime occurredAt() const { return _occurredAt; }
  string eventType() const { return _eventType; }
}

/**
 * Event handler interface
 */
interface IEventHandler(T : DomainEvent) {
  void handle(T event);
}

/**
 * Simple event bus
 */
class EventBus {
  private static IEventHandler!DomainEvent[][string] _handlers;

  static void register(T : DomainEvent)(IEventHandler!T handler) {
    auto eventType = T.stringof;
    if (eventType !in _handlers) {
      _handlers[eventType] = [];
    }
    _handlers[eventType] ~= cast(IEventHandler!DomainEvent)handler;
  }

  static void publish(T : DomainEvent)(T event) {
    auto eventType = T.stringof;
    if (auto handlers = eventType in _handlers) {
      foreach (handler; *handlers) {
        (cast(IEventHandler!T)handler).handle(event);
      }
    }
  }
}