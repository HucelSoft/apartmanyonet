import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/network/pocketbase_client.dart';
import 'package:apartmanyonet/core/theme/app_theme.dart';
import 'package:apartmanyonet/features/admin/presentation/providers/dashboard_notifier.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';
import 'package:apartmanyonet/features/site/data/models/site_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Entry point – provides [DashboardNotifier] locally so it disposes with page.
// ─────────────────────────────────────────────────────────────────────────────

/// Admin Dashboard page.
///
/// Fetches all transactions for the currently selected site and displays them
/// in a filterable, sortable [DataTable] alongside summary stat cards.
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pb = context.read<PocketBaseService>().pb;
    final orgId = context.read<AuthNotifier>().organizationId ?? '';

    return ChangeNotifierProvider(
      create: (_) => DashboardNotifier(pb: pb, organizationId: orgId),
      child: const _DashboardView(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Root view
// ─────────────────────────────────────────────────────────────────────────────

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final n = context.watch<DashboardNotifier>();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DashboardHeader(notifier: n),
          Expanded(
            child: n.isLoading && n.totalCount == 0
                ? const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : n.error != null && n.totalCount == 0
                    ? _ErrorState(message: n.error!, onRetry: n.refresh)
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SummaryCards(notifier: n),
                            const SizedBox(height: 28),
                            _TransactionCard(notifier: n),
                          ],
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

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({required this.notifier});

  final DashboardNotifier notifier;

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
          // ── Title ──────────────────────────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'Financial overview for ${notifier.selectedSite?.name ?? '…'}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),

          const Spacer(),

          // ── Site picker ────────────────────────────────────────────────────
          if (notifier.sites.length > 1) ...[
            const Text(
              'Site:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(width: 8),
            _SitePicker(notifier: notifier),
            const SizedBox(width: 16),
          ],

          // ── Refresh button ─────────────────────────────────────────────────
          Tooltip(
            message: 'Refresh',
            child: IconButton(
              onPressed: notifier.isLoading ? null : notifier.refresh,
              icon: notifier.isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh_rounded),
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Site picker dropdown
// ─────────────────────────────────────────────────────────────────────────────

class _SitePicker extends StatelessWidget {
  const _SitePicker({required this.notifier});

  final DashboardNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SiteModel>(
          value: notifier.selectedSite,
          isDense: true,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
          items: notifier.sites
              .map(
                (s) => DropdownMenuItem(
                  value: s,
                  child: Text(s.name),
                ),
              )
              .toList(),
          onChanged: (s) {
            if (s != null) notifier.selectSite(s);
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Summary cards row
// ─────────────────────────────────────────────────────────────────────────────

class _SummaryCards extends StatelessWidget {
  const _SummaryCards({required this.notifier});

  final DashboardNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isWide = constraints.maxWidth > 700;

        final cards = [
          _StatCard(
            title: 'Total Transactions',
            value: '${notifier.totalCount}',
            subtitle: '${notifier.completedCount} completed',
            icon: Icons.receipt_long_rounded,
            iconColor: const Color(0xFF6366F1),
            iconBg: const Color(0xFFEEF2FF),
          ),
          _StatCard(
            title: 'Collected',
            value: _fmtMoney(notifier.collectedAmount),
            subtitle: '${notifier.completedCount} payments',
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xFF16A34A),
            iconBg: const Color(0xFFDCFCE7),
          ),
          _StatCard(
            title: 'Pending',
            value: _fmtMoney(notifier.pendingAmount),
            subtitle: '${notifier.pendingCount} awaiting',
            icon: Icons.pending_rounded,
            iconColor: const Color(0xFFD97706),
            iconBg: const Color(0xFFFEF3C7),
          ),
        ];

        if (isWide) {
          return Row(
            children: cards
                .map((c) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: c,
                      ),
                    ))
                .toList()
              ..last = Expanded(child: cards.last),
          );
        }

        return Column(
          children: cards
              .map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(width: double.infinity, child: c),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon badge
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
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

// ─────────────────────────────────────────────────────────────────────────────
// Transaction table card
// ─────────────────────────────────────────────────────────────────────────────

class _TransactionCard extends StatefulWidget {
  const _TransactionCard({required this.notifier});

  final DashboardNotifier notifier;

  @override
  State<_TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<_TransactionCard> {
  int _sortColumnIndex = 4; // 'date' column
  bool _sortAscending = false; // newest first

  DashboardNotifier get n => widget.notifier;

  List<TransactionRow> _sorted(List<TransactionRow> rows) {
    final copy = List.of(rows);
    copy.sort((a, b) {
      final cmp = switch (_sortColumnIndex) {
        0 => a.typeName.compareTo(b.typeName),
        1 => a.transaction.description
                ?.compareTo(b.transaction.description ?? '') ??
            0,
        2 => a.flatLabel.compareTo(b.flatLabel),
        3 => (a.transaction.amount ?? 0).compareTo(b.transaction.amount ?? 0),
        4 => a.transaction.date.compareTo(b.transaction.date),
        5 => (a.transaction.dueDate ?? DateTime(0))
            .compareTo(b.transaction.dueDate ?? DateTime(0)),
        6 => a.transaction.status.name.compareTo(b.transaction.status.name),
        _ => 0,
      };
      return _sortAscending ? cmp : -cmp;
    });
    return copy;
  }

  void _onSort(int colIdx, bool asc) => setState(() {
        _sortColumnIndex = colIdx;
        _sortAscending = asc;
      });

  @override
  Widget build(BuildContext context) {
    final rows = _sorted(n.rows);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Table header bar ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 12, 14),
            child: Row(
              children: [
                const Text(
                  'Transaction History',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${rows.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
                const Spacer(),
                _StatusFilterChips(notifier: n),
              ],
            ),
          ),

          const Divider(height: 1),

          // ── DataTable ────────────────────────────────────────────────────────
          rows.isEmpty
              ? _EmptyTableState(isFiltered: n.statusFilter != null)
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    headingRowColor: WidgetStateProperty.all(
                      const Color(0xFFF8FAFC),
                    ),
                    headingTextStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.3,
                    ),
                    dataTextStyle: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF334155),
                    ),
                    columnSpacing: 20,
                    horizontalMargin: 20,
                    dividerThickness: 0.8,
                    columns: [
                      _col('Type', 0),
                      _col('Description', 1),
                      _col('Flat', 2),
                      _col('Amount', 3),
                      _col('Date', 4),
                      _col('Due Date', 5),
                      _col('Status', 6),
                    ],
                    rows: rows.map(_buildRow).toList(),
                  ),
                ),
        ],
      ),
    );
  }

  DataColumn _col(String label, int colIdx) => DataColumn(
        label: Text(label),
        onSort: _onSort,
      );

  DataRow _buildRow(TransactionRow r) {
    final tx = r.transaction;
    return DataRow(cells: [
      // Type
      DataCell(
        Text(
          r.typeName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      // Description
      DataCell(
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 220),
          child: Text(
            tx.description ?? '—',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF475569)),
          ),
        ),
      ),

      // Flat
      DataCell(Text(r.flatLabel)),

      // Amount
      DataCell(
        Text(
          _fmtMoney(tx.amount ?? 0),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: tx.status == RecordStatus.completed
                ? const Color(0xFF16A34A)
                : const Color(0xFF0F172A),
          ),
        ),
      ),

      // Date
      DataCell(Text(_fmtDate(tx.date))),

      // Due Date
      DataCell(Text(tx.dueDate != null ? _fmtDate(tx.dueDate!) : '—')),

      // Status
      DataCell(_StatusBadge(status: tx.status)),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status filter chips
