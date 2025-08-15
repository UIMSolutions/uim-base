module uim.io.classes.outputs.styles.style;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DOutputStyle : UIMObject, IOutputStyle {
    this() {
        super();
    }

    abstract string render(string text);
}