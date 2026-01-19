/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.patterns.decorators.interfaces;

import uim.oop;

mixin(ShowModule!());

@safe:

/**
 * Base component interface for the Decorator pattern.
 * Components can be decorated with additional behavior.
 */
interface IDecoratorComponent {
  /**
   * Execute the component's operation.
   * Returns: Result of the operation
   */
  string execute();
}

/**
 * Decorator interface that wraps a component.
 */
interface IDecorator : IDecoratorComponent {
  /**
   * Get the wrapped component.
   * Returns: The component being decorated
   */
  IDecoratorComponent component();

  /**
   * Set the wrapped component.
   * Params:
   *   comp = The component to wrap
   */
  void component(IDecoratorComponent comp);
}

/**
 * Generic decorator interface for type-safe decoration.
 */
interface IGenericDecorator(T) {
  /**
   * Get the wrapped object.
   * Returns: The object being decorated
   */
  T wrappedObject();

  /**
   * Set the wrapped object.
   * Params:
   *   obj = The object to wrap
   */
  void wrappedObject(T obj);
}

/**
 * Interface for decorators that can be chained.
 */
interface IChainableDecorator : IDecorator {
  /**
   * Add another decorator to the chain.
   * Params:
   *   decorator = The decorator to add
   * Returns: The decorator chain
   */
  IChainableDecorator addDecorator(IDecorator decorator);

  /**
   * Get the number of decorators in the chain.
   * Returns: The chain length
   */
  size_t chainLength();
}
