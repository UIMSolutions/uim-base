/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.middlewares.handler;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:

/**
 * Error handling middleware.
 *
 * Traps errors and converts them into HTML or content-type appropriate
 * error pages using the UIM ErrorRenderer.
 */
class DErrorHandlerMiddleware : UIMObject, IErrorMiddleware {
    this(Json[string] initData = null) {
        super(initData);
    }
}
