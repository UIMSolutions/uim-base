module uim.oop.validators.helpers.functions;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool isValidator(Object obj) {
  if (obj is null) {
    return false;
  }
  return cast(IValidator)obj;
}