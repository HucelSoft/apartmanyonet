import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/network/pocketbase_client.dart';
import 'package:apartmanyonet/core/theme/app_theme.dart';
import 'package:apartmanyonet/features/admin/presentation/providers/transactions_notifier.dart';
import 'package:apartmanyonet/features/apartments/data/models/apartment_model.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';
import 'package:apartmanyonet/features/flats/data/models/flat_model.dart';
import 'package:apartmanyonet/features/site/data/models/site_model.dart';
import 'package:apartmanyonet/features/transaction/data/models/transaction_type_model.dart';
import 'package:apartmanyonet/features/transaction/data/repositories/transaction_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Page entry point
// ─────────────────────────────────────────────────────────────────────────────

class AdminTransactionsPage extends StatelessWidget {
  const AdminTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pb = context.read<PocketBaseService>().pb;
    final orgId = context.read<AuthNotifier>().organizationId ?? '';

    return ChangeNotifierProvider(
      create: (_) => TransactionsNotifier(
        TransactionRepository(pb: pb, organizationId: orgId),
      ),
      child: const _TransactionsView(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Root scaffold
// ─────────────────────────────────────────────────────────────────────────────

class _TransactionsView extends StatelessWidget {
  const _TransactionsView();

  @override
  Widget build(BuildContext context) {
    final n = context.watch<TransactionsNotifier>();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(notifier: n),
          Expanded(
            child: n.isLoading && n.totalCount == 0
                ? const Center(
                    child: CircularProgressIndicator(strokeWidth: 2))
                : n.error != null && n.totalCount == 0
                    ? _ErrorState(
                        message: n.error!, onRetry: n.refresh)
                    : SingleChildScrollView(
                        padding:
                            const EdgeInsets.fromLTRB(28, 24, 28, 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SummaryCards(notifier: n),
                            const SizedBox(height: 24),
                            _FilterBar(notifier: n),
                            const SizedBox(height: 16),
                            _TransactionTable(notifier: n),
                          ],
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showTransactionDialog(context, n),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Transaction',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────────────────────────────────────

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.notifier});
  final TransactionsNotifier notifier;

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Transactions',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  )),
              Text('${notifier.totalCount} total records',
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF64748B))),
            ],
          ),
          const Spacer(),
          Tooltip(
            message: 'Refresh',
            child: IconButton(
              onPressed:
                  notifier.isLoading ? null : notifier.refresh,
              icon: notifier.isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
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
// Summary cards
// ─────────────────────────────────────────────────────────────────────────────

class _SummaryCards extends StatelessWidget {
  const _SummaryCards({required this.notifier});
  final TransactionsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, c) {
      final wide = c.maxWidth > 640;
      final cards = [
        _StatCard(
          title: 'Total Records',
          value: '${notifier.totalCount}',
          icon: Icons.receipt_long_rounded,
          iconColor: const Color(0xFF6366F1),
          iconBg: const Color(0xFFEEF2FF),
        ),
        _StatCard(
          title: 'Collected',
          value: _fmt(notifier.totalCollected),
          icon: Icons.check_circle_rounded,
          iconColor: const Color(0xFF16A34A),
          iconBg: const Color(0xFFDCFCE7),
        ),
        _StatCard(
          title: 'Pending',
          value: _fmt(notifier.totalPending),
          icon: Icons.pending_rounded,
          iconColor: const Color(0xFFD97706),
          iconBg: const Color(0xFFFEF3C7),
        ),
      ];

      if (wide) {
        return Row(
          children: cards
              .asMap()
              .entries
              .map((e) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: e.key < cards.length - 1 ? 16 : 0),
                      child: e.value,
                    ),
                  ))
              .toList(),
        );
      }
      return Column(
        children: cards
            .map((c) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(width: double.infinity, child: c)))
            .toList(),
      );
    });
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });
  final String title;
  final String value;
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
      child: Row(children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              color: iconBg, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B))),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5)),
        ]),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Filter bar
