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

  string _breakText;
  string breakText() {
    return _breakText;
  }

  string breakText(size_t indentLevel) {
    return _breakText = "\n" ~ " ".repeatTxt(indentLevel);
  }

  string _endBreak;
  string endBreak() {
    return _endBreak;
  }

  string endBreak(size_t indentLevel) {
    return _endBreak = "\n" ~ " ".repeatTxt(indentLevel - 1);
  }

  // Convert a tree of IErrorNode objects into a plain text string.
  override string dump(IErrorNode node) {
    return export_(node, 0);
  }

  // Convert a tree of IErrorNode objects into HTML
  protected string export_(IErrorNode node, size_t indentLevel) {
    if (auto arrayNode = cast(DArrayErrorNode) node) {
      return exportArray(arrayNode, indentLevel + 1);
    }
    if (auto classNode = cast(DClassErrorNode) node) {
      return exportClass(classNode, indentLevel + 1);
    }
    if (auto referenceNode = cast(DReferenceErrorNode) node) {
      return exportReference(referenceNode, indentLevel + 1);
    }
    if (auto propertyNode = cast(DPropertyErrorNode) node) {
      return exportProperty(propertyNode, indentLevel + 1);
    }
    if (auto scalarNode = cast(DScalarErrorNode) node) {
      return exportScalar(scalarNode, indentLevel + 1);
    }
    if (auto specialNode = cast(DSpecialErrorNode) node) {
      return exportSpecial(specialNode, indentLevel + 1);
    }
    throw InvalidArgumentException("Unknown node received " ~ node.classname);
  }

  protected string exportArray(DArrayErrorNode node, size_t indentLevel) {
    breakText(indentLevel);
    endBreak(indentLevel);

    return null;
  }

  protected string exportArrayItem(IErrorNode node, size_t indentLevel) {
    return null;
  }

  protected string exportReference(DReferenceErrorNode nodeToConvert, size_t indentLevel) {
    return null;
  }

  protected string exportClass(DClassErrorNode node, size_t indentLevel) {
    breakText(indentLevel);
    endBreak(indentLevel);

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
