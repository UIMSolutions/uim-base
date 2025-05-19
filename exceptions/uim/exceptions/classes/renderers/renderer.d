/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.exceptions.classes.renderers.renderer;

mixin(Version!("test_uim_exceptions"));

import uim.exceptions;

@safe:

/**
 * Exception Renderer.
 *
 * Captures and handles all unhandled exceptions. Displays helpful framework exceptions when debug is true.
 * When debug is false a ExceptionRenderer will render 404 or 500 exceptions. If an uncaught exception is thrown
 * and it is a type that ExceptionHandler does not know about it will be treated as a 500 exception.
 *
 * ### Implementing application specific exception rendering
 *
 * You can implement application specific exception handling by creating a subclass of
 * ExceptionRenderer and configure it to be the `exceptionRenderer` in config/exception.D
 *
 * #### Using a subclass of ExceptionRenderer
 *
 * Using a subclass of ExceptionRenderer gives you full control over how Exceptions are rendered, you
 * can configure your class in your config/app.D.
 */
class DExceptionRenderer : UIMObject, IExceptionRenderer {
  mixin(ExceptionTrapThis!());

  // Template to render for {@link uim.Core\exceptions.DException}
  protected string _template = "";

  // The method corresponding to the Exception this object is for.
  protected string method = "";

  // The exception being handled.
  protected IException _exception;

  // Controller instance.
  /*  protected IController controller; */

  /**
     * If set, this will be request used to create the controller that will render
     * the exception.
     */
  /* protected IServerRequest _request; */

  /**
     * MapHelper of exceptions to http status codes.
     *
     * This can be customized for users that don"t want specific exceptions to throw 404 exceptions
     * or want their application exceptions to be automatically converted.
     *
     * @var array<string, int>
     * @psalm-var array<class-string<\Throwable>, int>
     */
  /* protected int[string] myExceptionHttpCodes = [
        // Controller exceptions
        InvalidParameterException.classname: 404,
        MissingActionException.classname: 404,
        // Datasource exceptions
        PageOutOfBoundsException.classname: 404,
        RecordNotFoundException.classname: 404,
        // Http exceptions
        MissingControllerException.classname: 404,
        // Routing exceptions
        MissingRouteException.classname: 404,
    ]; */

  // Creates the controller to perform rendering on the exception response.
  /* this(Throwable exception, IServerRequest serverRequest = null) {
        _exception = exception;
        _request = serverRequest;
        _controller = _getController();
    } */

  /**
     * Get the controller instance to handle the exception.
     * Override this method in subclasses to customize the controller used.
     * This method returns the built in `ExceptionController` normally, or if an exception is repeated
     * a bare controller will be used.
     */
  protected IExceptionController _getController() {
    /* auto _request = _request;
        auto routerRequest = Router.getRequest();
        // Fallback to the request in the router or make a new one from
        // _SERVER
        if (_request.isNull) {
            _request = routerRequest ? routerRequest: ServerRequestFactory.fromGlobals();
        }

        // If the current request doesn"t have routing data, but we
        // found a request in the router context copy the params over
        if (_request.getParam("controller").isNull && routerRequest  !is null) {
            _request = _request.withAttribute("params", routerRequest.getAttribute("params"));
        }

        _exceptionOccured = false;
            IController controller;
        try {
            auto params = _request.getAttribute("params");
            params.set("controller", "Exception");

            auto factory = new DControllerFactory(new DContainer());
            string myClass = factory.controllerClass(_request.withAttribute("params", params));

            if (myClass.isEmpty) {
                myClass = App.classname("Exception", "Controller", "Controller");
            }

            auto controller = new myClass(_request);
            controller.startupProcess();
        } catch (Throwable throwable) {
            _exceptionOccured = true;
        }

        if (controller.isNull) {
            return new DController(_request);
        } */

    // Retry RequestHandler, as another aspect of startupProcess()
    // could have failed. Ignore any exceptions out of startup, as
    // there could be userland input data parsers.
    /* if (_exceptionOccured && controller.RequestHandler !is null) {
            try {
                myEvent = new DEvent("Controller.startup", controller);
                controller.RequestHandler.startup(myEvent);
            } catch (Throwable throwable) {
            }
        }

        return controller; */

    return null;
  }

  // Clear output buffers so exception pages display properly.
  protected void clearOutput() {
    /*         if (hasAllValues(D_SAPI, ["cli", "Ddbg"])) {
            return;
        }
        while (ob_get_level()) {
            ob_end_clean();
        } */
  }

