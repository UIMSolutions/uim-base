module uim.oop.patterns.repositories.memory;

import uim.oop;

mixin(ShowModule!());

@safe:
/**
 * In-memory repository implementation.
 * Stores entities in memory using their ID as key.
 */
class MemoryRepository(T, ID) : IRepository!(T, ID) {
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