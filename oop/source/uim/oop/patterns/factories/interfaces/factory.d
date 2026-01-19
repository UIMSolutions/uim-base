module uim.oop.patterns.factories.interfaces.factory;

import uim.oop;

mixin(ShowModule!());

@safe:
/**
 * Factory interface for creating objects.
 */
interface IFactory(K, V) {
    /** 
     * Creates and returns an instance of type T.
     * 
     * Params:
     *     K key = The key associated with the object to be created.
     * 
     * Returns:
     *     An instance of type T.
     */
  V create(K key);  
}