/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.errors.logger;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:


// Log errors and unhandled errors to `UIM\Log\Log`
class DErrorLogger : UIMObject, IErrorLogger {
    this() {
        initialize;
    }

    this(Json[string] initData) {
        initialize(initData);
    }

    override bool initialize(Json[string] initData = null) {
        if (!super.initialize(initData)) {
            return false;
        }

        configuration.setEntry("trace", false); // `trace` = Should error logs include stack traces?        
        return true;
    }

    /* void logError(IError error, IServerRequest serverRequest = null, bool anIncludeTrace = false) {
        auto errorMessage = error.message();
        if (request) {
            errorMessage ~= getRequestContext(request);
        }
        if (anIncludeTrace) {
            errorMessage ~= "\nTrace:\n" ~ error.traceAsString() ~ "\n";
        }
        /* label = error.loglevel();
        level = match (label) {
            "strict": loglevels.trace,
            "deprecated": loglevels.debug__,
            default: label,
        };

        Log.write(level, errorMessage); * /
    } */

    /* void logError(
        Throwable error,
        IServerRequest serverRequest = null,
        bool anIncludeTrace = false
    ) {
        errorMessage = message(error, false, anIncludeTrace);

        if (!request.isNull) {
            errorMessage ~= getRequestContext(request);
        }
        Log.error(errorMessage);
    } */

    // Generate the message for the error
    protected string message(Throwable errorToLog, bool isPrevious = false, bool includeTrace = false) {
        /*         string message = "%s[%s] %s in %s on line %s"
            .format(
                isPrevious ? "\nCaused by: " : "",
                errorToLog.classname,
                errorToLog.message(),
                errorToLog.getFile(),
                errorToLog.getLine()
           );

        debug = configuration.getEntry("debug");
 */
        /*         if (debug && cast(DError)errorToLog) {
            attributes = errorToLog.getAttributes();
            if (attributes) {
                message ~= "\nError Attributes: " ~ varexport_(errorToLog.getAttributes(), true);
            }
        }
 */
        /* if (includeTrace) {
            trace = Debugger.formatTrace(errorToLog, ["format": "points"]);
            assert(trace.isArray);
            message ~= "\nStack Trace:\n";
            trace.each!((line) {
                message ~= isString(line)
                    ? "- " ~ line
                    : "- {line["file"]}:{line["line"]}\n";
            });
        }
 */
        /*  auto previousError = errorToLog.getPrevious();
        if (previousError) {
            message ~= message(previousError, true,  includeTrace);
        }
        return message; */
        return null;
    }

    // Get the request context for an error/error trace.
    /* string getRequestContext(IServerRequest request) {
        // TODO  string message = "\nRequest URL: " ~ request.getRequestTarget();

        /*  referer = request.getHeaderLine("Referer");
        if (referer) {
            message ~= "\nReferer URL: " ~ referer;
        }
        if (cast(DServerRequest)request) {
            clientIp = request.clientIp();
            if (clientIp && clientIp != ".1") {
                message ~= "\nClient IP: " ~ clientIp;
            }
        }
        return message; * /
        return null;
    } */
}
