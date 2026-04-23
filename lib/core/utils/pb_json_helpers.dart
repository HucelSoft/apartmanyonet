// Utility functions for serialising/deserialising PocketBase JSON payloads.
//
// PocketBase quirks handled here:
// - Dates come as `"YYYY-MM-DD HH:mm:ss.SSSZ"` (space separator, not `T`).
// - Empty string `""` represents a null optional date.
// - Relation fields are returned as a plain [String] ID **or** as an expanded
//   [Map] record when the query uses `?expand=field`.

// ---------------------------------------------------------------------------
// Date helpers
// ---------------------------------------------------------------------------

/// Parses a required PocketBase date string to [DateTime].
/// Falls back to [DateTime.now()] for null/empty (should not happen for
/// server-set `created` / `updated` auto-date fields).
DateTime parsePbDate(dynamic value) => parsePbDateNullable(value) ?? DateTime.now();

/// Parses an optional PocketBase date string to [DateTime?].
/// Returns `null` for `null` or empty-string values.
DateTime? parsePbDateNullable(dynamic value) {
  if (value == null) return null;
  final str = value.toString();
  if (str.isEmpty) return null;
  try {
    // PocketBase uses a space separator; DateTime.parse requires 'T'.
    return DateTime.parse(str.contains('T') ? str : str.replaceFirst(' ', 'T'));
  } catch (_) {
    return null;
  }
}

/// Serialises a [DateTime] to UTC ISO-8601 string.
String formatPbDate(DateTime dt) => dt.toUtc().toIso8601String();

/// Serialises a nullable [DateTime] to UTC ISO-8601 string or `null`.
String? formatPbDateNullable(DateTime? dt) => dt?.toUtc().toIso8601String();

// ---------------------------------------------------------------------------
// Relation helpers
// ---------------------------------------------------------------------------

/// Extracts the record ID from a PocketBase relation field.
///
/// PocketBase returns:
/// - A [String] (plain record ID) when the relation is **not** expanded.
/// - A [Map] (full record object) when using `?expand=fieldName`.
String parseRelationId(dynamic value) {
  if (value is String) return value;
  if (value is Map<String, dynamic>) return (value['id'] as String?) ?? '';
  return '';
}

/// Like [parseRelationId] but returns `null` for `null` / empty values.
String? parseRelationIdNullable(dynamic value) {
  if (value == null) return null;
  if (value is String) return value.isEmpty ? null : value;
  if (value is Map<String, dynamic>) return value['id'] as String?;
  return null;
}
