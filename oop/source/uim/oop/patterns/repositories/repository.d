/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.patterns.repositories.repository;

import uim.oop;

mixin(ShowModule!());

@safe:

/**
  * Abstract repository base class.
  * Provides common functionality for repository implementations.
  * Concrete repositories should inherit from this and implement abstract methods.
  */
abstract class UIMRepository(T, ID) : IRepository!(T, ID) {
  protected ID delegate(T) @safe _idExtractor;

  /**
     * Constructor.
     * Params:
     *   idExtractor = Function to extract ID from entity
     */
  this(ID delegate(T) @safe idExtractor) {
    _idExtractor = idExtractor;
  }

  /**
     * Add a new entity to the repository.
     * Must be implemented by concrete repositories.
     */
  abstract void add(T entity);

  /**
     * Update an existing entity in the repository.
     * Must be implemented by concrete repositories.
     */
  abstract void update(T entity);

  /**
     * Remove an entity from the repository.
     * Must be implemented by concrete repositories.
     */
  abstract void remove(T entity);

  /**
     * Remove an entity by its ID.
     * Must be implemented by concrete repositories.
     */
  abstract bool removeById(ID id);

  /**
     * Find an entity by its ID.
     * Returns: The entity or T.init if not found
     * Must be implemented by concrete repositories.
     */
  abstract T findById(ID id);

  /**
     * Get all entities in the repository.
     * Must be implemented by concrete repositories.
     */
  abstract T[] findAll();

  /**
     * Check if an entity with the given ID exists.
     * Must be implemented by concrete repositories.
     */
  abstract bool exists(ID id);

  /**
     * Get the total count of entities.
     * Must be implemented by concrete repositories.
     */
  abstract size_t count();

  /**
     * Clear all entities from the repository.
     * Must be implemented by concrete repositories.
     */
  abstract void clear();

  /**
     * Extract ID from an entity using the configured extractor.
     * Params:
     *   entity = The entity to extract ID from
     * Returns: The entity's ID
     */
  protected ID extractId(T entity) {
    return _idExtractor(entity);
  }

  /**
     * Validate entity before add/update operations.
     * Default implementation does nothing.
     * Override in concrete repositories to add validation logic.
     * Params:
     *   entity = The entity to validate
     * Returns: true if valid, false otherwise
     */
  protected bool validateEntity(T entity) {
    return true;
  }

  /**
     * Hook called before adding an entity.
     * Default implementation does nothing.
     * Override in concrete repositories to add custom logic.
     * Params:
     *   entity = The entity about to be added
     */
  protected void beforeAdd(T entity) {
    // Default: no-op
  }

  /**
     * Hook called after adding an entity.
     * Default implementation does nothing.
     * Override in concrete repositories to add custom logic.
     * Params:
     *   entity = The entity that was added
     */
  protected void afterAdd(T entity) {
    // Default: no-op
  }

  /**
     * Hook called before updating an entity.
     * Default implementation does nothing.
     * Override in concrete repositories to add custom logic.
     * Params:
     *   entity = The entity about to be updated
     */
  protected void beforeUpdate(T entity) {
    // Default: no-op
  }

  /**
     * Hook called after updating an entity.
     * Default implementation does nothing.
     * Override in concrete repositories to add custom logic.
     * Params:
     *   entity = The entity that was updated
     */
  protected void afterUpdate(T entity) {
    // Default: no-op
  }

  /**
     * Hook called before removing an entity.
     * Default implementation does nothing.
     * Override in concrete repositories to add custom logic.
     * Params:
     *   entity = The entity about to be removed
     */
  protected void beforeRemove(T entity) {
    // Default: no-op
  }

  /**
     * Hook called after removing an entity.
     * Default implementation does nothing.
     * Override in concrete repositories to add custom logic.
     * Params:
     *   entity = The entity that was removed
     */
  protected void afterRemove(T entity) {
    // Default: no-op
  }
}

/**
 * Abstract specification repository with specification pattern support.
 * Extends AbstractRepository with specification querying capabilities.
 */
abstract class AbstractSpecificationRepository(T, ID) : AbstractRepository!(T, ID), ISpecificationRepository!(
  T, ID) {
  /**
     * Constructor.
     * Params:
     *   idExtractor = Function to extract ID from entity
     */
  this(ID delegate(T) @safe idExtractor) {
    super(idExtractor);
  }

  /**
     * Find entities that satisfy a specification.
     * Default implementation iterates through all entities.
     * Override for more efficient implementation.
     */
  T[] find(ISpecification!T spec) {
    import std.algorithm : filter;
    import std.array : array;

    return findAll().filter!(e => spec.isSatisfiedBy(e)).array;
  }

  /**
     * Find first entity that satisfies a specification.
     * Default implementation iterates through all entities.
     * Override for more efficient implementation.
     */
  T findOne(ISpecification!T spec) {
    foreach (entity; findAll()) {
      if (spec.isSatisfiedBy(entity)) {
        return entity;
      }
    }
    return T.init;
  }

  /**
     * Count entities that satisfy a specification.
     * Default implementation iterates through all entities.
     * Override for more efficient implementation.
     */
  size_t count(ISpecification!T spec) {
    import std.algorithm : count, filter;

    return findAll().filter!(e => spec.isSatisfiedBy(e)).count;
  }
}
