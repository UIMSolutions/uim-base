/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.traps.trap;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:

/**
 * Entry point to UIM"s error handling.
 *
 * Using the `register()` method you can attach an ErrorTrap to D"s default error handler and register
 * a shutdown handler to handle fatal errors.
 *
 * When errors are trapped the `Error.beforeRender` event is triggered.
 * Then errors are logged (if enabled) and finally "rendered" using the defined renderer.
 *
 * Stopping the `Error.beforeRender` event has no effect, as we always need to render
 * a response to an error and custom renderers should be used if you want to replace or
 * skip rendering an error.
 *
 * If undefined, an ErrorRenderer will be selected based on the current SAPI (CLI or Web).
 */
class DErrorTrap : UIMObject {
    mixin(ErrorTrapThis!());
    // mixin TEventDispatcher;

    // Hook method
    override bool initialize(Json[string] initData = null) {
        if (!super.initialize(initData)) {
            return false;
        }

        /**
        * Configuration options. Generally these will be defined in your config/app.D
        *
        * - `errorRenderer` - string - The class responsible for rendering uncaught errors.
        *  The chosen class will be used for for both CLI and web environments. If  you want different
        *  classes used in CLI and web environments you"ll need to write that conditional logic as well.
        *  The conventional location for custom renderers is in `src/Error`. Your error renderer needs to
        *  implement the `render()` method and return either a string or Http\Response.
        * - `log` Set to false to disable logging.
        * - `logger` - string - The class name of the error logger to use.
        * - `trace` - boolean - Whether or not backtraces should be included in
        *  logged errors.
        * - `skipLog` - array - List of errors to skip for logging. Errors that
        *  extend one of the listed errors will also not be logged. E.g.:
        *  ```
        *  "skipLog": ["uim\Http\errors.NotFoundError", "uim\Http\errors.UnauthorizedError"]
        *  ```
        *  This option is forwarded to the configured `logger`
        * - `extraFatalErrorMemory` - int - The number of megabytes to increase the memory limit by when a fatal error is
        *  encountered. This allows breathing room to complete logging or error handling.
        * - `stderr` Used in console environments so that renderers have access to the current console output stream.
        */
        /* configuration
            .setEntry("errorRenderer", Null!Json)
            .setEntry("logger", ErrorLogger.classname)
            .setEntry("stderr", Null!Json)
            .setEntry("log", true)
            .setEntry("skipLog", Json.emptyArray)
            .setEntry("trace", false)
            .setEntry("extraFatalErrorMemory", 4); */

        return true;
    }

    /**
     * A list of handling callbacks.
     *
     * Callbacks are invoked for each error that is handled.
     * Callbacks are invoked in the order they are attached.
     *
     * @var array<\Closure>
     */
    protected IClosure callbacks = null;

    /**
     * The currently registered global error handler
     *
     * This is best effort as we can"t know if/when another
     * error handler is registered.
     */
    // protected static ErrorTrap registeredTrap = null;

    // Track if this trap was removed from the global handler.
    protected bool _isDisabled = false;

    // Get an instance of the renderer.
    /* IErrorRenderer renderer(Throwable errorToRender, IServerRequest serverRequest = null) {
        /* serverRequest = serverRequest ? serverRequest : Router.getRequest();

        /** @var class-string|callable aclassname * /
        aclassname = configuration.getEntry("errorRenderer");
        deprecateDFileConfigEngine = (aclassname == ErrorRenderer.classname && D_SAPI == "cli");
        if (deprecateDFileConfigEngine) {
            deprecationWarning(
                "Your application is using a deprecated `Error.errorRenderer`~ " ~
                "You can either remove the `Error.errorRenderer` config key to have UIM choose " ~
                "one of the default error renderers, or define a class that is not `uim\errors.ErrorRenderer`."
           );
        }
        if (!aclassname || deprecateDFileConfigEngine) {
            // Default to detecting the error renderer if we"re
            // in a CLI context and the Web renderer is currently selected.
            // This indicates old configuration or user error, in both scenarios
            // it is preferrable to use the Console renderer instead.
            aclassname = this.chooseRenderer();
        }

        if (aclassname.isString) {
            /** @psalm-suppress ArgumentTypeCoercion * /
            if (!(hasMethod(aclassname, "render") && hasMethod(aclassname, "write"))) {
                throw new DInvalidArgumentError(
                    "Cannot use {aclassname} as an `errorRenderer`~ " ~
                    "It must implement render() and write() methods."
               );
            }

            /** @var class-string<uim.errors.IErrorRenderer> aclassname * /
            return new aclassname(error, serverRequest, _config);
        }

        return aclassname(error, serverRequest); * /
        return null;
    } */

    // Choose an error renderer based on config or the SAPI
    protected string chooseRenderer() {
        /** @var class-string<uim.errors.IErrorRenderer> */
        // return D_SAPI == "cli" ? ConsoleErrorRenderer.classname : ErrorRenderer.classname;
        return null; 
    }

