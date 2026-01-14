/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.pagination.pageable;

@safe:

/**
 * Pagination request
 */
struct Pageable {
  private size_t _page;
  private size_t _size;
  private string _sortBy;
  private SortDirection _sortDirection;

  this(size_t page, size_t size, string sortBy = "", SortDirection direction = SortDirection.Ascending) {
    _page = page;
    _size = size;
    _sortBy = sortBy;
    _sortDirection = direction;
  }

  size_t page() const { return _page; }
  size_t size() const { return _size; }
  size_t offset() const { return _page * _size; }
  string sortBy() const { return _sortBy; }
  SortDirection sortDirection() const { return _sortDirection; }
}

enum SortDirection {
  Ascending,
  Descending
}

/**
 * Paginated result
 */
struct Page(T) {
  private T[] _content;
  private size_t _totalElements;
  private size_t _totalPages;
  private size_t _currentPage;
  private size_t _pageSize;

  this(T[] content, size_t totalElements, size_t currentPage, size_t pageSize) {
    _content = content;
    _totalElements = totalElements;
    _currentPage = currentPage;
    _pageSize = pageSize;
    _totalPages = (totalElements + pageSize - 1) / pageSize;
  }

  T[] content() const { return _content.dup; }
  size_t totalElements() const { return _totalElements; }
  size_t totalPages() const { return _totalPages; }
  size_t currentPage() const { return _currentPage; }
  size_t pageSize() const { return _pageSize; }
  bool hasNext() const { return _currentPage < _totalPages - 1; }
  bool hasPrevious() const { return _currentPage > 0; }
}