// ─────────────────────────────────────────────────────────────────────────────

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.notifier});
  final TransactionsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Status chips
        _FilterChip(
          label: 'All',
          selected: notifier.statusFilter == null,
          color: AppColors.primary,
          onTap: () => notifier.setStatusFilter(null),
        ),
        _FilterChip(
          label: 'Completed',
          selected: notifier.statusFilter == RecordStatus.completed,
          color: const Color(0xFF16A34A),
          onTap: () => notifier.setStatusFilter(RecordStatus.completed),
        ),
        _FilterChip(
          label: 'Pending',
          selected: notifier.statusFilter == RecordStatus.pending,
          color: const Color(0xFFD97706),
          onTap: () => notifier.setStatusFilter(RecordStatus.pending),
        ),
        _FilterChip(
          label: 'Cancelled',
          selected: notifier.statusFilter == RecordStatus.cancelled,
          color: const Color(0xFF94A3B8),
          onTap: () => notifier.setStatusFilter(RecordStatus.cancelled),
        ),
        const SizedBox(width: 8),
        // Site dropdown filter
        if (notifier.sites.isNotEmpty)
          _SiteDropdownFilter(notifier: notifier),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
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
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? color : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : color.withValues(alpha: 0.25),
          ),
        ),
        child: Text(label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : color,
            )),
      ),
    );
  }
}

class _SiteDropdownFilter extends StatelessWidget {
  const _SiteDropdownFilter({required this.notifier});
  final TransactionsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: notifier.siteFilter,
          isDense: true,
          hint: const Text('All Sites',
              style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A)),
          items: [
            const DropdownMenuItem<String?>(
              value: null,
              child: Text('All Sites'),
            ),
            ...notifier.sites.map((s) => DropdownMenuItem<String?>(
                  value: s.id,
                  child: Text(s.name),
                )),
          ],
          onChanged: notifier.setSiteFilter,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Transaction table
// ─────────────────────────────────────────────────────────────────────────────

class _TransactionTable extends StatefulWidget {
  const _TransactionTable({required this.notifier});
  final TransactionsNotifier notifier;

  @override
  State<_TransactionTable> createState() => _TransactionTableState();
}

class _TransactionTableState extends State<_TransactionTable> {
  int _sortColumnIndex = 5; // date
  bool _sortAscending = false;

  TransactionsNotifier get n => widget.notifier;

  List<TransactionItem> _sorted(List<TransactionItem> rows) {
    final copy = List.of(rows);
    copy.sort((a, b) {
      final cmp = switch (_sortColumnIndex) {
        0 => a.typeName.compareTo(b.typeName),
        1 => a.siteName.compareTo(b.siteName),
        2 => a.apartmentLabel.compareTo(b.apartmentLabel),
        3 => a.flatLabel.compareTo(b.flatLabel),
        4 => (a.transaction.amount ?? 0)
            .compareTo(b.transaction.amount ?? 0),
        5 => a.transaction.date.compareTo(b.transaction.date),
        6 => (a.transaction.dueDate ?? DateTime(0))
            .compareTo(b.transaction.dueDate ?? DateTime(0)),
        7 => a.transaction.status.name
            .compareTo(b.transaction.status.name),
        _ => 0,
      };
      return _sortAscending ? cmp : -cmp;
    });
    return copy;
  }

  void _onSort(int col, bool asc) {
    setState(() {
      _sortColumnIndex = col;
      _sortAscending = asc;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rows = _sorted(n.items);

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
          // Table title row
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Row(children: [
              const Text('Transaction History',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A))),
              const SizedBox(width: 8),
              _CountBadge('${rows.length}'),
            ]),
          ),
          const Divider(height: 1),

