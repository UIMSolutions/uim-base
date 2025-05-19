/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.exceptions.classes.traps.trap;

mixin(Version!("test_uim_exceptions"));

import uim.exceptions;
@safe:

/**
 * Entry point to UIM"s exception handling.
 *
 * Using the `register()` method you can attach an ExceptionTrap to D"s default exception handler and register
 * a shutdown handler to handle fatal exceptions.
 *
 * When exceptions are trapped the `Exception.beforeRender` event is triggered.
 * Then exceptions are logged (if enabled) and finally "rendered" using the defined renderer.
 *
 * Stopping the `Exception.beforeRender` event has no effect, as we always need to render
 * a response to an exception and custom renderers should be used if you want to replace or
 * skip rendering an exception.
 *
 * If undefined, an ExceptionRenderer will be selected based on the current SAPI (CLI or Web).
 */
class DExceptionTrap : UIMObject {
    mixin(ExceptionTrapThis!());
    // mixin TEventDispatcher;

    // Hook method
    override bool initialize(Json[string] initData = null) {
        if (!super.initialize(initData)) {
            return false;
        }

        /**
        * Configuration options. Generally these will be defined in your config/app.D
        *
        * - `exceptionRenderer` - string - The class responsible for rendering uncaught exceptions.
        *  The chosen class will be used for for both CLI and web environments. If  you want different
        *  classes used in CLI and web environments you"ll need to write that conditional logic as well.
        *  The conventional location for custom renderers is in `src/Exception`. Your exception renderer needs to
        *  implement the `render()` method and return either a string or Http\Response.
        * - `log` Set to false to disable logging.
        * - `logger` - string - The class name of the exception logger to use.
        * - `trace` - boolean - Whether or not backtraces should be included in
        *  logged exceptions.
        * - `skipLog` - array - List of exceptions to skip for logging. Exceptions that
        *  extend one of the listed exceptions will also not be logged. E.g.:
        *  ```
        *  "skipLog": ["uim\Http\exceptions.NotFoundException", "uim\Http\exceptions.UnauthorizedException"]
        *  ```
        *  This option is forwarded to the configured `logger`
        * - `extraFatalExceptionMemory` - int - The number of megabytes to increase the memory limit by when a fatal exception is
        *  encountered. This allows breathing room to complete logging or exception handling.
        * - `stderr` Used in console environments so that renderers have access to the current console output stream.
        */
        /* configuration
            .setEntry("exceptionRenderer", Json(null))
            .setEntry("logger", ExceptionLogger.classname)
            .setEntry("stderr", Json(null))
            .setEntry("log", true)
            .setEntry("skipLog", Json.emptyArray)
            .setEntry("trace", false)
            .setEntry("extraFatalExceptionMemory", 4); */

        return true;
    }

    /**
     * A list of handling callbacks.
     *
     * Callbacks are invoked for each exception that is handled.
     * Callbacks are invoked in the order they are attached.
     *
     * @var array<\Closure>
     */
    protected IClosure callbacks = null;

    /**
     * The currently registered global exception handler
     *
     * This is best effort as we can"t know if/when another
     * exception handler is registered.
     */
    // protected static ExceptionTrap registeredTrap = null;

    // Track if this trap was removed from the global handler.
    protected bool _isDisabled = false;

    // Get an instance of the renderer.
    /* IExceptionRenderer renderer(Throwable exceptionToRender, IServerRequest serverRequest = null) {
        /* serverRequest = serverRequest ? serverRequest : Router.getRequest();

        /** @var class-string|callable aclassname * /
        aclassname = configuration.getEntry("exceptionRenderer");
        deprecateDFileConfigEngine = (aclassname == ExceptionRenderer.classname && D_SAPI == "cli");
        if (deprecateDFileConfigEngine) {
            deprecationWarning(
                "Your application is using a deprecated `Exception.exceptionRenderer`~ " ~
                "You can either remove the `Exception.exceptionRenderer` config key to have UIM choose " ~
                "one of the default exception renderers, or define a class that is not `uim\exceptions.ExceptionRenderer`."
           );
        }
        if (!aclassname || deprecateDFileConfigEngine) {
            // Default to detecting the exception renderer if we"re
            // in a CLI context and the Web renderer is currently selected.
            // This indicates old configuration or user exception, in both scenarios
            // it is preferrable to use the Console renderer instead.
            aclassname = this.chooseRenderer();
        }

        if (aclassname.isString) {
            /** @psalm-suppress ArgumentTypeCoercion * /
            if (!(hasMethod(aclassname, "render") && hasMethod(aclassname, "write"))) {
                throw new DInvalidArgumentException(
                    "Cannot use {aclassname} as an `exceptionRenderer`~ " ~
                    "It must implement render() and write() methods."
               );
            }

            /** @var class-string<uim.exceptions.IExceptionRenderer> aclassname * /
            return new aclassname(exception, serverRequest, _config);
        }

        return aclassname(exception, serverRequest); * /
        return null;
    } */

