/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.formatters.formatter;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

class DErrorFormatter : UIMObject, IErrorFormatter {
    mixin(ErrorFormatterThis!());

    string _breakTxt;
    string breakText() {
        return _breakTxt;
    }
    string breakText(size_t indentLevel) {
        return _breakTxt = "\n" ~ " ".repeatTxt(indentLevel);
    }

    string _endBreak;
    string endBreak() {
        return _endBreak;
    }
    string endBreak(size_t indentLevel) {
        return _endBreak = "\n" ~ " ".repeatTxt(indentLevel - 1);
    }

    // Convert a tree of IErrorNode objects into a plain text string.
    string dump(IErrorNode node) {
        return null;
    }

    // Convert a tree of IErrorNode objects into HTML
    protected string export_(IErrorNode nodeToDump, size_t indentLevel) {
        /*  if (cast(DArrayErrorNode) nodeToDump) {
            return exportArray(cast(DArrayErrorNode) nodeToDump, indentLevel + 1);
        }
        if (cast(DClassErrorNode) nodeToDump) {
            return exportClass(cast(DClassErrorNode) nodeToDump, indentLevel + 1);
        }
        if (cast(DReferenceErrorNode) nodeToDump) {
            return exportReference(cast(DReferenceErrorNode) nodeToDump, indentLevel + 1);
        }
        if (cast(DPropertyErrorNode) nodeToDump) {
            return exportProperty(cast(DPropertyErrorNode) nodeToDump, indentLevel + 1);
        }
        if (cast(DScalarErrorNode) nodeToDump) {
            return exportScalar(cast(DScalarErrorNode) nodeToDump, indentLevel + 1);
        }
        if (cast(DSpecialErrorNode) nodeToDump) {
            return exportSpecial(cast(DSpecialErrorNode) nodeToDump, indentLevel + 1);
        }
        throw new DInvalidArgumentError("Unknown node received " ~ nodeToDump.classname); */

        return null;
    }

    protected string exportArray(DArrayErrorNode tvar, size_t indentLevel) {
        breakText(indentLevel);
        endBreak(indentLevel);
        
        return null;
    }

    protected string exportReference(DReferenceErrorNode nodeToConvert, size_t indentLevel) {
        return null;
    }

    protected string exportClass(DClassErrorNode aNode, size_t indentLevel) {
        return null;
    }

    protected string exportProperty(DPropertyErrorNode node, size_t indentLevel) {
        return null;
    }

    protected string exportScalar(DScalarErrorNode node, size_t indentLevel) {
        return null;
    }

    protected string exportSpecial(DSpecialErrorNode node, size_t indentLevel) {
        return null;
    }
    // #endregion export
}
