/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.entities.entity;

import uim.core;
import uim.oop;

import std.datetime : SysTime, Clock;
import std.uuid : UUID, randomUUID;

@safe:

/**
 * Entity state enumeration
 */
enum EntityState {
    New,        // Entity is newly created, not persisted
    Clean,      // Entity is unchanged since loaded
    Dirty,      // Entity has been modified
    Deleted     // Entity is marked for deletion
}

/**
 * Entity interface that defines the contract for all entities
 */
interface IEntity {
    // Identity
    UUID id();
    IEntity id(UUID value);
    
    string name();
    IEntity name(string value);
    
    // Timestamps
    SysTime createdAt();
    IEntity createdAt(SysTime value);
    
    SysTime updatedAt();
    IEntity updatedAt(SysTime value);
    
    // State management
    EntityState state();
    IEntity state(EntityState value);
    
    bool isNew();
    bool isClean();
    bool isDirty();
    bool isDeleted();
    
    // Data management
    STRINGAA attributes();
    IEntity attributes(STRINGAA value);
    
    string getAttribute(string key, string defaultValue = "");
    IEntity setAttribute(string key, string value);
    bool hasAttribute(string key);
    IEntity removeAttribute(string key);
    
    // Validation
    bool isValid();
    string[] errors();
    IEntity addError(string error);
    IEntity clearErrors();
    
    // Lifecycle
    void markDirty();
    void markClean();
    void markDeleted();
    
    // Serialization
    string toJson();
    STRINGAA toAA();
}

/**
 * Base entity class with common functionality
 */
class DEntity : UIMObject, IEntity {
    mixin(OProperty!("UUID", "id"));
    mixin(OProperty!("string", "name"));
    mixin(OProperty!("SysTime", "createdAt"));
    mixin(OProperty!("SysTime", "updatedAt"));
    mixin(OProperty!("EntityState", "state"));
    mixin(OProperty!("STRINGAA", "attributes"));
    
    protected string[] _errors;
    protected STRINGAA _originalAttributes;
    
    this() {
        super();
        this.id(randomUUID());
        this.createdAt(Clock.currTime());
        this.updatedAt(Clock.currTime());
        this.state(EntityState.New);
    }
    
    this(UUID entityId) {
        this();
        this.id(entityId);
    }
    
    // State checks
    bool isNew() { return this.state() == EntityState.New; }
    bool isClean() { return this.state() == EntityState.Clean; }
    bool isDirty() { return this.state() == EntityState.Dirty; }
    bool isDeleted() { return this.state() == EntityState.Deleted; }
    
    // Attribute management
    string getAttribute(string key, string defaultValue = "") {
        auto attrs = this.attributes();
        return (key in attrs) ? attrs[key] : defaultValue;
    }
    
    IEntity setAttribute(string key, string value) {
        auto attrs = this.attributes();
        attrs[key] = value;
        this.attributes(attrs);
        if (this.state() == EntityState.Clean) {
            markDirty();
        }
        return this;
    }
    
    bool hasAttribute(string key) {
        auto attrs = this.attributes();
        return (key in attrs) !is null;
    }
    
    IEntity removeAttribute(string key) {
        auto attrs = this.attributes();
        attrs.remove(key);
        this.attributes(attrs);
        if (this.state() == EntityState.Clean) {
            markDirty();
        }
        return this;
    }
    
    // Validation
    bool isValid() {
        return _errors.length == 0;
    }
    
    string[] errors() {
        return _errors.dup;
    }
    
    IEntity addError(string error) {
        _errors ~= error;
        return this;
    }
    
    IEntity clearErrors() {
        _errors = [];
        return this;
    }
    
    // Lifecycle
    void markDirty() {
        if (this.state() != EntityState.New && this.state() != EntityState.Deleted) {
            this.state(EntityState.Dirty);
            this.updatedAt(Clock.currTime());
        }
    }
    
    void markClean() {
        if (this.state() != EntityState.Deleted) {
            this.state(EntityState.Clean);
            _originalAttributes = this.attributes().dup;
        }
    }
    
    void markDeleted() {
        this.state(EntityState.Deleted);
        this.updatedAt(Clock.currTime());
    }
    
    // Serialization
    string toJson() {
        import std.json : JSONValue;
        import std.conv : to;
        
        JSONValue json;
        json["id"] = this.id().toString();
        json["name"] = this.name();
        json["state"] = this.state().to!string;
        json["createdAt"] = this.createdAt().toISOExtString();
        json["updatedAt"] = this.updatedAt().toISOExtString();
        
        JSONValue attrsJson;
        foreach (key, value; this.attributes()) {
            attrsJson[key] = value;
        }
        json["attributes"] = attrsJson;
        
        return json.toString();
    }
    
    STRINGAA toAA() {
        import std.conv : to;
        
        STRINGAA result;
        result["id"] = this.id().toString();
        result["name"] = this.name();
        result["state"] = this.state().to!string;
        result["createdAt"] = this.createdAt().toISOExtString();
        result["updatedAt"] = this.updatedAt().toISOExtString();
        
        foreach (key, value; this.attributes()) {
            result[key] = value;
        }
        
        return result;
    }
}

// Factory function
auto Entity() {
    return new DEntity();
}

auto Entity(UUID id) {
    return new DEntity(id);
}

auto Entity(string name) {
    auto entity = new DEntity();
    entity.name(name);
    return entity;
}

unittest {
    writeln("Testing DEntity class...");
    
    auto entity = Entity("Test Entity");
    assert(entity.name() == "Test Entity");
    assert(entity.isNew());
    assert(!entity.isDirty());
    
    entity.setAttribute("key1", "value1");
    assert(entity.hasAttribute("key1"));
    assert(entity.getAttribute("key1") == "value1");
    
    entity.markClean();
    assert(entity.isClean());
    
    entity.setAttribute("key2", "value2");
    assert(entity.isDirty());
    
    entity.markDeleted();
    assert(entity.isDeleted());
    
    writeln("DEntity tests passed!");
}
