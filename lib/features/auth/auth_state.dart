import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/features/auth/data/models/user_model.dart';

// ── AuthState sealed class ────────────────────────────────────────────────────
//
// Use a `switch` on [AuthState] to handle all possible states:
//
//   switch (state) {
//     case AuthInitial()        => // show splash
//     case AuthLoading()        => // show spinner
//     case AuthAuthenticated()  => // show app
//     case AuthUnauthenticated()=> // show login
//     case AuthError()          => // show error
//   }
// ---------------------------------------------------------------------------

sealed class AuthState {
  const AuthState();
}

/// App is cold-starting; auth status not yet determined.
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// An async auth operation is in progress.
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// A user is logged in.
final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({
    required this.user,
    required this.role,
    required this.organizationId,
  });

  /// Full user record from PocketBase.
  final UserModel user;

  /// The user's role in the system.
  ///
  /// Use this to gate features:
  /// ```dart
  /// if (role == UserRole.siteAdmin) { ... }
  /// ```
  final UserRole role;

  /// The organisation this user belongs to.
  ///
  /// Every PocketBase query should be scoped to this ID.
  final String organizationId;
}

/// No user is logged in (or the user just logged out).
final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// An auth operation failed.
final class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;
}
