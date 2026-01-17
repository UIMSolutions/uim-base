module uim.htmls.classes.element;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// Base class for all HTML elements
class DHtmlElement {
    protected string _tagName;
    protected string _content;
    protected bool _selfClosing;

    // Getter for tagName
    string tagName() { return _tagName; }
    
    // Setter for tagName
    auto tagName(string value) { _tagName = value; return this; }
    
    // Getter for content
    string content() { return _content; }
    
    // Setter for content
    auto content(string value) { _content = value; return this; }
    
    // Getter for selfClosing
    bool selfClosing() { return _selfClosing; }
    
    // Setter for selfClosing
    auto selfClosing(bool value) { _selfClosing = value; return this; }

    protected DHtmlAttribute[string] _attributes;
    protected DHtmlElement[] _children;

    this() {
        super();
        _selfClosing = false;
    }

    this(string tag) {
        this();
        this.tagName(tag);
    }

    /// Add an attribute to the element
    auto attribute(string name, string value) {
        _attributes[name] = new DHtmlAttribute(name, value);
        return this;
    }

    /// Get an attribute by name
    DHtmlAttribute attribute(string name) {
        return _attributes.get(name, null);
    }

    /// Set or get ID attribute
    auto id(string value) {
        return attribute("id", value);
    }

    string id() {
        auto attr = attribute("id");
        return attr ? attr.value : null;
    }

    /// Add CSS class
    auto addClass(string className) {
        auto classAttr = attribute("class");
        if (classAttr) {
            classAttr.value(classAttr.value ~ " " ~ className);
        } else {
            attribute("class", className);
        }
        return this;
    }

    /// Set style attribute
    auto style(string styleValue) {
        return attribute("style", styleValue);
    }

    /// Add a child element
    auto addChild(DHtmlElement child) {
        _children ~= child;
        return this;
    }

    /// Add multiple children
    auto addChildren(DHtmlElement[] children...) {
        foreach (child; children) {
            addChild(child);
        }
        return this;
    }

    /// Get children array
    DHtmlElement[] children() {
        return _children;
    }

    /// Set text content
    auto text(string textContent) {
        _content = textContent;
        return this;
    }

    /// Get attributes as string
    protected string attributesString() {
        import std.array : join;
        import std.algorithm : map;

        if (_attributes.length == 0) return "";
        
        string[] attrStrings;
        foreach (attr; _attributes.values) {
            attrStrings ~= attr.toString();
        }
        return " " ~ attrStrings.join(" ");
    }

    /// Convert element to HTML string
    override string toString() {
        string html = "<" ~ _tagName ~ attributesString();

        if (_selfClosing) {
            return html ~ " />";
        }

        html ~= ">";

        // Add content
        if (_content.length > 0) {
            html ~= _content;
        }

        // Add children
        foreach (child; _children) {
            html ~= child.toString();
        }

        html ~= "</" ~ _tagName ~ ">";
        return html;
    }

    /// Create a new element
    static DHtmlElement create(string tag) {
        return new DHtmlElement(tag);
    }
}

auto HtmlElement(string tag) { return new DHtmlElement(tag); }

unittest {
    auto div = HtmlElement("div");
    div.id("test").addClass("container");
    assert(div.id == "test");
}
