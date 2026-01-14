module routes;

import vibe.vibe;
import controllers;

void registerRoutes() {
    // Define the routing logic here
    route("/example", &ExampleController.handleExample);
    // Add more routes as needed
}