    // Get an instance of the logger.
    IErrorLogger logger() {
        /** @var class-string<uim.errors.IErrorLogger> aclassname */
/*         auto aclassname = configuration.getEntry("logger", _defaultConfig["logger"]);

        return new aclassname(_config); */
        return null;
    }

    /**
     * Attach this ErrorTrap to D"s default error handler.
     *
     * This will replace the existing error handler, and the
     * previous error handler will be discarded.
     */
    void register() {
        /* set_error_handler([this, "handleError"]);
        register_shutdown_function([this, "handleShutdown"]);
        registeredTrap = this; */
    }

    /**
     * Remove this instance from the singleton
     *
     * If this instance is not currently the registered singleton
     * nothing happens.
     */
    void unregister() {
/*         if (registeredTrap == this) {
            _isDisabled = true;
            registeredTrap = null;
        }
 */    }

    /**
     * Get the registered global instance if set.
     *
     * Keep in mind that the global state contained here
     * is mutable and the object returned by this method
     * could be a stale value.
     */
    static DErrorTrap instance() {
        // return registeredTrap;
        return null;
    }

    /**
     * Handle uncaught errors.
     *
     * Uses a template method provided by subclasses to display errors in an
     * environment appropriate way.
     */
    void handleError(Throwable error) {
        /* if (_isDisabled) {
            return;
        }
        
        auto request = Router.getRequest();
        logError(error, request);

        try {
            renderer = this.renderer(error);
            renderer.write(renderer.render());
        } catch (Throwable error) {
            this.logInternalError(error);
        }
        // Use this constant as a proxy for uimD tests.
        if (D_SAPI == "cli" && !env("FIXTURE_SCHEMA_METADATA")) {
            exit(1);
        } */
    }

    /**
     * Shutdown handler
     *
     * Convert fatal errors into errors that we can render.
     */
    void handleShutdown() {
        /* if (_isDisabled) {
            return;
        }
        megabytes = _config["extraFatalErrorMemory"] ?? 4;
        if (megabytes > 0) {
            this.increaseMemoryLimit(megabytes * 1024);
        }
        error = error_get_last();
        if (!error.isArray) {
            return;
        }
        fatals = [
            errors.USER_ERROR,
            errors.ERROR,
            errors.PARSE,
        ];
        if (!hasAllValues(error["type"], fatals, true)) {
            return;
        }
        this.handleFatalError(
            error["type"],
            error["message"],
            error["file"],
            error["line"]
       ); */
    }

    // Increases the UIM "memory_limit" ini setting by the specified amount in kilobytes
    void increaseMemoryLimit(int additionalKb) {
        /* auto limit = ini_get("memory_limit");
        if (limit.isEmpty || limit == "-1") {
            return;
        }
        limit = limit.strip;
        auto units = subString(limit, -1).upper;
        auto current = (int)subString(limit, 0, -1);
        if (units == "M") {
            current *= 1024;
            units = "K";
        }
        if (units == "G") {
            current = current * 1024 * 1024;
            units = "K";
        }

        if (units == "K") {
            ini_set("memory_limit", ceil(current + additionalKb) ~ "K");
        } */
    }

    // Display/Log a fatal error.
    void handleFatalError(int errorCode, string errorDescription, string fileWithError, int errorLine) {
        // this.handleError(new DFatalErrorError("Fatal Error: " ~ description, 500, fileWithError, errorLine));
    }

    /**
     * Log an error.
     *
     * Primarily a function to ensure consistency between global error handling
     * and the ErrorHandlerMiddleware. This method will apply the `skipLog` filter
     * skipping logging if the error should not be logged.
     *
     * After logging is attempted the `Error.beforeRender` event is triggered.
     */
    /* void logError(Throwable errorToLog, IServerRequest serverRequest = null) {
        /* auto shouldLog = _config["log"];
        if (shouldLog) {
            foreach (aclassname, configuration.getEntry("skipLog")) {
                if (cast(aclassname)errorToLog ) {
                    shouldLog = false;
                }
            }
        }
        if (shouldLog) {
            logger = logger();
            if (hasMethod(logger, "logError")) {
                logger.logError(errorToLog, serverRequest, _config["trace"]);
            } else {
                loggerClass = get_class(logger);
                deprecationWarning(
                    "The configured logger `{loggerClass}` should implement `logError()` " ~
                    "to be compatible with future versions of UIM."
               );
                logger().log(errorToLog, serverRequest);
            }
        }
        dispatchEvent("Error.beforeRender", ["error": errorToLog]); * /
    } */

    /**
     * Trigger an error that occurred during rendering an error.
     *
     * By triggering an errors.USER_ERROR we can end up in the default
     * error handling which will log the rendering failure,
     * and hopefully render an error page.
     */
    void logInternalError(Throwable errorToLog) {
        /* string message = "[%s] %s (%s:%s)".format( // Keeping same message format
            get_class(errorToLog),
            errorToLog.message(),
            errorToLog.getFile(),
            errorToLog.getLine(),
        );
        trigger_error(message, errors.USER_ERROR); */
    }
}
