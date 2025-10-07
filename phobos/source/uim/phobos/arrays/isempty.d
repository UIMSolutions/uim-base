module uim.phobos.arrays.isempty;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

bool isEmpty(T)(T[] values) {
    return values.length == 0;
}
