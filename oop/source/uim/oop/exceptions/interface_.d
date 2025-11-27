/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.exceptions.interface_;

import uim.oop;
mixin(Version!("test_uim_oop"));
@safe:

interface IException {
    /**
     * Returns the error code of the exception.
     * /
    int errorCode() const;

    /**
     * Returns the error message of the exception.
     */
    // string errorMessage() const;

    /**
     * Returns the stack trace of the exception.
     * /
    string stackTrace() const;*/
}
