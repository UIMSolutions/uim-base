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
 * In-memory repository implementation.
 * Stores entities in memory using their ID as key.
 */
class InMemoryRepository(T, ID) : IRepository!(T, ID) {
    private T[ID] _entities;
    private ID delegate(T) @safe _idExtractor;

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
     */
    void add(T entity) {
        auto id = _idExtractor(entity);
        _entities[id] = entity;
    }

    /**
     * Update an existing entity in the repository.
     */
    void update(T entity) {
        auto id = _idExtractor(entity);
        if (id in _entities) {
            _entities[id] = entity;
        }
    }

    /**
     * Remove an entity from the repository.
     */
    void remove(T entity) {
        auto id = _idExtractor(entity);
        _entities.remove(id);
    }

    /**
     * Remove an entity by its ID.
     */
    bool removeById(ID id) {
        if (id in _entities) {
            _entities.remove(id);
            return true;
        }
        return false;
    }

    /**
     * Find an entity by its ID.
     */
    T findById(ID id) {
        if (auto entity = id in _entities) {
            return *entity;
        }
        return T.init;
    }

    /**
     * Get all entities in the repository.
     */
    T[] findAll() {
        return _entities.values;
    }

    /**
     * Check if an entity with the given ID exists.
     */
    bool exists(ID id) {
        return (id in _entities) !is null;
    }

    /**
     * Get the total count of entities.
     */
    size_t count() {
        return _entities.length;
    }

    /**
     * Clear all entities from the repository.
     */
    void clear() {
        _entities.clear();
    }
}

/**
 * Repository with specification support.
 */
class SpecificationRepository(T, ID) : InMemoryRepository!(T, ID), ISpecificationRepository!(T, ID) {
    /**
     * Constructor.
     */
    this(ID delegate(T) @safe idExtractor) {
        super(idExtractor);
    }

    /**
     * Find entities that satisfy a specification.
     */
    T[] find(ISpecification!T spec) {
        import std.algorithm : filter;
        import std.array : array;
        
        return _entities.values.filter!(e => spec.isSatisfiedBy(e)).array;
    }

    /**
     * Find first entity that satisfies a specification.
     */
    T findOne(ISpecification!T spec) {
        foreach (entity; _entities.values) {
            if (spec.isSatisfiedBy(entity)) {
                return entity;
            }
        }
        return T.init;
    }

    /**
     * Count entities that satisfy a specification.
     */
    size_t count(ISpecification!T spec) {
        import std.algorithm : count, filter;
        
        return _entities.values.filter!(e => spec.isSatisfiedBy(e)).count;
    }
}

/**
 * Generic repository factory.
 */
class RepositoryFactory {
    /**
     * Create an in-memory repository.
     */
    static InMemoryRepository!(T, ID) createInMemory(T, ID)(ID delegate(T) @safe idExtractor) {
        return new InMemoryRepository!(T, ID)(idExtractor);
    }

    /**
     * Create a specification repository.
     */
    static SpecificationRepository!(T, ID) createWithSpecification(T, ID)(ID delegate(T) @safe idExtractor) {
        return new SpecificationRepository!(T, ID)(idExtractor);
    }
}

// Unit tests
unittest {
    mixin(ShowTest!"Testing InMemoryRepository");

    class User {
        int id;
        string name;
        int age;

        this(int id, string name, int age) {
            this.id = id;
            this.name = name;
            this.age = age;
        }
    }

    auto repo = new InMemoryRepository!(User, int)((User u) => u.id);

    // Test add
    auto user1 = new User(1, "Alice", 30);
    auto user2 = new User(2, "Bob", 25);
    repo.add(user1);
    repo.add(user2);
    assert(repo.count() == 2);

    // Test findById
    auto found = repo.findById(1);
    assert(found !is null);
    assert(found.name == "Alice");

    // Test exists
    assert(repo.exists(1));
    assert(repo.exists(2));
    assert(!repo.exists(999));

    // Test findAll
    auto all = repo.findAll();
    assert(all.length == 2);

    // Test update
    user1.name = "Alice Updated";
    repo.update(user1);
    auto updated = repo.findById(1);
    assert(updated.name == "Alice Updated");

    // Test removeById
    assert(repo.removeById(2));
    assert(repo.count() == 1);
    assert(!repo.exists(2));

    // Test remove
    repo.remove(user1);
    assert(repo.count() == 0);
    assert(!repo.exists(1));

    // Test clear
    repo.add(new User(3, "Charlie", 35));
    repo.add(new User(4, "Diana", 28));
    assert(repo.count() == 2);
    repo.clear();
    assert(repo.count() == 0);
}

unittest {
    mixin(ShowTest!"Testing SpecificationRepository");

    class Product {
        int id;
        string name;
        double price;

        this(int id, string name, double price) {
            this.id = id;
            this.name = name;
            this.price = price;
        }
    }

    // Price specification
    class PriceRangeSpec : ISpecification!Product {
        private double _min;
        private double _max;

        this(double min, double max) {
            _min = min;
            _max = max;
        }

        bool isSatisfiedBy(Product product) {
            return product.price >= _min && product.price <= _max;
        }
    }

    auto repo = new SpecificationRepository!(Product, int)((Product p) => p.id);

    // Add products
    repo.add(new Product(1, "Cheap Item", 10.0));
    repo.add(new Product(2, "Mid Item", 50.0));
    repo.add(new Product(3, "Expensive Item", 150.0));

    // Find products in price range
    auto midRange = new PriceRangeSpec(20.0, 100.0);
    auto results = repo.find(midRange);
    assert(results.length == 1);
    assert(results[0].name == "Mid Item");

    // Count products
    auto expensiveSpec = new PriceRangeSpec(100.0, 200.0);
    assert(repo.count(expensiveSpec) == 1);

    // Find one
    auto cheapSpec = new PriceRangeSpec(0.0, 20.0);
    auto cheap = repo.findOne(cheapSpec);
    assert(cheap !is null);
    assert(cheap.name == "Cheap Item");
}

unittest {
    mixin(ShowTest!"Testing RepositoryFactory");

    class Item {
        string id;
        string value;

        this(string id, string value) {
            this.id = id;
            this.value = value;
        }
    }

    auto repo = RepositoryFactory.createInMemory!Item((Item i) => i.id);
    repo.add(new Item("key1", "value1"));
    assert(repo.count() == 1);

    auto specRepo = RepositoryFactory.createWithSpecification!Item((Item i) => i.id);
    specRepo.add(new Item("key2", "value2"));
    assert(specRepo.count() == 1);
}
