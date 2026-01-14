# User Management Microservice

A RESTful microservice for user management built with vibe.d and D.

## Features

- User registration
- User authentication
- User profile management
- Role-based access control
- Clean Architecture design
- RESTful API

## API Endpoints

### Register User

```bash
POST /api/users/register
Content-Type: application/json

{
  "username": "johndoe",
  "email": "john@example.com",
  "password": "securepass123",
  "firstName": "John",
  "lastName": "Doe"
}
```

### Login

```bash
POST /api/users/login
Content-Type: application/json

{
  "username": "johndoe",
  "password": "securepass123"
}
```

### List Users

```bash
GET /api/users
GET /api/users?role=Admin
GET /api/users?status=Active
```

### Get User

```bash
GET /api/users/{id}
```

### Update User

```bash
PUT /api/users/{id}
Content-Type: application/json

{
  "firstName": "John",
  "lastName": "Smith",
  "email": "john.smith@example.com"
}
```

## Running the Service

```bash
cd apps/vibe/user-service
dub run
```

The service will start on `http://0.0.0.0:8081`

## Testing with curl

```bash
# Register a user
curl -X POST http://localhost:8081/api/users/register \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","email":"test@test.com","password":"password123","firstName":"Test","lastName":"User"}'

# Login
curl -X POST http://localhost:8081/api/users/login \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"password123"}'

# List users
curl http://localhost:8081/api/users

# Health check
curl http://localhost:8081/health
```

## Architecture

This microservice follows Clean Architecture principles:

- **Domain Layer**: Entities and repository interfaces
- **Application Layer**: Use cases with business logic
- **Infrastructure Layer**: Repository implementations and web controllers
- **Presentation Layer**: REST API endpoints

## Dependencies

- vibe.d: Web framework
- D standard library for UUID and datetime
