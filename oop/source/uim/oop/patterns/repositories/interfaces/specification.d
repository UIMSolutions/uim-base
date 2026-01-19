module uim.oop.patterns.repositories.interfaces.specification;

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
