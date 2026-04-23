/// Typed route path constants for the entire application.
///
/// Always use these constants instead of raw strings to prevent typos
/// and make refactoring safe.
abstract final class AppRoutes {
  // ── Public / unauthenticated ───────────────────────────────────────────────
  static const String login = '/login';

  // ── Admin branch ───────────────────────────────────────────────────────────
  /// Root of the admin branch; redirects to [adminDashboard].
  static const String admin = '/admin';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminBuildings = '/admin/buildings';
  static const String adminTransactions = '/admin/transactions';
  static const String adminTickets = '/admin/tickets';
  static const String adminAnnouncements = '/admin/announcements';

  // ── Resident branch ────────────────────────────────────────────────────────
  /// Root of the resident branch; redirects to [residentDashboard].
  static const String resident = '/resident';
  static const String residentDashboard = '/resident/dashboard';
  static const String residentPayments = '/resident/payments';
  static const String residentTickets = '/resident/tickets';
  static const String residentMeters = '/resident/meters';
}
