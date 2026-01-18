/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.patterns.repositories.interfaces;

import uim.oop;

mixin(ShowModule!());

@safe:


/**
 * Specification interface for querying repositories.
 * Used with Specification pattern for complex queries.
 */
interface ISpecification(T) {
  /**
     * Check if an entity satisfies the specification.
     */
  bool isSatisfiedBy(T entity);
}

/**
 * Extended repository interface with specification support.
 */
interface ISpecificationRepository(V, K) : IRepository!(K, V) {
  /**
     * Find entities that satisfy a specification.
     */
  V[] find(ISpecification!V spec);
  /**
     * Find first entity that satisfies a specification.
     */
  V findOne(ISpecification!V spec);
  /**
     * Count entities that satisfy a specification.
     */
  size_t count(ISpecification!V spec);
}

/**
 * Unit of Work interface for transactional operations.
 */
interface IUnitOfWork {
  /**
     * Commit all pending changes.
     */
  void commit();

  /**
     * Rollback all pending changes.
     */
  void rollback();

  /**
     * Check if there are pending changes.
     */
  bool hasChanges();
}