// ─────────────────────────────────────────────────────────────────────────────

class _StatusFilterChips extends StatelessWidget {
  const _StatusFilterChips({required this.notifier});

  final DashboardNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        _Chip(
          label: 'All',
          selected: notifier.statusFilter == null,
          color: AppColors.primary,
          onTap: () => notifier.setStatusFilter(null),
        ),
        _Chip(
          label: 'Completed',
          selected: notifier.statusFilter == RecordStatus.completed,
          color: const Color(0xFF16A34A),
          onTap: () => notifier.setStatusFilter(RecordStatus.completed),
        ),
        _Chip(
          label: 'Pending',
          selected: notifier.statusFilter == RecordStatus.pending,
          color: const Color(0xFFD97706),
          onTap: () => notifier.setStatusFilter(RecordStatus.pending),
        ),
        _Chip(
          label: 'Cancelled',
          selected: notifier.statusFilter == RecordStatus.cancelled,
          color: const Color(0xFF94A3B8),
          onTap: () => notifier.setStatusFilter(RecordStatus.cancelled),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? color : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : color.withValues(alpha: 0.25),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : color,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status badge
// ─────────────────────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final RecordStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg, dot) = switch (status) {
      RecordStatus.completed => (
          'Completed',
          const Color(0xFFDCFCE7),
          const Color(0xFF15803D),
          const Color(0xFF22C55E),
        ),
      RecordStatus.pending => (
          'Pending',
          const Color(0xFFFEF3C7),
          const Color(0xFFB45309),
          const Color(0xFFF59E0B),
        ),
      RecordStatus.cancelled => (
          'Cancelled',
          const Color(0xFFF1F5F9),
          const Color(0xFF64748B),
          const Color(0xFF94A3B8),
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty / error states
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyTableState extends StatelessWidget {
  const _EmptyTableState({required this.isFiltered});

  final bool isFiltered;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: Center(
        child: Column(
          children: [
            Icon(
              isFiltered
                  ? Icons.filter_list_off_rounded
                  : Icons.receipt_long_outlined,
              size: 48,
              color: const Color(0xFFCBD5E1),
            ),
            const SizedBox(height: 12),
            Text(
              isFiltered
                  ? 'No transactions match the selected filter.'
                  : 'No transactions found for this site.',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded,
              size: 48, color: Color(0xFFCBD5E1)),
          const SizedBox(height: 12),
          const Text(
            'Failed to load dashboard data',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text('Retry'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

/// Formats a [double] as Turkish Lira with thousands separator.
/// Example: 12500.5 → "₺12,500.50"
String _fmtMoney(double v) {
  final s = v.abs().toStringAsFixed(2);
  final parts = s.split('.');
  final intPart = parts[0].replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+$)'),
    (m) => '${m[1]},',
  );
  return '₺$intPart.${parts[1]}';
}

/// Formats a [DateTime] as "DD MMM YYYY" (e.g. "25 Apr 2026").
String _fmtDate(DateTime d) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
}
