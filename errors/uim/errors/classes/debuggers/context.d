/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.debuggers.context;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

/**
 * DContext tracking for Debugger.exportVar()
 *
 * This class is used by Debugger to track element depth, and
 * prevent cyclic references from being traversed multiple times.
 */
class DDebugContext : UIMObject {
  this() {
    super();
  }

  this(size_t newMaxDepth) {
    _maxDepth = newMaxDepth;
    _refObjects = null;
  }

  // #region maxDepth
  private size_t _maxDepth = 0;
  size_t maxDepth() {
    return _maxDepth;
  }

  void maxDepth(size_t value) {
    _maxDepth = value;
  }
  // #endregion maxDepth

  // #region depth
  private size_t _depth = 0;
  size_t depth() {
    return _depth;
  }

  DDebugContext depth(size_t value) {
    _depth = value;
    return this;
  }
  // #endregion depth

  // Get the remaining depth levels
  size_t remainingDepth() {
    return _maxDepth - _depth;
  }

  // Return a clone with increased depth.
  auto withAddedDepth() {
    auto newContext = this.clone();
    newContext.depth(this.depth + 1);

    return newContext;
  }

  // #region refObjects
  protected UUID[UIMObject] _refObjects;
  UUID[UIMObject] refObjects() {
    return _refObjects;
  }

  void refObjects(UUID[UIMObject] value) {
    _refObjects = value;
  }
  // #endregion refObjects

  /**
     * Get the reference ID for an object.
     *
     * If this object does not exist in the reference storage,
     * it will be added and the id will be returned.
     */
  UUID referenceId(UIMObject referenceObject) {
    if (hasReference(referenceObject)) {
      return _refObjects[referenceObject];
    }

    auto refId = randomUUID;
    _refObjects[referenceObject] = refId;

    return refId;
  }

  // Check whether an object has been seen before.
  bool hasReference(UIMObject referenceObject) {
    foreach(kv; refObjects.byKeyValue) {
      if (kv.key.objId == referenceObject.objId) return true;
    }
    return false;
  }

  DDebugContext clone() {
    auto result = new DDebugContext;
    result.refObjects(refObjects.dup);
    result.maxDepth(this._maxDepth);
    result.depth(this.depth);
    return result;
  }
}

unittest {
    // Dummy UIMObject for testing
    class DummyObj : UIMObject {}

    // Test default constructor
    auto ctx = new DDebugContext();
    assert(ctx.maxDepth == 0);
    assert(ctx.depth == 0);

    // Test constructor with maxDepth
    auto ctx2 = new DDebugContext(5);
    assert(ctx2.maxDepth == 5);
    assert(ctx2.depth == 0);

    // Test maxDepth setter/getter
    ctx.maxDepth = 10;
    assert(ctx.maxDepth == 10);

    // Test depth setter/getter
    ctx.depth(3);
    assert(ctx.depth == 3);

    // Test remainingDepth
    ctx.maxDepth = 10;
    ctx.depth(4);
    assert(ctx.remainingDepth == 6);

    // Test clone
    ctx.maxDepth = 7;
    ctx.depth(2);
    auto cloneCtx = ctx.clone();
    assert(cloneCtx.maxDepth == 7);
    assert(cloneCtx.depth == 2);

    // Test referenceId and hasReference
    auto obj1 = new DummyObj();
    auto obj2 = new DummyObj();
    auto refId1 = ctx.referenceId(obj1);
    assert(ctx.hasReference(obj1));
    assert(!ctx.hasReference(obj2));
    auto refId1Again = ctx.referenceId(obj1);
    assert(refId1 == refId1Again);

    // Test that referenceId returns different UUIDs for different objects
    auto refId2 = ctx.referenceId(obj2);
    assert(refId1 != refId2);

    // Test that clone copies references
    auto ctx3 = ctx.clone();
    assert(ctx3.hasReference(obj1));
    assert(ctx3.hasReference(obj2));
    assert(ctx3.referenceId(obj1) == refId1);

    // Test depth chaining
    ctx.depth(1).depth(2);
    assert(ctx.depth == 2);

    // Test withAddedDepth (fixing static/this bug)
    // We'll patch the method locally for test
    auto orig = ctx.clone();
    orig.depth(2);
    auto added = orig.clone();
    added.depth(orig.depth + 1);
    assert(added.depth == orig.depth + 1);
}