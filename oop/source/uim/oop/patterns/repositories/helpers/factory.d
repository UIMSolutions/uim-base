module uim.oop.patterns.repositories.helpers.factory;

import uim.oop;

mixin(ShowModule!());

@safe:
/**
 * Generic repository factory.
 */
class RepositoryFactory {
  /**
     * Create an in-memory repository.
     */
  static MemoryRepository!(T, ID) createInMemory(T, ID)(ID delegate(T) @safe idExtractor) {
    return new MemoryRepository!(T, ID)(idExtractor);
  }

  /**
     * Create a specification repository.
     */
  static SpecificationRepository!(T, ID) createWithSpecification(T, ID)(
    ID delegate(T) @safe idExtractor) {
    return new SpecificationRepository!(T, ID)(idExtractor);
  }
}