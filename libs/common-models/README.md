# Common Models Library

A comprehensive library providing common data models, patterns, and utilities for D and vibe.d applications.

## Features

### Base Models

- **Identifiable**: UUID-based entity identification
- **Auditable**: Created/updated timestamps and user tracking
- **Versionable**: Optimistic locking with version control
- **SoftDeletable**: Soft delete functionality
- **BaseEntity**: Combines all base functionality

### Value Objects

- **Email**: Email validation and normalization
- **PhoneNumber**: Phone number formatting and validation
- **Money**: Currency-aware monetary values with arithmetic
- **Address**: Structured address representation

### Repository Pattern

- Generic repository interface
- Specification pattern support
- Pagination support

### Validation

- Fluent validation API
- Common validation rules
- ValidationResult with error tracking

### Serialization

- JSON serialization interface
- vibe.d integration

### Event System

- Domain events
- Event handlers
- Simple event bus

## Usage

### Basic Entity

```d
import common.models;

class User : BaseEntity {
  private string _username;
  private Email _email;

  this(string username, string email, string createdBy) {
    super();
    _username = username;
    _email = Email(email); // Validates email
    onCreate(createdBy);
  }

  void updateEmail(string newEmail, string userId) {
    _email = Email(newEmail);
    onUpdate(userId); // Updates version and audit info
  }
}
```

### Value Objects

```d
// Email with validation
auto email = Email("user@example.com");

// Money with currency
auto price = Money(99.99, "USD");
auto discounted = price * 0.8;

// Address
auto address = Address(
  "123 Main St",
  "New York",
  "NY",
  "10001",
  "USA"
);
```

### Validation

```d
auto validator = new ValidatorBuilder!User()
  .addRule(u => u.username.length >= 3, "Username too short")
  .addRule(u => !u.isDeleted, "User is deleted");

auto result = validator.validate(user);
if (!result.isValid) {
  foreach (error; result.errors) {
    writeln(error);
  }
}
```

### Pagination

```d
auto pageable = Pageable(0, 10, "username", SortDirection.Ascending);
auto page = Page!User(users, totalCount, 0, 10);

if (page.hasNext) {
  // Load next page
}
```

## Installation

Add to your `dub.json`:

```json
{
  "dependencies": {
    "common-models": "*"
  }
}
```

Or add to `dub.sdl`:

```
dependency "common-models" version="*"
```

## Building

```bash
dub build
```

## Running Examples

```bash
dub run common-models:examples
```

## License

Apache 2.0