          // Table
          rows.isEmpty
              ? _EmptyTable(isFiltered: n.statusFilter != null ||
                  n.siteFilter != null)
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    headingRowColor: WidgetStateProperty.all(
                        const Color(0xFFF8FAFC)),
                    headingTextStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                        letterSpacing: 0.3),
                    dataTextStyle: const TextStyle(
                        fontSize: 13.5, color: Color(0xFF334155)),
                    columnSpacing: 18,
                    horizontalMargin: 20,
                    dividerThickness: 0.8,
                    columns: [
                      _col('Type', 0),
                      _col('Site', 1),
                      _col('Block', 2),
                      _col('Flat', 3),
                      _col('Amount', 4),
                      _col('Date', 5),
                      _col('Due Date', 6),
                      _col('Status', 7),
                      const DataColumn(label: Text('Actions')),
                    ],
                    rows: rows.map((item) => _buildRow(context, item)).toList(),
                  ),
                ),
        ],
      ),
    );
  }

  DataColumn _col(String label, int idx) =>
      DataColumn(label: Text(label), onSort: _onSort);

  DataRow _buildRow(BuildContext context, TransactionItem item) {
    final tx = item.transaction;
    final isCredit = item.typeGenre == TransactionGenre.credit;

    return DataRow(cells: [
      // Type
      DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(
          isCredit ? Icons.arrow_circle_down_rounded : Icons.arrow_circle_up_rounded,
          size: 15,
          color: isCredit ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
        ),
        const SizedBox(width: 6),
        Text(item.typeName,
            style: const TextStyle(fontWeight: FontWeight.w600)),
      ])),

      // Site
      DataCell(_OverflowCell(item.siteName, maxWidth: 160)),

      // Block
      DataCell(_OverflowCell(item.apartmentLabel, maxWidth: 120)),

      // Flat
      DataCell(Text(item.flatLabel)),

      // Amount
      DataCell(Text(
        _fmt(tx.amount ?? 0),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: tx.status == RecordStatus.completed
              ? const Color(0xFF16A34A)
              : const Color(0xFF0F172A),
        ),
      )),

      // Date
      DataCell(Text(_fmtDate(tx.date))),

      // Due Date
      DataCell(Text(tx.dueDate != null ? _fmtDate(tx.dueDate!) : '—')),

      // Status
      DataCell(_StatusBadge(status: tx.status)),

      // Actions
      DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
        _IconBtn(
          icon: Icons.edit_rounded,
          tooltip: 'Edit',
          onTap: () => _showTransactionDialog(context, n, existing: item),
        ),
        _IconBtn(
          icon: Icons.delete_outline_rounded,
          tooltip: 'Delete',
          color: const Color(0xFFDC2626),
          onTap: () => _confirmDelete(context, n, item),
        ),
      ])),
    ]);
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
          color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: fg)),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small helpers
// ─────────────────────────────────────────────────────────────────────────────

class _CountBadge extends StatelessWidget {
  const _CountBadge(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20)),
      child: Text(label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B))),
    );
  }
}

class _OverflowCell extends StatelessWidget {
  const _OverflowCell(this.text, {required this.maxWidth});
  final String text;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Text(text,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Color(0xFF475569))),
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn(
      {required this.icon,
      required this.onTap,
      this.tooltip = '',
      this.color});
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon,
              size: 18, color: color ?? const Color(0xFF64748B)),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty / Error states
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyTable extends StatelessWidget {
  const _EmptyTable({required this.isFiltered});
  final bool isFiltered;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: Center(
        child: Column(children: [
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
                ? 'No transactions match the current filter.'
                : 'No transactions found.',
            style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
          ),
        ]),
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
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.error_outline_rounded,
            size: 48, color: Color(0xFFCBD5E1)),
        const SizedBox(height: 12),
        const Text('Failed to load transactions',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155))),
        const SizedBox(height: 6),
        Text(message,
            style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
            textAlign: TextAlign.center),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded, size: 16),
          label: const Text('Retry'),
          style:
              FilledButton.styleFrom(backgroundColor: AppColors.primary),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Create / Edit dialog
