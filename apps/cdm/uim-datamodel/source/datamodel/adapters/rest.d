module datamodel.adapters.rest;

import vibe.vibe;
import std.json;
import std.exception;

/**
 * REST API adapter for interacting with external RESTful services.
 */
class RestAdapter {
    private string baseUrl;

    this(string baseUrl) {
        this.baseUrl = baseUrl;
    }

    /**
     * Sends a GET request to the specified endpoint and returns the response as JSON.
     */
    JsonValue get(string endpoint) {
        auto response = httpGet(baseUrl ~ endpoint);
        return parseJson(response.body);
    }

    /**
     * Sends a POST request to the specified endpoint with the given data and returns the response as JSON.
     */
    JsonValue post(string endpoint, JsonValue data) {
        auto response = httpPost(baseUrl ~ endpoint, data.toString());
        return parseJson(response.body);
    }

    /**
     * Sends a PUT request to the specified endpoint with the given data and returns the response as JSON.
     */
    JsonValue put(string endpoint, JsonValue data) {
        auto response = httpPut(baseUrl ~ endpoint, data.toString());
        return parseJson(response.body);
    }

    /**
     * Sends a DELETE request to the specified endpoint and returns the response as JSON.
     */
    JsonValue delete(string endpoint) {
        auto response = httpDelete(baseUrl ~ endpoint);
        return parseJson(response.body);
    }
}