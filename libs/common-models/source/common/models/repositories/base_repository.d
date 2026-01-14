/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.repositories.base_repository;

import std.uuid;

@safe:

/**
 * Generic repository interface
 */
interface IRepository(T) {
  void save(T entity);
  T findById(UUID id);
  T[] findAll();
  void remove(UUID id);
  bool exists(UUID id);
  size_t count();
}

/**
 * Repository with specification pattern support
 */
interface ISpecification(T) {
  bool isSatisfiedBy(T entity);
}

interface IRepositoryWithSpec(T) : IRepository!T {
  T[] findBySpecification(ISpecification!T spec);
}