module uim.oop.patterns.mediators.interfaces;

/**
 * Mediator interface defines communication between colleague objects.
 */
interface IMediator {
    /**
     * Notifies the mediator about an event from a colleague.
     * Params:
     *   sender = The colleague object sending the notification
     *   event = The event identifier
     */
    void notify(IColleague sender, string event) @safe;
}

/**
 * Colleague interface for objects that communicate through a mediator.
 */
interface IColleague {
    /**
     * Sets the mediator for this colleague.
     * Params:
     *   mediator = The mediator instance
     */
    void mediator(IMediator mediator) @safe;
    
    /**
     * Gets the current mediator.
     * Returns: The mediator instance
     */
    IMediator mediator() @safe;
}

/**
 * Generic mediator interface with typed messages.
 */
interface IGenericMediator(TMessage) {
    /**
     * Sends a typed message through the mediator.
     * Params:
     *   sender = The sender identifier
     *   message = The message to send
     */
    void send(string sender, TMessage message) @safe;
    
    /**
     * Registers a receiver for messages.
     * Params:
     *   receiver = The receiver identifier
     *   handler = The message handler callback
     */
    void register(string receiver, void delegate(string sender, TMessage message) @safe handler) @safe;
    
    /**
     * Unregisters a receiver.
     * Params:
     *   receiver = The receiver identifier
     */
    void unregister(string receiver) @safe;
}

/**
 * Event-based mediator interface.
 */
interface IEventMediator {
    /**
     * Subscribes to an event.
     * Params:
     *   eventName = The event name
     *   handler = The event handler
     */
    void subscribe(string eventName, void delegate(string eventData) @safe handler) @safe;
    
    /**
     * Unsubscribes from an event.
     * Params:
     *   eventName = The event name
     *   handler = The event handler to remove
     */
    void unsubscribe(string eventName, void delegate(string eventData) @safe handler) @safe;
    
    /**
     * Publishes an event.
     * Params:
     *   eventName = The event name
     *   eventData = The event data
     */
    void publish(string eventName, string eventData) @safe;
}

/**
 * Request-response mediator interface.
 */
interface IRequestResponseMediator {
    /**
     * Sends a request and waits for a response.
     * Params:
     *   requestType = The type of request
     *   requestData = The request data
     * Returns: The response data
     */
    string request(string requestType, string requestData) @safe;
    
    /**
     * Registers a request handler.
     * Params:
     *   requestType = The type of request to handle
     *   handler = The request handler
     */
    void registerHandler(string requestType, string delegate(string requestData) @safe handler) @safe;
}

/**
 * Component interface for mediator-managed components.
 */
interface IMediatorComponent {
    /**
     * Gets the component name.
     * Returns: The component identifier
     */
    string name() const @safe;
    
    /**
     * Sends a message through the component's mediator.
     * Params:
     *   message = The message to send
     */
    void send(string message) @safe;
    
    /**
     * Receives a message from the mediator.
     * Params:
     *   sender = The sender name
     *   message = The message content
     */
    void receive(string sender, string message) @safe;
}
