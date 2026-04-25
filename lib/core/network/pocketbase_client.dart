import 'package:pocketbase/pocketbase.dart';

/// Global singleton PocketBase service.
///
/// Use [PocketBaseService.instance] anywhere in the app.
/// The underlying [PocketBase] client is exposed as [pb].
class PocketBaseService {
  PocketBaseService._();

  static final PocketBaseService instance = PocketBaseService._();

  // ── Configuration ──────────────────────────────────────────────────────────

  static const String baseUrl = 'https://apartmanyonet.halilucel.net';

  // ── PocketBase client ──────────────────────────────────────────────────────

  /// The raw PocketBase client. Use this for all collection/API calls.
  ///
  /// The default [AuthStore] keeps the session in-memory.
  /// If you need persistence across browser reloads, replace with an
  /// [AsyncAuthStore] backed by `shared_preferences` or `localStorage`.
  final PocketBase pb = PocketBase(baseUrl);

  // ── Auth store shortcuts ───────────────────────────────────────────────────

  bool get isAuthenticated => pb.authStore.isValid;
  String? get authToken => pb.authStore.token;

  /// Builds the full URL for a file stored in PocketBase.
  ///
  /// [collectionId] – the PB collection ID (not name).
  /// [recordId]     – the record ID that owns the file.
  /// [filename]     – the filename returned by PocketBase.
  String fileUrl({
    required String collectionId,
    required String recordId,
    required String filename,
  }) => '$baseUrl/api/files/$collectionId/$recordId/$filename';
}
