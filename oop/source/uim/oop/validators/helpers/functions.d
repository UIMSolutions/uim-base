module uim.oop.validators.helpers.functions;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

bool isValidator(Object obj) {
  if (obj is null) {
    return false;
  }
  return cast(IValidator)obj;
}