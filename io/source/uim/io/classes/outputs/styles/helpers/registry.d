module uim.io.classes.outputs.styles.helpers.registry;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DStyleRegistry : DRegistry!DStyle {
}

auto StyleRegistry() {
  return DStyleRegistry.registration;
}

static this() {
  StyleRegistry
    .register("warning", Json([
      "text": Json("yellow"),
      "background": Json("red"),
      "bold": Json(true)
    ]))
    .register("info", Json([
      "text": Json("green")
    ]))
    .register("question", Json([
      "text": Json("magenta")
    ]));
}