// ─────────────────────────────────────────────────────────────────────────────

void _showTransactionDialog(
  BuildContext context,
  TransactionsNotifier notifier, {
  TransactionItem? existing,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => ChangeNotifierProvider.value(
      value: notifier,
      child: _TransactionDialog(existing: existing),
    ),
  );
}

class _TransactionDialog extends StatefulWidget {
  const _TransactionDialog({this.existing});
  final TransactionItem? existing;

  @override
  State<_TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<_TransactionDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _amount = TextEditingController();
  final _description = TextEditingController();

  // Dropdown selections
  TransactionTypeModel? _selectedType;
  SiteModel? _selectedSite;
  ApartmentModel? _selectedApartment;
  FlatModel? _selectedFlat;
  RecordStatus _status = RecordStatus.pending;

  // Date values
  DateTime _date = DateTime.now();
  DateTime? _dueDate;
  DateTime? _paymentDate;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _amount.text = (e.transaction.amount ?? 0).toStringAsFixed(2);
      _description.text = e.transaction.description ?? '';
      _date = e.transaction.date;
      _dueDate = e.transaction.dueDate;
      _paymentDate = e.transaction.paymentDate;
      _status = e.transaction.status;

      // Pre-select from cached lists
      final n = context.read<TransactionsNotifier>();
      _selectedType = n.types
          .where((t) => t.id == e.transaction.type)
          .firstOrNull;
      _selectedSite = n.sites
          .where((s) => s.id == e.transaction.site)
          .firstOrNull;

