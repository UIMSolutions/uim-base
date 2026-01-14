/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.validation.validator;

@safe:

/**
 * Validation result
 */
struct ValidationResult {
  private bool _isValid;
  private string[] _errors;

  this(bool isValid, string[] errors = []) {
    _isValid = isValid;
    _errors = errors;
  }

  bool isValid() const { return _isValid; }
  string[] errors() const { return _errors.dup; }

  void addError(string error) {
    _isValid = false;
    _errors ~= error;
  }
}

/**
 * Base validator interface
 */
interface IValidator(T) {
  ValidationResult validate(T entity);
}

/**
 * Validator builder for fluent validation
 */
class ValidatorBuilder(T) {
  private bool delegate(T) @safe[] _rules;
  private string[] _errorMessages;

  ValidatorBuilder!T addRule(bool delegate(T) @safe rule, string errorMessage) {
    _rules ~= rule;
    _errorMessages ~= errorMessage;
    return this;
  }

  ValidationResult validate(T entity) {
    auto result = ValidationResult(true);
    
    foreach (i, rule; _rules) {
      if (!rule(entity)) {
        result.addError(_errorMessages[i]);
      }
    }

    return result;
  }
}

/**
 * Common validation rules
 */
struct ValidationRules {
  static bool notEmpty(string value) {
    return value.length > 0;
  }

  static bool minLength(string value, size_t min) {
    return value.length >= min;
  }

  static bool maxLength(string value, size_t max) {
    return value.length <= max;
  }

  static bool isPositive(T)(T value) {
    return value > 0;
  }

  static bool inRange(T)(T value, T min, T max) {
    return value >= min && value <= max;
  }
}