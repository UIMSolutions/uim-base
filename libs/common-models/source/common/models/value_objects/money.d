/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.value_objects.money;

import std.format;

@safe:

/**
 * Money value object with currency
 */
struct Money {
  private long _amount; // Amount in cents/smallest unit
  private string _currency;

  this(long amount, string currency = "USD") {
    _amount = amount;
    _currency = currency;
  }

  this(double amount, string currency = "USD") {
    _amount = cast(long)(amount * 100);
    _currency = currency;
  }

  long amount() const { return _amount; }
  double amountDecimal() const { return _amount / 100.0; }
  string currency() const { return _currency; }

  Money opBinary(string op)(Money rhs) const {
    static if (op == "+") {
      if (_currency != rhs._currency) {
        throw new Exception("Cannot add different currencies");
      }
      return Money(_amount + rhs._amount, _currency);
    } else static if (op == "-") {
      if (_currency != rhs._currency) {
        throw new Exception("Cannot subtract different currencies");
      }
      return Money(_amount - rhs._amount, _currency);
    }
  }

  Money opBinary(string op)(double multiplier) const {
    static if (op == "*") {
      return Money(cast(long)(_amount * multiplier), _currency);
    } else static if (op == "/") {
      return Money(cast(long)(_amount / multiplier), _currency);
    }
  }

  string toString() const {
    return format("%.2f %s", amountDecimal(), _currency);
  }
}