      // Load apartments & flats for pre-selection
      if (_selectedSite != null) {
        n.loadApartmentsForSite(_selectedSite!.id).then((_) {
          if (!mounted) return;
          setState(() {
            _selectedApartment = n.apartments
                .where((a) => a.id == e.transaction.apartment)
                .firstOrNull;
          });
          if (_selectedApartment != null) {
            n.loadFlatsForApartment(_selectedApartment!.id).then((_) {
              if (!mounted) return;
              setState(() {
                _selectedFlat = n.flats
                    .where((f) => f.id == e.transaction.flat)
                    .firstOrNull;
              });
            });
          }
        });
      }
    } else {
      context.read<TransactionsNotifier>().clearApartmentsAndFlats();
    }
  }

  @override
  void dispose() {
    _amount.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedType == null ||
        _selectedSite == null ||
        _selectedApartment == null ||
        _selectedFlat == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill in all required fields.'),
        backgroundColor: Color(0xFFD97706),
      ));
      return;
    }

    setState(() => _saving = true);
    final n = context.read<TransactionsNotifier>();

    final ok = widget.existing == null
        ? await n.createTransaction(
            typeId: _selectedType!.id,
            siteId: _selectedSite!.id,
            apartmentId: _selectedApartment!.id,
            flatId: _selectedFlat!.id,
            amount: double.parse(_amount.text.replaceAll(',', '.')),
            date: _date,
            status: _status,
            description: _description.text.trim(),
            dueDate: _dueDate,
            paymentDate: _paymentDate,
          )
        : await n.updateTransaction(
            widget.existing!.id,
            typeId: _selectedType!.id,
            siteId: _selectedSite!.id,
            apartmentId: _selectedApartment!.id,
            flatId: _selectedFlat!.id,
            amount: double.parse(_amount.text.replaceAll(',', '.')),
            date: _date,
            status: _status,
            description: _description.text.trim(),
            dueDate: _dueDate,
            paymentDate: _paymentDate,
          );

    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(n.error ?? 'Operation failed'),
        backgroundColor: const Color(0xFFDC2626),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final n = context.watch<TransactionsNotifier>();
    final isEdit = widget.existing != null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560, maxHeight: 640),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title bar
            Container(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
              color: AppColors.primary,
              child: Row(children: [
                Icon(
                  isEdit
                      ? Icons.edit_rounded
                      : Icons.add_circle_outline_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  isEdit ? 'Edit Transaction' : 'New Transaction',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),

            // Scrollable form body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Type ──────────────────────────────────────────────
                      _SectionLabel('Transaction Type *'),
                      _StyledDropdown<TransactionTypeModel>(
                        value: _selectedType,
                        hint: 'Select type',
                        items: n.types,
                        labelBuilder: (t) =>
                            '${t.type}  (${t.genre.name})',
                        onChanged: (t) => setState(() => _selectedType = t),
                      ),
                      const SizedBox(height: 14),

                      // ── Site ──────────────────────────────────────────────
                      _SectionLabel('Site (Bina) *'),
                      _StyledDropdown<SiteModel>(
                        value: _selectedSite,
                        hint: 'Select building',
                        items: n.sites,
                        labelBuilder: (s) => s.name,
                        onChanged: (s) {
                          setState(() {
                            _selectedSite = s;
                            _selectedApartment = null;
                            _selectedFlat = null;
                          });
                          if (s != null) {
                            n.loadApartmentsForSite(s.id);
                          } else {
                            n.clearApartmentsAndFlats();
                          }
                        },
                      ),
                      const SizedBox(height: 14),

                      // ── Apartment ─────────────────────────────────────────
                      _SectionLabel('Block (Blok) *'),
                      _StyledDropdown<ApartmentModel>(
                        value: _selectedApartment,
                        hint: _selectedSite == null
                            ? 'Pick a site first'
                            : 'Select block',
                        items: n.apartments,
                        labelBuilder: (a) => a.name,
                        onChanged: _selectedSite == null
                            ? null
                            : (a) {
                                setState(() {
                                  _selectedApartment = a;
                                  _selectedFlat = null;
                                });
                                if (a != null) {
                                  n.loadFlatsForApartment(a.id);
                                }
                              },
                      ),
                      const SizedBox(height: 14),

                      // ── Flat ──────────────────────────────────────────────
                      _SectionLabel('Flat (Daire) *'),
                      _StyledDropdown<FlatModel>(
                        value: _selectedFlat,
                        hint: _selectedApartment == null
                            ? 'Pick a block first'
                            : 'Select flat',
                        items: n.flats,
                        labelBuilder: (f) => 'No. ${f.flat}',
                        onChanged: _selectedApartment == null
                            ? null
                            : (f) => setState(() => _selectedFlat = f),
                      ),
                      const SizedBox(height: 14),

                      // ── Amount ────────────────────────────────────────────
                      _SectionLabel('Amount (₺) *'),
                      TextFormField(
                        controller: _amount,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[\d.,]')),
                        ],
                        decoration: _inputDec(
                            'e.g. 2500.00', Icons.attach_money_rounded),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          final n = double.tryParse(
                              v.replaceAll(',', '.'));
                          if (n == null || n < 0) {
                            return 'Enter a valid amount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // ── Description ───────────────────────────────────────
                      _SectionLabel('Description'),
                      TextFormField(
                        controller: _description,
                        maxLines: 2,
                        decoration: _inputDec(
                            'Optional note', Icons.notes_rounded),
                      ),
                      const SizedBox(height: 14),

                      // ── Dates row ─────────────────────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: _DatePicker(
                              label: 'Transaction Date *',
                              value: _date,
                              onPick: (d) =>
                                  setState(() => _date = d),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _DatePicker(
                              label: 'Due Date',
                              value: _dueDate,
                              optional: true,
                              onPick: (d) =>
                                  setState(() => _dueDate = d),
                              onClear: () =>
                                  setState(() => _dueDate = null),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // ── Status ────────────────────────────────────────────
                      _SectionLabel('Status *'),
                      _StatusSelector(
                        value: _status,
                        onChanged: (s) => setState(() => _status = s),
                      ),
                      const SizedBox(height: 14),

                      // Payment date (only when completed)
                      if (_status == RecordStatus.completed)
                        _DatePicker(
                          label: 'Payment Date',
                          value: _paymentDate,
                          optional: true,
                          onPick: (d) =>
                              setState(() => _paymentDate = d),
                          onClear: () =>
                              setState(() => _paymentDate = null),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Action buttons
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _saving
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: _saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : Text(isEdit ? 'Update' : 'Create',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status selector (3 toggle buttons)
// ─────────────────────────────────────────────────────────────────────────────

class _StatusSelector extends StatelessWidget {
  const _StatusSelector({required this.value, required this.onChanged});
  final RecordStatus value;
  final ValueChanged<RecordStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    const statuses = [
      (RecordStatus.pending, 'Pending', Color(0xFFD97706)),
      (RecordStatus.completed, 'Completed', Color(0xFF16A34A)),
      (RecordStatus.cancelled, 'Cancelled', Color(0xFF64748B)),
    ];

    return Row(
      children: statuses.map((s) {
        final (status, label, color) = s;
        final sel = value == status;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onChanged(status),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: sel ? color : color.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: sel ? color : color.withValues(alpha: 0.25),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(label,
                    style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: sel ? Colors.white : color)),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Date picker widget
// ─────────────────────────────────────────────────────────────────────────────

class _DatePicker extends StatelessWidget {
  const _DatePicker({
    required this.label,
    required this.value,
    required this.onPick,
    this.optional = false,
    this.onClear,
  });
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onPick;
  final bool optional;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _SectionLabel(label),
      const SizedBox(height: 4),
      InkWell(
        onTap: () async {
          final d = await showDatePicker(
            context: context,
            initialDate: value ?? DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
          );
          if (d != null) onPick(d);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            const Icon(Icons.calendar_today_rounded,
                size: 16, color: Color(0xFF64748B)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value != null ? _fmtDate(value!) : 'Select date',
                style: TextStyle(
                  fontSize: 13,
                  color: value != null
                      ? const Color(0xFF0F172A)
                      : const Color(0xFF94A3B8),
                ),
              ),
            ),
            if (optional && value != null)
              GestureDetector(
                onTap: onClear,
                child: const Icon(Icons.close_rounded,
                    size: 16, color: Color(0xFF94A3B8)),
              ),
          ]),
        ),
      ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Generic styled dropdown
// ─────────────────────────────────────────────────────────────────────────────

class _StyledDropdown<T> extends StatelessWidget {
  const _StyledDropdown({
    required this.value,
    required this.hint,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
  });
  final T? value;
  final String hint;
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD1D5DB)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: Text(hint,
              style: const TextStyle(
                  fontSize: 13, color: Color(0xFF94A3B8))),
          style: const TextStyle(
              fontSize: 13.5, color: Color(0xFF0F172A)),
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(labelBuilder(item),
                        overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Delete confirmation
// ─────────────────────────────────────────────────────────────────────────────

void _confirmDelete(
  BuildContext context,
  TransactionsNotifier notifier,
  TransactionItem item,
) {
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      title: const Text('Delete Transaction?'),
      content: Text(
        'Amount: ${_fmt(item.transaction.amount ?? 0)}\n'
        'Type: ${item.typeName}\n'
        'This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626)),
          onPressed: () async {
            Navigator.of(context).pop();
            await notifier.deleteTransaction(item.id);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Tiny form helpers
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151))),
    );
  }
}

InputDecoration _inputDec(String hint, IconData icon) => InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
      prefixIcon: Icon(icon, size: 18),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );

// ─────────────────────────────────────────────────────────────────────────────
// Formatting
// ─────────────────────────────────────────────────────────────────────────────

String _fmt(double v) {
  final s = v.abs().toStringAsFixed(2);
  final parts = s.split('.');
  final intPart = parts[0].replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+$)'),
    (m) => '${m[1]},',
  );
  return '₺$intPart.${parts[1]}';
}

String _fmtDate(DateTime d) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
}