    // Choose an exception renderer based on config or the SAPI
    protected string chooseRenderer() {
        /** @var class-string<uim.exceptions.IExceptionRenderer> */
        // return D_SAPI == "cli" ? ConsoleExceptionRenderer.classname : ExceptionRenderer.classname;
        return null; 
    }

    // Get an instance of the logger.
    IExceptionLogger logger() {
        /** @var class-string<uim.exceptions.IExceptionLogger> aclassname */
/*         auto aclassname = configuration.getEntry("logger", _defaultConfig["logger"]);

        return new aclassname(_config); */
        return null;
    }

    /**
     * Attach this ExceptionTrap to D"s default exception handler.
     *
     * This will replace the existing exception handler, and the
     * previous exception handler will be discarded.
     */
    void register() {
        /* set_exception_handler([this, "handleException"]);
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
    static DExceptionTrap instance() {
        // return registeredTrap;
        return null;
    }

    /**
     * Handle uncaught exceptions.
     *
     * Uses a template method provided by subclasses to display exceptions in an
     * environment appropriate way.
     */
    void handleException(Throwable exception) {
        /* if (_isDisabled) {
            return;
        }
        
        auto request = Router.getRequest();
        logException(exception, request);

        try {
            renderer = this.renderer(exception);
            renderer.write(renderer.render());
        } catch (Throwable exception) {
            this.logInternalException(exception);
        }
        // Use this constant as a proxy for uimD tests.
        if (D_SAPI == "cli" && !env("FIXTURE_SCHEMA_METADATA")) {
            exit(1);
        } */
    }

    /**
     * Shutdown handler
     *
     * Convert fatal exceptions into exceptions that we can render.
     */
    void handleShutdown() {
        /* if (_isDisabled) {
            return;
        }
        megabytes = _config["extraFatalExceptionMemory"] ?? 4;
        if (megabytes > 0) {
            this.increaseMemoryLimit(megabytes * 1024);
        }
        exception = exception_get_last();
        if (!exception.isArray) {
            return;
        }
        fatals = [
            exceptions.USER_EXCEPTION,
            exceptions.EXCEPTION,
            exceptions.PARSE,
        ];
        if (!hasAllValues(exception["type"], fatals, true)) {
            return;
        }
        this.handleFatalException(
            exception["type"],
            exception["message"],
            exception["file"],
            exception["line"]
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

    // Display/Log a fatal exception.
    void handleFatalException(int exceptionCode, string exceptionDescription, string fileWithException, int exceptionLine) {
        // this.handleException(new DFatalExceptionException("Fatal Exception: " ~ description, 500, fileWithException, exceptionLine));
    }

    /**
     * Log an exception.
     *
     * Primarily a function to ensure consistency between global exception handling
     * and the ExceptionHandlerMiddleware. This method will apply the `skipLog` filter
     * skipping logging if the exception should not be logged.
     *
     * After logging is attempted the `Exception.beforeRender` event is triggered.
     */
    /* void logException(Throwable exceptionToLog, IServerRequest serverRequest = null) {
        /* auto shouldLog = _config["log"];
        if (shouldLog) {
            foreach (aclassname, configuration.getEntry("skipLog")) {
                if (cast(aclassname)exceptionToLog ) {
                    shouldLog = false;
                }
            }
        }
        if (shouldLog) {
            logger = logger();
            if (hasMethod(logger, "logException")) {
                logger.logException(exceptionToLog, serverRequest, _config["trace"]);
            } else {
                loggerClass = get_class(logger);
                deprecationWarning(
                    "The configured logger `{loggerClass}` should implement `logException()` " ~
                    "to be compatible with future versions of UIM."
               );
                logger().log(exceptionToLog, serverRequest);
            }
        }
        dispatchEvent("Exception.beforeRender", ["exception": exceptionToLog]); * /
    } */

    /**
     * Trigger an exception that occurred during rendering an exception.
     *
     * By triggering an exceptions.USER_EXCEPTION we can end up in the default
     * exception handling which will log the rendering failure,
     * and hopefully render an exception page.
     */
    void logInternalException(Throwable exceptionToLog) {
        /* string message = "[%s] %s (%s:%s)".format( // Keeping same message format
            get_class(exceptionToLog),
            exceptionToLog.message(),
            exceptionToLog.getFile(),
            exceptionToLog.getLine(),
        );
        trigger_exception(message, exceptions.USER_EXCEPTION); */
    }
}
