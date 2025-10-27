/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.tests.testsession;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

/*
/**
 * A class to contain and retain the session during integration testing.
 * Read only access to the session during testing.
 */
class DTestSession {
    protected Json[string] _session = null;

    this(Json[string] sessionData) {
        _session = sessionData;
    }
    
    // Returns true if given variable name is set in session.
    bool check(string nameToCheck = null) {
        if (_session is null) {
            return false;
        }
        
        return nameToCheck.isNull
            ? _session !is null
            : false; // TODO !Hash.get(_session, nameToCheck).isNull;
    }
    
    // Returns given session variable, or all of them, if no parameters given.
    Json read(string sessionName = null) {
        if (_session is null) {
            return Json(null);
        }
        // TODO 
        /* if (sessionName.isNull) {
            return _session ? _session : Json(null);
        } */ 
        return Json(null); // TODO Hash.get(_session, sessionName);
    } 
}
