import 'package:pocketbase/pocketbase.dart';

import 'package:apartmanyonet/features/auth/data/models/user_model.dart';

/// Low-level PocketBase calls for the authentication flow.
///
/// This class is intentionally thin – it only wraps PocketBase SDK calls
/// so that higher layers ([AuthNotifier]) can be tested independently.
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._pb);

  final PocketBase _pb;

  // ── Auth operations ────────────────────────────────────────────────────────

  /// Authenticate with email + password.
  ///
  /// Throws [ClientException] on invalid credentials or network errors.
  Future<RecordAuth> login(String email, String password) => _pb
      .collection(UserModel.collectionName)
      .authWithPassword(email, password);

  /// Refresh the current auth token using the stored credentials.
  ///
  /// Call this on app start when [isAuthStoreValid] is `true`.
  /// Throws [ClientException] if the session has expired.
  Future<RecordAuth> refresh() =>
      _pb.collection(UserModel.collectionName).authRefresh();

  /// Clear the local auth store (does not call PocketBase's server-side
  /// invalidation – add that call here if you need it).
  void logout() => _pb.authStore.clear();

  /// Whether the local auth store currently holds a (possibly expired) token.
  bool get isAuthStoreValid => _pb.authStore.isValid;
}
