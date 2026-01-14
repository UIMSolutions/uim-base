/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module apps.vibe.dms.domain.entities.document;

import std.datetime;
import std.uuid;

@safe:

/**
 * Document entity - Core domain model
 */
class Document {
  private UUID _id;
  private string _title;
  private string _content;
  private string _author;
  private string _fileName;
  private string _mimeType;
  private size_t _fileSize;
  private DocumentStatus _status;
  private SysTime _createdAt;
  private SysTime _updatedAt;
  private string[] _tags;
  private size_t _version;
  private UUID _folderId;

  this(string title, string content, string author, string fileName = "", string mimeType = "text/plain") {
    _id = randomUUID();
    _title = title;
    _content = content;
    _author = author;
    _fileName = fileName;
    _mimeType = mimeType;
    _status = DocumentStatus.Draft;
    _createdAt = Clock.currTime();
    _updatedAt = Clock.currTime();
    _version = 1;
  }

  // Getters
  UUID id() const { return _id; }
  string title() const { return _title; }
  string content() const { return _content; }
  string author() const { return _author; }
  string fileName() const { return _fileName; }
  string mimeType() const { return _mimeType; }
  size_t fileSize() const { return _fileSize; }
  DocumentStatus status() const { return _status; }
  SysTime createdAt() const { return _createdAt; }
  SysTime updatedAt() const { return _updatedAt; }
  string[] tags() const { return _tags.dup; }
  size_t version_() const { return _version; }
  UUID folderId() const { return _folderId; }

  // Business logic methods
  void updateContent(string newContent) {
    if (_status == DocumentStatus.Archived) {
      throw new Exception("Cannot update archived document");
    }
    _content = newContent;
    _updatedAt = Clock.currTime();
    _version++;
  }

  void updateTitle(string newTitle) {
    if (newTitle.length == 0) {
      throw new Exception("Title cannot be empty");
    }
    _title = newTitle;
    _updatedAt = Clock.currTime();
  }

  void setFileSize(size_t size) {
    _fileSize = size;
  }

  void moveTo(UUID folderId) {
    _folderId = folderId;
    _updatedAt = Clock.currTime();
  }

  void publish() {
    if (_status == DocumentStatus.Draft) {
      _status = DocumentStatus.Published;
      _updatedAt = Clock.currTime();
    }
  }

  void archive() {
    _status = DocumentStatus.Archived;
    _updatedAt = Clock.currTime();
  }

  void addTag(string tag) {
    if (!hasTag(tag)) {
      _tags ~= tag;
      _updatedAt = Clock.currTime();
    }
  }

  void removeTag(string tag) {
    import std.algorithm : remove;
    import std.array : array;
    _tags = _tags.remove!(t => t == tag).array;
    _updatedAt = Clock.currTime();
  }

  bool hasTag(string tag) const {
    import std.algorithm : canFind;
    return _tags.canFind(tag);
  }
}

enum DocumentStatus {
  Draft,
  Published,
  Archived
}