  // Renders the response for the exception.
  /* IResponse render() {
        /* auto myException = _exception;
        code = getHttpCode(myException);
        method = methodName(myException);
        myTemplate = templateName(myException, method, code);
        clearOutput();

        if (hasMethod(this, method)) {
            return _customMethod(method, myException);
        }

        auto myMessage = exceptionMessage(myException, code);
        auto myUrl = _controller.getRequest().getRequestTarget();
        auto response = _controller.getResponse();

        if (cast(DException)myException) {
            /** @psalm-suppress DeprecatedMethod * /
            foreach (/* (array) * /myException.responseHeader() as myKey: myValue) {
                response = response.withHeader(myKey, myValue);
            }
        }
        if (cast(HttpException)myException) {
            myException.getHeaders().byKeyValue.each!(kv => response = response.withHeader(kv.key, kv.value));
        }
        auto response = response.withStatus(code);
        auto viewVars = [
            "message": myMessage,
            "url": h(myUrl),
            "exception": myException,
            "code": code,
        ];

        auto serialize = ["message", "url", "code"];
        if (Configure.hasKey("debug")) {
            trace = /* (array) * /Debugger.formatTrace(myException.getTrace(), [
                "format": "array",
                "args": false,
            ]);
            origin = [
                "file": myException.getFile() ?: "null",
                "line": myException.getLine() ?: "null",
            ];
            // Traces don"t include the origin file/line.
            trace.unshift(origin);
            viewVars.set("trace", trace);
            viewVars += origin;
            serialize ~= "file";
            serialize ~= "line";
        }

        _controller.set(viewVars);
        _controller.viewBuilder().setOption("serialize", serialize);

        if (cast(DException)myException && Configure.hasKey("debug")) {
            _controller.set(myException.getAttributes());
        }
        _controller.setResponse(response);

        return _outputMessage(myTemplate); * /
        return null; 
    } */

  // Render a custom exception method/template.
  /* protected IResponse _customMethod(string methodToInvoke, Throwable myExceptionToRender) {
        /* myResult = this.{method}(myException);
        _shutdown();

        return !myResult.isString
            ? myResult
            : _controller.getResponse().withStringBody(myResult); * /
        return null; 
    } */

  // Get method name
  protected string methodName(Throwable myException) {
    /* [, baseClass] = moduleSplit(get_class(myException));

        if (subString(baseClass, -9) == "Exception") {
            baseClass = subString(baseClass, 0, -9);
        }

        // baseClass would be an empty string if the exception class is \Exception.
        _method = baseClass is null ? "exception500" : Inflector.variable(baseClass);

        return _method; */
    return null;
  }

  // Get exception message.
  protected string exceptionMessage(Throwable throwableException, int exceptionCode) {
    // auto myMessage = throwableException.message();

    /*         if (
            !Configure.read("debug") &&
            !(cast(HttpException)throwableException)
       ) {
            myMessage = exceptionCode < 500
                ? __d("uim", "Not Found")
                : __d("uim", "An Internal Exception Has Occurred.");
        } */

    // return myMessage;
    return null;
  }

  // Get template for rendering exception info.
  protected string templateName(Throwable throwableException, string methodName, int exceptionCode) {
    /*         if (cast(HttpException)throwableException || !Configure.read("debug")) {
            return _template = exceptionCode < 500 ? "exception400" : "exception500";
        }

        return cast(PDOException)throwableException
            ? "pdo_exception"
            : methodName; */

    return null;
  }

  // Gets the appropriate http status code for exception.
  protected int getHttpCode(Throwable throwableException) {
    /* return cast(HttpException)exception
            ? throwableException.code()
            : _exceptionHttpCodesgetInteger(get_class(throwableException), 500); */

    return 0;
  }

  // Generate the response using the controller object.
  /* protected IResponse _outputMessage(string templateName) {
        try {
            _controller.render(templateName);

            return _shutdown();
        } catch (MissingTemplateException miisngTemplateExecution) {
            attributes = miisngTemplateExecution.getAttributes();
            return cast(MissingLayoutException)miisngTemplateExecution  ||
                attributes.getString("file").has("exception500")
                ? _outputMessageSafe("exception500")
                : _outputMessage("exception500");
        } catch (MissingPluginException missngPluginExecution) {
            attributes = missngPluginExecution.getAttributes();
            if (attributes.hasKey("plugin") && attributes["plugin"] == _controller.getPlugin()) {
                _controller.setPlugin(null);
            }

            return _outputMessageSafe("exception500");
        } catch (Throwable throwable) {
            return _outputMessageSafe("exception500");
        }
    } */

  /**
     * A safer way to render exception messages, replaces all helpers, with basics
     * and doesn"t call component methods.
     */
  /* protected IResponse _outputMessageSafe(string templateToRender) {
        auto myBuilder = _controller.viewBuilder();
        myBuilder
            .setHelpers([], false)
            .setLayoutPath("")
            .setTemplatePath("Exception");
        view = _controller.createView("View");

        auto response = _controller.getResponse()
            .withType("html")
            .withStringBody(view.render(templateToRender, "exception"));
        _controller.setResponse(response);

        return response;
    } */

  /**
     * Run the shutdown events.
     *
     * Triggers the afterFilter and afterDispatch events.
     */
  /* protected IResponse _shutdown() {
        _controller.dispatchEvent("Controller.shutdown");

        return _controller.getResponse();
    } */

  // Returns an array that can be used to describe the internal state of this object.
  override Json[string] debugInfo(string[] showKeys = null, string[] hideKeys = null) {
    return super.debugInfo(showKeys, hideKeys)
      .set("exception", _exception.toJson)
      .set("request", _request.toJson)
      .set("controller", _controller.toJson)
      .set("template", _template)
      .set("method", method);
  }
}
