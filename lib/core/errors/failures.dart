/// Base class for all domain-level failures.
abstract class AppFailure {
  final String message;
  const AppFailure(this.message);

  @override
  String toString() => message;
}

/// Thrown when a network or PocketBase API call fails.
class ServerFailure extends AppFailure {
  const ServerFailure([super.message = 'A server error occurred.']);
}

/// Thrown when the user is not authenticated.
class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure([super.message = 'You are not authorized.']);
}

/// Thrown when a requested resource is not found.
class NotFoundFailure extends AppFailure {
  const NotFoundFailure([super.message = 'The resource was not found.']);
}

/// Thrown for validation errors.
class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message);
}
