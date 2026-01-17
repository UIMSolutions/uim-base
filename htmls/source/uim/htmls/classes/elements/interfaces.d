
/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.htmls.classes.elements.interfaces;

import uim.htmls;

@safe:

interface IHtmlElement {
    // Getter / Setter for content
    string content();
    IHtmlElement content(string value);
}
