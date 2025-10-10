/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.list;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

interface IList(T) {
  // Appends the specified element to the end of this list (optional operation).
  /* O add(this O)(T addItem);

  // Inserts the specified element at the specified position in this list (optional operation).
  bool add(size_t index, T addItem);

  // Appends all of the elements in the specified collection to the end of this list, in the order that they are returned by the specified collection's iterator (optional operation).
  // bool addAll(Collection!T addItems);

  bool addAll(T[] addItems); */
/* 
  // Inserts all of the elements in the specified collection into this list at the specified position (optional operation).
  bool addAll(int index, Collection!T addItems);
  bool addAll(int index, T[] addItems);
   /

  // Removes all of the elements from this list (optional operation).
  bool clear();

/* // Compares the specified object with this list for equality.
  bool equals(Object o);

  // Returns the hash code value for this list.
  int  hashCode(); */

  // Returns true if this list contains no elements. */
  bool isEmpty();

  /*// Returns an iterator over the elements in this list in proper sequence.
  Iterator<E>  iterator();
 */
  // Returns the index of the last occurrence of the specified element in this list, or -1 if this list does not contain the element.
  int  lastIndexOf(T checkItem);

/* // Returns a list iterator over the elements in this list (in proper sequence).
  ListIterator<E>  listIterator();

  // Returns a list iterator over the elements in this list (in proper sequence), starting at the specified position in the list.
  ListIterator<E>  listIterator(int index) */

/* // eplaces each element of this list with the result of applying the operator to that element.
  default void  replaceAll(UnaryOperator<E> operator); */

  // Retains only the elements in this list that are contained in the specified collection (optional operation).
  bool retainAll(Collection!T retainItems);

  bool retainAll(T[] retainItems);

  // Replaces the element at the specified position in this list with the specified element (optional operation).
  /* E  set(int index, E element);*/

  // Returns the number of elements in this list.
  size_t  size(); 

/* // Sorts this list according to the order induced by the specified Comparator.
  default void  sort(Comparator<? super E> c);

  // Creates a Spliterator over the elements in this list.
  default Spliterator<E>  spliterator(); */

/* // Returns a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive.
  List<E>  subList(int fromIndex, int toIndex); */

  // Returns an array containing all of the elements in this list in proper sequence (from first to last element).
 /* T[]  toArray(); */
}