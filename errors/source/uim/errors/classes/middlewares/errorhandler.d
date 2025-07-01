/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.middlewares.errorhandler;

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

    this(IErrorHandler newErrorHandler = null, Json[string] initData = null) {
        super(initData);
        _errorHandler = newErrorHandler;
    }

    // Hook method
    override bool initialize(Json[string] initData = null) {
        if (!super.initialize(initData)) {
            return false;
        }

        /**
        * Default configuration values.
        *
        * Ignored if contructor is passed an ErrorHandler instance.
        *
        * - `log` Enable logging of errors.
        * - `skipLog` List of errors to skip logging. Errors that
        *  extend one of the listed errors will also not be logged. Example:
        *
        *  ```
        *  "skipLog": ["uim\errors.NotFoundError", "uim\errors.UnauthorizedError"]
        *  ```
        *
        * - `trace` Should error logs include stack traces?
        * - `errorRenderer` The renderer instance or class name to use or a callable factory
        *  which returns a uim.errorss.IErrorRenderer instance.
        *  Defaults to uim.errorss.ErrorRenderer
        */
/*         configuration
            .setEntry("skipLog", Json.emptyArray)
            .setEntry("log", true)
            .setEntry("trace", false)
            .setEntry("errorRenderer", ErrorRenderer.classname); */

        return true;
    }

    // Error handler instance.
    protected IErrorHandler _errorHandler;

    // Wrap the remaining middleware with error handling.
    /* IResponse process(IServerRequest request, IRequestHandler requestHandler) {
        try {
            return requestHandler.handle(request);
        }  /* catch (DRedirectError error) {
            return _handleRedirect(error);
        } * /
        catch (Throwable error) {
            return _handleError(error, request);
        }
    } */

    // Handle an error and generate an error response
    /* IResponse handleError(Throwable error, IServerRequest request) {
        auto _errorHandler = getErrorHandler();
        auto renderer = _errorHandler.getRenderer(error, request);

        IResponse response;
        try {
            _errorHandler.logError(error, request);
            response = renderer.render();
        } catch (Throwable internalError) {
            /*  _errorHandler.logError@(DInternalError, request);
            response = handleInternalError(); * /
        }

        return response;
    } */

    // Convert a redirect error into a response.
    /*     IResponse handleRedirect(DRedirectError errorToHandle) {
        return new DRedirectResponse(
            errorToHandle.message(),
            errorToHandle.code(),
            errorToHandle.getHeaders()
        );
    }
 */
    // Handle internal errors.
    /* protected IResponse handleInternalError() {
        response = new DResponse(["body": "An Internal Server Error Occurred"]);

        return response.withStatus(500);
    } */

    // Get a error handler instance
    protected IErrorHandler getErrorHandler() {
        /* if (_errorHandler.isNull) {
            /** @var class-string<uim.errorss.ErrorHandler> myclassname * /
            myclassname = App.classname("ErrorHandler", "Error");
            // _errorHandler = new myclassname(this.configuration.data);
        }

        return _errorHandler; */
        return null; // TODO
    }
}
