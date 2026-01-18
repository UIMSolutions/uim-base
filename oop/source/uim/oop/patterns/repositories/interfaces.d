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
 * Repository interface for managing entities.
 * Provides CRUD operations and query capabilities.
 */
interface IRepository(T, ID) {
    /**
     * Add a new entity to the repository.
     */
    void add(T entity);

    /**
     * Update an existing entity in the repository.
     */
    void update(T entity);

    /**
     * Remove an entity from the repository.
     */
    void remove(T entity);

    /**
     * Remove an entity by its ID.
     */
    bool removeById(ID id);

    /**
     * Find an entity by its ID.
     * Returns: The entity or null if not found
     */
    T findById(ID id);

    /**
     * Get all entities in the repository.
     */
    T[] findAll();

    /**
     * Check if an entity with the given ID exists.
     */
    bool exists(ID id);

    /**
     * Get the total count of entities.
     */
    size_t count();

    /**
     * Clear all entities from the repository.
     */
    void clear();
}

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
interface ISpecificationRepository(T, ID) : IRepository!(T, ID) {
    /**
     * Find entities that satisfy a specification.
     */
    T[] find(ISpecification!T spec);

    /**
     * Find first entity that satisfies a specification.
     */
    T findOne(ISpecification!T spec);

    /**
     * Count entities that satisfy a specification.
     */
    size_t count(ISpecification!T spec);
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
