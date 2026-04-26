import 'package:flutter/material.dart';
import 'package:apartmanyonet/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:apartmanyonet/core/router/app_routes.dart';
import 'package:apartmanyonet/core/theme/app_theme.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';

/// Persistent sidebar shell for all `/admin/*` routes.
///
/// The [child] parameter is the currently active admin page.
class AdminShell extends StatelessWidget {
  const AdminShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        children: [
          _AdminSidebar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _AdminSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotifier>();
    final location = GoRouterState.of(context).matchedLocation;

    return Container(
      width: 240,
      color: const Color(0xFF0F172A), // slate-900
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Logo ────────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.apartment,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ApartmanYönet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      'Admin Panel',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(color: Color(0xFF1E293B), height: 1),
          const SizedBox(height: 12),

          // ── Nav items ────────────────────────────────────────────────────────
          _NavItem(
            icon: Icons.dashboard_rounded,
            label: AppLocalizations.of(context)!.dashboard,
            route: AppRoutes.adminDashboard,
            currentLocation: location,
          ),
          _NavItem(
            icon: Icons.apartment_rounded,
            label: AppLocalizations.of(context)!.buildings,
            route: AppRoutes.adminBuildings,
            currentLocation: location,
          ),
          _NavItem(
            icon: Icons.account_balance_wallet_rounded,
            label: AppLocalizations.of(context)!.transactions,
            route: AppRoutes.adminTransactions,
            currentLocation: location,
          ),
          _NavItem(
            icon: Icons.assignment_rounded,
            label: AppLocalizations.of(context)!.contracts,
            route: AppRoutes.adminContracts,
            currentLocation: location,
          ),
          _NavItem(
            icon: Icons.confirmation_number_rounded,
            label: AppLocalizations.of(context)!.tickets,
            route: AppRoutes.adminTickets,
            currentLocation: location,
          ),
          _NavItem(
            icon: Icons.campaign_rounded,
            label: AppLocalizations.of(context)!.announcements,
            route: AppRoutes.adminAnnouncements,
            currentLocation: location,
          ),
          _NavItem(
            icon: Icons.groups_rounded,
            label: AppLocalizations.of(context)!.residents,
            route: AppRoutes.adminResidents,
            currentLocation: location,
          ),
          _NavItem(
            icon: Icons.person_rounded,
            label: AppLocalizations.of(context)!.owners,
            route: AppRoutes.adminOwners,
            currentLocation: location,
          ),

          const Spacer(),
          const Divider(color: Color(0xFF1E293B), height: 1),

          // ── User info + logout (clickable → opens profile)  ──────────────
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => context.go(AppRoutes.adminProfile),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        (auth.currentUser?.name?.isNotEmpty == true
                                ? auth.currentUser!.name![0]
                                : auth.currentUser?.email[0] ?? 'A')
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            auth.currentUser?.name ?? 'Admin',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            auth.currentUser?.email ?? '',
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Logout icon (separate tap target)
                    IconButton(
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Color(0xFF94A3B8),
                        size: 18,
                      ),
                      tooltip: AppLocalizations.of(context)!.logout,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      onPressed: () => context.read<AuthNotifier>().logout(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.currentLocation,
  });

  final IconData icon;
  final String label;
  final String route;
  final String currentLocation;

  bool get _isActive => currentLocation == route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Material(
        color: _isActive
            ? AppColors.primary.withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => context.go(route),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: _isActive
                      ? AppColors.primaryLight
                      : const Color(0xFF94A3B8),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: _isActive ? Colors.white : const Color(0xFF94A3B8),
                    fontSize: 13.5,
                    fontWeight: _isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
