import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/router/app_routes.dart';
import 'package:apartmanyonet/features/admin/presentation/pages/admin_announcements_page.dart';
import 'package:apartmanyonet/features/admin/presentation/pages/admin_buildings_page.dart';
import 'package:apartmanyonet/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:apartmanyonet/features/admin/presentation/pages/admin_tickets_page.dart';
import 'package:apartmanyonet/features/admin/presentation/pages/admin_transactions_page.dart';
import 'package:apartmanyonet/features/admin/presentation/widgets/admin_shell.dart';
import 'package:apartmanyonet/features/auth/auth_state.dart';
import 'package:apartmanyonet/features/auth/presentation/pages/login_page.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';
import 'package:apartmanyonet/features/resident/presentation/pages/resident_dashboard_page.dart';
import 'package:apartmanyonet/features/resident/presentation/pages/resident_meters_page.dart';
import 'package:apartmanyonet/features/resident/presentation/pages/resident_payments_page.dart';
import 'package:apartmanyonet/features/resident/presentation/pages/resident_tickets_page.dart';
import 'package:apartmanyonet/features/resident/presentation/widgets/resident_shell.dart';

/// Builds and owns the [GoRouter] for the app.
///
/// Accepts [AuthNotifier] at construction time so the router can:
/// - Use it as `refreshListenable` → routes are re-evaluated on every auth
///   state change without any extra plumbing.
/// - Read the current role inside the redirect callback.
///
/// ## Typical usage in `main.dart`
/// ```dart
/// // Create once, store in State, never recreate.
/// _router = AppRouter(authNotifier: context.read<AuthNotifier>()).router;
/// ```
class AppRouter {
  AppRouter({required AuthNotifier authNotifier})
      : _authNotifier = authNotifier;

  final AuthNotifier _authNotifier;

  // Lazy-initialised so the router is only built once per [AppRouter] instance.
  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,

    /// Whenever [AuthNotifier] calls [notifyListeners()] (login, logout,
    /// token refresh) GoRouter runs [redirect] again automatically.
    refreshListenable: _authNotifier,

    redirect: _redirect,

    routes: [
      // ── Unauthenticated ───────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (_, _) => const LoginPage(),
      ),

      // ── Admin branch root (no shell – just redirects) ─────────────────────
      GoRoute(
        path: AppRoutes.admin,
        redirect: (_, _) => AppRoutes.adminDashboard,
      ),

      // ── Admin branch (wrapped in persistent sidebar shell) ────────────────
      ShellRoute(
        builder: (context, state, child) => AdminShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.adminDashboard,
            name: 'admin-dashboard',
            builder: (_, _) => const AdminDashboardPage(),
          ),
          GoRoute(
            path: AppRoutes.adminBuildings,
            name: 'admin-buildings',
            builder: (_, _) => const AdminBuildingsPage(),
          ),
          GoRoute(
            path: AppRoutes.adminTransactions,
            name: 'admin-transactions',
            builder: (_, _) => const AdminTransactionsPage(),
          ),
          GoRoute(
            path: AppRoutes.adminTickets,
            name: 'admin-tickets',
            builder: (_, _) => const AdminTicketsPage(),
          ),
          GoRoute(
            path: AppRoutes.adminAnnouncements,
            name: 'admin-announcements',
            builder: (_, _) => const AdminAnnouncementsPage(),
          ),
        ],
      ),

      // ── Resident branch root (no shell – just redirects) ──────────────────
      GoRoute(
        path: AppRoutes.resident,
        redirect: (_, _) => AppRoutes.residentDashboard,
      ),

      // ── Resident branch (wrapped in persistent sidebar shell) ─────────────
      ShellRoute(
        builder: (context, state, child) => ResidentShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.residentDashboard,
            name: 'resident-dashboard',
            builder: (_, _) => const ResidentDashboardPage(),
          ),
          GoRoute(
            path: AppRoutes.residentPayments,
            name: 'resident-payments',
            builder: (_, _) => const ResidentPaymentsPage(),
          ),
          GoRoute(
            path: AppRoutes.residentTickets,
            name: 'resident-tickets',
            builder: (_, _) => const ResidentTicketsPage(),
          ),
          GoRoute(
            path: AppRoutes.residentMeters,
            name: 'resident-meters',
            builder: (_, _) => const ResidentMetersPage(),
          ),
        ],
      ),
    ],
  );

  // ── Redirect guard ──────────────────────────────────────────────────────────
  //
  // Evaluation order:
  //   1. App initialising / auth check in progress → hold at /login
  //   2. Not authenticated                         → send to /login
  //   3. Authenticated + on /login                 → send to role dashboard
  //   4. Resident/Owner on an /admin route         → deny, send to /resident/dashboard
  //   5. Super/Site-admin on a /resident route     → deny, send to /admin/dashboard
  //   6. Everything else                           → no redirect (null)
  String? _redirect(BuildContext context, GoRouterState state) {
    final authState = _authNotifier.state;
    final location = state.matchedLocation;

    // ── 1. Auth still loading ─────────────────────────────────────────────────
    if (authState is AuthInitial || authState is AuthLoading) {
      // Stay on /login while we wait; everything else is redirected there.
      return location == AppRoutes.login ? null : AppRoutes.login;
    }

    if (authState is! AuthAuthenticated) return AppRoutes.login;
    final role = authState.role;

    // ── 3. Logged in but still on /login ──────────────────────────────────────
    if (location == AppRoutes.login) {
      return _homeForRole(role);
    }

    // ── 4. Resident / Owner cannot access admin routes ────────────────────────
    if (location.startsWith('/admin') &&
        (role == UserRole.resident || role == UserRole.owner)) {
      return AppRoutes.residentDashboard;
    }

    // ── 5. Admin roles cannot access resident routes ──────────────────────────
    if (location.startsWith('/resident') &&
        (role == UserRole.superAdmin || role == UserRole.siteAdmin)) {
      return AppRoutes.adminDashboard;
    }

    // ── 6. All good – no redirect ─────────────────────────────────────────────
    return null;
  }

  /// Returns the default landing route for a given [role].
  static String homeForRole(UserRole role) => _homeForRole(role);

  static String _homeForRole(UserRole role) => switch (role) {
        UserRole.superAdmin || UserRole.siteAdmin => AppRoutes.adminDashboard,
        UserRole.resident || UserRole.owner => AppRoutes.residentDashboard,
      };
}
