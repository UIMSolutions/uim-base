module uim.oop.patterns.repositories.helpers.factory;

import uim.oop;

mixin(ShowModule!());

@safe:
/**
 * Generic repository factory.
 */
class RepositoryFactory : UIMFactory!IRepository {
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
///
unittest {
  mixin(ShowTest!"Testing RepositoryFactory");

  class User {
    int id;
    string name;
  } 
  void testCreateInMemory() {
    auto repo = RepositoryFactory.createInMemory!(User, int)((u) => u.id);
    assert(repo !is null);
  }
  void testCreateWithSpecification() {
    auto repo = RepositoryFactory.createWithSpecification!(User, int)((u) => u.id);
    assert(repo !is null);
  
  }
} 

static this() {
  mixin(ShowInit!"Initializing RepositoryFactory module");

  
}
