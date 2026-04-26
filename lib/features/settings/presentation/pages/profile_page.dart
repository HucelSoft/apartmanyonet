import 'package:flutter/material.dart';
import 'package:apartmanyonet/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/network/pocketbase_client.dart';
import 'package:apartmanyonet/core/theme/app_theme.dart';
import 'package:apartmanyonet/features/auth/data/models/user_model.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';
import 'package:apartmanyonet/features/settings/presentation/providers/preference_notifier.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────────────────────

/// Profile page – displays all [UserModel] fields and user preferences.
///
/// Accessible by clicking the user avatar / info area in the sidebar.
/// Rendered inside the admin [ShellRoute] so it keeps the sidebar visible.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotifier>();
    final prefs = context.watch<PreferenceNotifier>();
    final user = auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileHeader(user: user),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 36),
              child: user == null
                  ? const Center(child: CircularProgressIndicator())
                  : LayoutBuilder(
                      builder: (_, constraints) {
                        final isWide = constraints.maxWidth > 780;
                        return isWide
                            ? _WideLayout(user: user, prefs: prefs)
                            : _NarrowLayout(user: user, prefs: prefs);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header bar
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded, size: 20),
            color: const Color(0xFF64748B),
            tooltip: 'Back',
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.profile,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              const Text(
                'Account details & preferences',
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Layouts
// ─────────────────────────────────────────────────────────────────────────────

class _WideLayout extends StatelessWidget {
  const _WideLayout({required this.user, required this.prefs});
  final UserModel user;
  final PreferenceNotifier prefs;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column: avatar + user info
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _AvatarCard(user: user),
              const SizedBox(height: 20),
              _UserInfoCard(user: user),
            ],
          ),
        ),
        const SizedBox(width: 20),
        // Right column: preferences
        Expanded(
          flex: 2,
          child: _PreferencesCard(prefs: prefs),
        ),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({required this.user, required this.prefs});
  final UserModel user;
  final PreferenceNotifier prefs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AvatarCard(user: user),
        const SizedBox(height: 20),
        _UserInfoCard(user: user),
        const SizedBox(height: 20),
        _PreferencesCard(prefs: prefs),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Avatar & identity card
// ─────────────────────────────────────────────────────────────────────────────

