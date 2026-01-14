import vibe.vibe;

void main()
{
    // Initialize the Vibe.d framework
    auto settings = new HTTPServerSettings;
    settings.port = 8080; // Set the port for the server

    // Start the server
    listenHTTP(settings, &handleRequest);

    // Run the event loop
    runEventLoop();
}

void handleRequest(HTTPServerRequest req, HTTPServerResponse res)
{
    // Handle incoming requests and send responses
    res.writeBody("Welcome to my Vibe.d application!", "text/plain");
}