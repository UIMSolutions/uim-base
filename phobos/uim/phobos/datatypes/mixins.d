module uim.phobos.datatypes.mixins;

// #region hasFunctions
string HasFunctions(string plural, string singular, string keyType) {
  return `
    bool hasAll{plural}({keyType}[] keys) {
      return keys.all!(key => has{singular}(key));
    }

    bool hasAny{plural}({keyType}[] keys) {
      return keys.any!(key => has{singular}(key));
    }
  `
    .replace("{plural}", plural)
    .replace("{singular}", singular)
    .replace("{keyType}", keyType);
}

template HasFunctions(string plural, string singular, string keyType) {
  const char[] HasFunctions = hasFunctions(plural, singular, keyType);
}

unittest {
  // writeln("HasFunctions ->", hasMethods("Entries", "Entry", "string"));
}
// #endregion HasFunctions
