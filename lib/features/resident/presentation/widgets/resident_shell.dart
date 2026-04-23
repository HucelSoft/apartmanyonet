import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:apartmanyonet/core/router/app_routes.dart';
import 'package:apartmanyonet/core/theme/app_theme.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';

/// Persistent sidebar shell for all `/resident/*` routes.
class ResidentShell extends StatelessWidget {
  const ResidentShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          _ResidentSidebar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ResidentSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotifier>();
    final location = GoRouterState.of(context).matchedLocation;

    return Container(
      width: 220,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE8EAED))),
      ),
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
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.home_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ApartmanYönet',
                      style: TextStyle(
                        color: Color(0xFF1A1A2E),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Resident Portal',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),
          const SizedBox(height: 12),

          // ── Nav items ────────────────────────────────────────────────────────
          _NavItem(
            icon: Icons.space_dashboard_rounded,
            label: 'Dashboard',
            route: AppRoutes.residentDashboard,
            currentLocation: location,
          ),
          _NavItem(
            icon: Icons.payments_rounded,
            label: 'Payments',
            route: AppRoutes.residentPayments,
            currentLocation: location,
          ),
          _NavItem(
            icon: Icons.build_circle_rounded,
            label: 'Tickets',
            route: AppRoutes.residentTickets,
            currentLocation: location,
          ),
          _NavItem(
            icon: Icons.speed_rounded,
            label: 'Meter Readings',
            route: AppRoutes.residentMeters,
            currentLocation: location,
          ),

          const Spacer(),
          const Divider(height: 1),

          // ── User info + logout ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: Text(
                    (auth.currentUser?.name?.isNotEmpty == true
                            ? auth.currentUser!.name![0]
                            : auth.currentUser?.email[0] ?? 'R')
                        .toUpperCase(),
                    style: TextStyle(
                      color: AppColors.primary,
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
                        auth.currentUser?.name ?? 'Resident',
                        style: const TextStyle(
                          color: Color(0xFF1A1A2E),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        auth.currentUser?.email ?? '',
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 11,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout_rounded,
                      color: Color(0xFF94A3B8), size: 18),
                  tooltip: 'Logout',
                  onPressed: () => context.read<AuthNotifier>().logout(),
                ),
              ],
            ),
          ),
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
            ? AppColors.primary.withValues(alpha: 0.08)
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
                      ? AppColors.primary
                      : const Color(0xFF94A3B8),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: _isActive
                        ? AppColors.primary
                        : const Color(0xFF64748B),
                    fontSize: 13.5,
                    fontWeight:
                        _isActive ? FontWeight.w600 : FontWeight.normal,
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
