import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/features/auth/auth_state.dart';
import 'package:apartmanyonet/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:apartmanyonet/features/auth/data/models/user_model.dart';

/// Manages the authentication lifecycle and exposes the current [AuthState].
///
/// Obtain via `context.read<AuthNotifier>()` or
/// `context.watch<AuthNotifier>().state`.
///
/// ## Quick role check
/// ```dart
/// final auth = context.watch<AuthNotifier>();
/// if (auth.role == UserRole.siteAdmin) { ... }
/// ```
///
/// ## Organisation-scoped queries
/// ```dart
/// final orgId = context.read<AuthNotifier>().organizationId;
/// ```
class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._dataSource) {
    _init();
  }

  final AuthRemoteDataSource _dataSource;

  // ── State ─────────────────────────────────────────────────────────────────

  AuthState _state = const AuthInitial();

  /// The current auth state. Listen to this for reactive UI updates.
  AuthState get state => _state;

  // ── Convenience getters ───────────────────────────────────────────────────

  /// `true` while a login / refresh operation is in progress.
  bool get isLoading => _state is AuthLoading;

  /// `true` when a user is authenticated.
  bool get isAuthenticated => _state is AuthAuthenticated;

  /// The authenticated user, or `null` when not logged in.
  UserModel? get currentUser => switch (_state) {
        AuthAuthenticated(:final user) => user,
        _ => null,
      };

  /// The current user's role, or `null` when not logged in.
  ///
  /// Possible values: [UserRole.superAdmin], [UserRole.siteAdmin],
  ///                  [UserRole.resident], [UserRole.owner].
  UserRole? get role => switch (_state) {
        AuthAuthenticated(:final role) => role,
        _ => null,
      };

  /// The current user's organisation ID, or `null` when not logged in.
  ///
  /// Scope every PocketBase list/view query to this ID.
  String? get organizationId => switch (_state) {
        AuthAuthenticated(:final organizationId) => organizationId,
        _ => null,
      };

  /// The last error message, or `null` if no error is active.
  String? get errorMessage => switch (_state) {
        AuthError(:final message) => message,
        _ => null,
      };

  // ── Public actions ────────────────────────────────────────────────────────

  /// Authenticate the user with [email] and [password].
  ///
  /// Sets state to [AuthLoading] → [AuthAuthenticated] on success
  /// or [AuthError] on failure.
  Future<void> login(String email, String password) async {
    _set(const AuthLoading());
    try {
      final auth = await _dataSource.login(email, password);
      _handleAuthRecord(auth.record);
    } on ClientException catch (e) {
      _set(AuthError(_extractMessage(e)));
    } catch (e) {
      _set(AuthError(e.toString()));
    }
  }

  /// Log out the current user and clear all local auth state.
  Future<void> logout() async {
    _dataSource.logout();
    _set(const AuthUnauthenticated());
  }

  /// Dismiss the current error and return to [AuthUnauthenticated].
  void clearError() {
    if (_state is AuthError) _set(const AuthUnauthenticated());
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  /// Called once in the constructor to restore a previous session.
  Future<void> _init() async {
    if (_dataSource.isAuthStoreValid) {
      await _refresh();
    } else {
      _set(const AuthUnauthenticated());
    }
  }

  /// Attempt to silently refresh the stored token.
  Future<void> _refresh() async {
    try {
      final auth = await _dataSource.refresh();
      _handleAuthRecord(auth.record);
    } catch (_) {
      // Token expired or invalid – force re-login.
      _dataSource.logout();
      _set(const AuthUnauthenticated());
    }
  }

  /// Parse a [RecordModel] returned by PocketBase into an [AuthAuthenticated]
  /// state – or an [AuthError] if the record is malformed.
  void _handleAuthRecord(RecordModel record) {
    try {
      // record.toJson() merges id + created + updated + all data fields.
      final user = UserModel.fromJson(record.toJson());

      _set(
        AuthAuthenticated(
          user: user,
          role: user.role,
          organizationId: user.organization,
        ),
      );
    } catch (e) {
      _set(AuthError('Could not parse user profile: $e'));
    }
  }

  void _set(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Extracts a human-readable message from a PocketBase [ClientException].
  String _extractMessage(ClientException e) {
    final raw = e.response['message'];
    if (raw is String && raw.isNotEmpty) return raw;
    return 'Authentication failed (HTTP ${e.statusCode}).';
  }
}