class _AvatarCard extends StatelessWidget {
  const _AvatarCard({required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(user);
    final avatarUrl = (user.avatar?.isNotEmpty == true)
        ? PocketBaseService.instance.fileUrl(
            collectionId: UserModel.collectionName,
            recordId: user.id,
            filename: user.avatar!,
          )
        : null;

    return _Card(
      child: Column(
        children: [
          // Avatar circle
          Stack(
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: AppColors.primary,
                backgroundImage:
                    avatarUrl != null ? NetworkImage(avatarUrl) : null,
                child: avatarUrl == null
                    ? Text(
                        initials,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
              // Role badge on the avatar
              Positioned(
                bottom: 0,
                right: 0,
                child: _RoleBadgeSmall(role: user.role),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            user.name?.isNotEmpty == true ? user.name! : 'No name set',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),

          // Email
          Text(
            user.email,
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 12),

          // Role pill
          _RolePill(role: user.role),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 4),

          // Quick stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _QuickStat(label: 'Joined', value: _fmtDate(user.created)),
              const _VerticalDivider(),
              _QuickStat(
                label: 'Verified',
                value: user.verified ? 'Yes' : 'No',
                valueColor: user.verified
                    ? const Color(0xFF16A34A)
                    : const Color(0xFFD97706),
              ),
              const _VerticalDivider(),
              _QuickStat(
                label: 'Email Public',
                value: user.emailVisibility ? 'Yes' : 'No',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// User info card (all fields)
// ─────────────────────────────────────────────────────────────────────────────

class _UserInfoCard extends StatelessWidget {
  const _UserInfoCard({required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.person_outline_rounded,
            title: 'Account Information',
          ),
          const SizedBox(height: 16),

          _InfoRow(label: 'User ID', value: user.id, copiable: true),
          _InfoRow(label: 'Full Name', value: user.name ?? '—'),
          _InfoRow(label: 'Email', value: user.email, copiable: true),
          _InfoRow(
            label: 'Phone',
            value: user.phone?.isNotEmpty == true ? user.phone! : '—',
          ),
          _InfoRow(
            label: 'Role',
            valueWidget: _RolePill(role: user.role),
          ),
          _InfoRow(
            label: 'Organization ID',
            value: user.organization,
            copiable: true,
          ),
          _InfoRow(
            label: 'Email Visibility',
            value: user.emailVisibility ? 'Public' : 'Private',
          ),
          _InfoRow(
            label: 'Verified',
            value: user.verified ? 'Yes ✓' : 'No',
            valueColor: user.verified
                ? const Color(0xFF16A34A)
                : const Color(0xFFD97706),
          ),
          _InfoRow(label: 'Created', value: _fmtDatetime(user.created)),
          _InfoRow(label: 'Updated', value: _fmtDatetime(user.updated)),
          if (user.deleted != null)
            _InfoRow(
              label: 'Deleted',
              value: _fmtDatetime(user.deleted!),
              valueColor: const Color(0xFFDC2626),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Preferences card (theme + language)
// ─────────────────────────────────────────────────────────────────────────────

class _PreferencesCard extends StatelessWidget {
  const _PreferencesCard({required this.prefs});
  final PreferenceNotifier prefs;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.tune_rounded,
            title: 'Preferences',
          ),
          const SizedBox(height: 20),

          // ── Theme ───────────────────────────────────────────────────────────
          const Text(
            'Theme',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 10),
          _ThemeSelector(prefs: prefs),

          const SizedBox(height: 28),

          // ── Language ────────────────────────────────────────────────────────
          Text(
            AppLocalizations.of(context)!.language,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 10),
          _LanguageSelector(prefs: prefs),

          const SizedBox(height: 28),
          const Divider(),
          const SizedBox(height: 16),

          // ── Danger zone ─────────────────────────────────────────────────────
          _SectionTitle(
            icon: Icons.logout_rounded,
            title: AppLocalizations.of(context)!.logout,
            iconColor: const Color(0xFFDC2626),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _confirmLogout(context),
              icon: const Icon(Icons.logout_rounded, size: 16),
              label: Text(AppLocalizations.of(context)!.logout),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFDC2626),
                side: const BorderSide(color: Color(0xFFDC2626)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Sign out?'),
        content: const Text(
            'You will be returned to the login screen. Any unsaved work will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626)),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthNotifier>().logout();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Theme selector – 3 option cards
// ─────────────────────────────────────────────────────────────────────────────

class _ThemeSelector extends StatelessWidget {
  const _ThemeSelector({required this.prefs});
  final PreferenceNotifier prefs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ThemeOption(
          icon: Icons.wb_sunny_rounded,
          label: 'Light',
          mode: ThemeMode.light,
          current: prefs.themeMode,
          onTap: () => prefs.setThemeMode(ThemeMode.light),
        ),
        const SizedBox(width: 10),
        _ThemeOption(
          icon: Icons.nightlight_round,
          label: 'Dark',
          mode: ThemeMode.dark,
          current: prefs.themeMode,
          onTap: () => prefs.setThemeMode(ThemeMode.dark),
        ),
        const SizedBox(width: 10),
        _ThemeOption(
          icon: Icons.contrast_rounded,
          label: 'System',
          mode: ThemeMode.system,
          current: prefs.themeMode,
          onTap: () => prefs.setThemeMode(ThemeMode.system),
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.mode,
    required this.current,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final ThemeMode mode;
  final ThemeMode current;
  final VoidCallback onTap;

  bool get _selected => current == mode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: _selected
                ? AppColors.primary.withValues(alpha: 0.09)
                : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _selected ? AppColors.primary : const Color(0xFFE2E8F0),
              width: _selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 22,
                color:
                    _selected ? AppColors.primary : const Color(0xFF94A3B8),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      _selected ? FontWeight.w700 : FontWeight.normal,
                  color: _selected
                      ? AppColors.primary
                      : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Language selector
// ─────────────────────────────────────────────────────────────────────────────

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector({required this.prefs});
  final PreferenceNotifier prefs;

  List<({Locale locale, String flag, String label})> _options(
          BuildContext context) =>
      [
        (
          locale: const Locale('tr'),
          flag: '🇹🇷',
          label: AppLocalizations.of(context)!.turkish
        ),
        (
          locale: const Locale('en'),
          flag: '🇬🇧',
          label: AppLocalizations.of(context)!.english
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final opts = _options(context);
    return Column(
      children: opts
          .map(
            (opt) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => prefs.setLocale(opt.locale),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: prefs.locale == opt.locale
                        ? AppColors.primary.withValues(alpha: 0.07)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: prefs.locale == opt.locale
                          ? AppColors.primary
                          : const Color(0xFFE2E8F0),
                      width: prefs.locale == opt.locale ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(opt.flag, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Text(
                        opt.label,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: prefs.locale == opt.locale
                              ? FontWeight.w700
                              : FontWeight.normal,
                          color: prefs.locale == opt.locale
                              ? AppColors.primary
                              : const Color(0xFF334155),
                        ),
                      ),
                      const Spacer(),
                      if (prefs.locale == opt.locale)
                        Icon(Icons.check_circle_rounded,
                            color: AppColors.primary, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small reusable widgets
// ─────────────────────────────────────────────────────────────────────────────

/// White rounded card container used throughout the profile page.
class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? AppColors.primary;
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    this.value,
    this.valueWidget,
    this.copiable = false,
    this.valueColor,
  });

  final String label;
  final String? value;
  final Widget? valueWidget;
  final bool copiable;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          Expanded(
            child: valueWidget ??
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        value ?? '—',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: valueColor ?? const Color(0xFF0F172A),
                          fontFamily: copiable ? 'monospace' : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (copiable && value != null)
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: value!));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$label copied'),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              width: 240,
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.copy_rounded,
                            size: 14,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}

class _QuickStat extends StatelessWidget {
  const _QuickStat({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: valueColor ?? const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        height: 28,
        color: const Color(0xFFE2E8F0),
      );
}

/// Small circular role indicator overlaid on the avatar.
class _RoleBadgeSmall extends StatelessWidget {
  const _RoleBadgeSmall({required this.role});
  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final (bg, icon) = switch (role) {
      UserRole.superAdmin => (const Color(0xFF6366F1), Icons.shield_rounded),
      UserRole.siteAdmin => (const Color(0xFF0284C7), Icons.manage_accounts),
    };

    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(icon, size: 13, color: Colors.white),
    );
  }
}

/// Pill badge showing the role label with color.
class _RolePill extends StatelessWidget {
  const _RolePill({required this.role});
  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (role) {
      UserRole.superAdmin => (
          'Super Admin',
          const Color(0xFFEEF2FF),
          const Color(0xFF4338CA),
        ),
      UserRole.siteAdmin => (
          'Site Admin',
          const Color(0xFFE0F2FE),
          const Color(0xFF0369A1),
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

String _initials(UserModel u) {
  if (u.name?.isNotEmpty == true) {
    final parts = u.name!.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0][0].toUpperCase();
  }
  return u.email[0].toUpperCase();
}

String _fmtDate(DateTime d) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}

String _fmtDatetime(DateTime d) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  final h = d.hour.toString().padLeft(2, '0');
  final m = d.minute.toString().padLeft(2, '0');
  return '${d.day} ${months[d.month - 1]} ${d.year} • $h:$m';
}
