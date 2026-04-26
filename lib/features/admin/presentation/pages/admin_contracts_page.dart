import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:apartmanyonet/l10n/app_localizations.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/network/pocketbase_client.dart';
import 'package:apartmanyonet/core/theme/app_theme.dart';
import 'package:apartmanyonet/features/admin/presentation/providers/contracts_notifier.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';
import 'package:apartmanyonet/features/contract/data/models/contract_model.dart';
import 'package:apartmanyonet/features/contract/data/repositories/contract_repository.dart';
import 'package:apartmanyonet/features/site/data/repositories/building_repository.dart';
import 'package:apartmanyonet/features/owner/data/repositories/owner_repository.dart';

class AdminContractsPage extends StatelessWidget {
  const AdminContractsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pb = context.read<PocketBaseService>().pb;
    final orgId = context.read<AuthNotifier>().organizationId ?? '';

    return ChangeNotifierProvider(
      create: (_) => ContractsNotifier(
        contractRepo: ContractRepository(pb: pb, organizationId: orgId),
        buildingRepo: BuildingRepository(pb: pb, organizationId: orgId),
        ownerRepo: OwnerRepository(pb: pb, organizationId: orgId),
      ),
      child: const _ContractsView(),
    );
  }
}

class _ContractsView extends StatelessWidget {
  const _ContractsView();

  @override
  Widget build(BuildContext context) {
    final n = context.watch<ContractsNotifier>();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(notifier: n),
          Expanded(
            child: n.isLoading && n.contracts.isEmpty
                ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                : n.error != null && n.contracts.isEmpty
                    ? _ErrorState(message: n.error!, onRetry: n.loadContracts)
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(28, 24, 28, 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SummaryCards(notifier: n),
                            const SizedBox(height: 24),
                            _ContractsTable(notifier: n),
                          ],
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showContractDialog(context, n),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: Text(AppLocalizations.of(context)!.addContract,
            style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.notifier});
  final ContractsNotifier notifier;

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
              Text(AppLocalizations.of(context)!.contracts,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  )),
              Text('${notifier.contracts.length} ${AppLocalizations.of(context)!.totalContracts}',
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF64748B))),
            ],
          ),
          const Spacer(),
          Tooltip(
            message: 'Refresh',
            child: IconButton(
              onPressed: notifier.isLoading ? null : notifier.loadContracts,
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

class _SummaryCards extends StatelessWidget {
  const _SummaryCards({required this.notifier});
  final ContractsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final active = notifier.contracts.where((c) => c.status == ContractStatus.active).length;
    final expired = notifier.contracts.where((c) => c.status == ContractStatus.expired).length;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: AppLocalizations.of(context)!.total,
            value: '${notifier.contracts.length}',
            icon: Icons.assignment_rounded,
            iconColor: const Color(0xFF6366F1),
            iconBg: const Color(0xFFEEF2FF),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: AppLocalizations.of(context)!.active,
            value: '$active',
            icon: Icons.check_circle_rounded,
            iconColor: const Color(0xFF16A34A),
            iconBg: const Color(0xFFDCFCE7),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: AppLocalizations.of(context)!.expired,
            value: '$expired',
            icon: Icons.history_rounded,
            iconColor: const Color(0xFFD97706),
            iconBg: const Color(0xFFFEF3C7),
          ),
        ),
      ],
    );
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

class _ContractsTable extends StatelessWidget {
  const _ContractsTable({required this.notifier});
  final ContractsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Text(AppLocalizations.of(context)!.leaseAgreements,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A))),
          ),
          const Divider(height: 1),
          notifier.contracts.isEmpty
              ? const _EmptyTable()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                    headingTextStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B)),
                    columnSpacing: 24,
                    horizontalMargin: 20,
                    columns: [
                      DataColumn(label: Text(AppLocalizations.of(context)!.resident)),
                      DataColumn(label: Text(AppLocalizations.of(context)!.flat)),
                      DataColumn(label: Text(AppLocalizations.of(context)!.amount)),
                      DataColumn(label: Text(AppLocalizations.of(context)!.dueDay)),
                      DataColumn(label: Text(AppLocalizations.of(context)!.startDate)),
                      DataColumn(label: Text(AppLocalizations.of(context)!.endDate)),
                      DataColumn(label: Text(AppLocalizations.of(context)!.status)),
                      DataColumn(label: Text(AppLocalizations.of(context)!.actions)),
                    ],
                    rows: notifier.contracts.map((c) => _buildRow(context, c)).toList(),
                  ),
                ),
        ],
      ),
    );
  }

  DataRow _buildRow(BuildContext context, ContractModel c) {
    final df = DateFormat('MMM dd, yyyy');
    
    // PocketBase expands will be used here. 
    // For now, we display IDs or expand if available.
    // Expanded resident info
    final residentExp = c.expand['resident'] as Map<String, dynamic>?;
    final resName = residentExp != null 
        ? '${residentExp['name'] ?? ''} ${residentExp['surname'] ?? ''}'.trim()
        : '';
    final residentLabel = resName.isNotEmpty ? resName : (residentExp?['email'] ?? 'ID: ${c.resident}');

    // Expanded flat info
    final flatExp = c.expand['flat'] as Map<String, dynamic>?;
    final aptExp = flatExp?['expand']?['apartment'] as Map<String, dynamic>?;
    final siteExp = aptExp?['expand']?['site'] as Map<String, dynamic>?;
    
    final flatLabel = (siteExp != null && aptExp != null && flatExp != null)
        ? '${siteExp['name']} - ${aptExp['name']} (Flat ${flatExp['flat']})'
        : 'Flat ${c.flat}';

    return DataRow(cells: [
      DataCell(Text(residentLabel, style: const TextStyle(fontWeight: FontWeight.w600))),
      DataCell(Text(flatLabel)),
      DataCell(Text('\$${c.amount.toStringAsFixed(2)}', 
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A)))),
      DataCell(Text('${c.paymentDueDay}')),
      DataCell(Text(df.format(c.start))),
      DataCell(Text(df.format(c.end))),
      DataCell(_StatusBadge(status: c.status)),
      DataCell(Row(children: [
        IconButton(
          icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFDC2626)),
          onPressed: () => _confirmDelete(context, notifier, c),
        ),
      ])),
    ]);
  }

  void _confirmDelete(BuildContext context, ContractsNotifier n, ContractModel c) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Contract?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              n.deleteContract(c.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Color(0xFFDC2626))),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final ContractStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      ContractStatus.active => ('Active', const Color(0xFFDCFCE7), const Color(0xFF15803D)),
      ContractStatus.expired => ('Expired', const Color(0xFFFEF3C7), const Color(0xFFB45309)),
      ContractStatus.terminated => ('Terminated', const Color(0xFFF1F5F9), const Color(0xFF64748B)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

class _EmptyTable extends StatelessWidget {
  const _EmptyTable();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(children: [
          Icon(Icons.assignment_outlined, size: 48, color: Color(0xFFCBD5E1)),
          SizedBox(height: 12),
          Text('No contracts found.', style: TextStyle(color: Color(0xFF94A3B8))),
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
        const Icon(Icons.error_outline_rounded, size: 48, color: Color(0xFFCBD5E1)),
        const SizedBox(height: 12),
        Text(message, style: const TextStyle(color: Color(0xFF94A3B8))),
        const SizedBox(height: 20),
        FilledButton(onPressed: onRetry, child: const Text('Retry')),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dialogs
// ─────────────────────────────────────────────────────────────────────────────

void _showContractDialog(BuildContext context, ContractsNotifier notifier) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => ChangeNotifierProvider.value(
      value: notifier,
      child: const _ContractFormDialog(),
    ),
  );
}

class _ContractFormDialog extends StatefulWidget {
  const _ContractFormDialog();

  @override
  State<_ContractFormDialog> createState() => _ContractFormDialogState();
}

class _ContractFormDialogState extends State<_ContractFormDialog> {
  final _formKey = GlobalKey<FormState>();
  
  String? _selectedResident;
  String? _selectedOwner;
  String? _selectedSite;
  String? _selectedApartment;
  String? _selectedFlat;
  
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 365));
  
  final _amountController = TextEditingController();
  final _dueDayController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    context.read<ContractsNotifier>().prepareFormData();
  }

  @override
  Widget build(BuildContext context) {
    final n = context.watch<ContractsNotifier>();

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.newLeaseAgreement,
          style: const TextStyle(fontWeight: FontWeight.w800)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Resident Picker
              _DropdownField<String>(
                label: AppLocalizations.of(context)!.resident,
                value: _selectedResident,
                items: n.residents.map((r) {
                  final name = '${r.name ?? ''} ${r.surname ?? ''}'.trim();
                  final label = name.isNotEmpty ? name : (r.email ?? 'Unknown Resident');
                  return DropdownMenuItem(value: r.id, child: Text(label));
                }).toList(),
                onChanged: (v) => setState(() => _selectedResident = v),
              ),
              const SizedBox(height: 16),

              // Owner Picker
              _DropdownField<String>(
                label: AppLocalizations.of(context)!.owner,
                value: _selectedOwner,
                items: n.owners.map((o) {
                  final name = '${o.name ?? ''} ${o.surname ?? ''}'.trim();
                  final label = name.isNotEmpty ? name : (o.email ?? 'Unknown Owner');
                  return DropdownMenuItem(value: o.id, child: Text(label));
                }).toList(),
                onChanged: (v) => setState(() => _selectedOwner = v),
              ),
              const SizedBox(height: 16),
              
              // Site Picker
              _DropdownField<String>(
                label: AppLocalizations.of(context)!.site,
                value: _selectedSite,
                items: n.sites.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name))).toList(),
                onChanged: (v) {
                  setState(() {
                    _selectedSite = v;
                    _selectedApartment = null;
                    _selectedFlat = null;
                  });
                  if (v != null) n.loadApartments(v);
                },
              ),
              const SizedBox(height: 16),

              // Apartment Picker
              _DropdownField<String>(
                label: AppLocalizations.of(context)!.apartment,
                value: _selectedApartment,
                items: n.apartments.map((a) => DropdownMenuItem(value: a.id, child: Text(a.name))).toList(),
                onChanged: _selectedSite == null ? null : (v) {
                  setState(() {
                    _selectedApartment = v;
                    _selectedFlat = null;
                  });
                  if (v != null) n.loadFlats(v);
                },
              ),
              const SizedBox(height: 16),

              // Flat Picker
              _DropdownField<String>(
                label: AppLocalizations.of(context)!.flat,
                value: _selectedFlat,
                items: n.flats.map((f) => DropdownMenuItem(value: f.id, child: Text('Flat ${f.flat}'))).toList(),
                onChanged: _selectedApartment == null ? null : (v) => setState(() => _selectedFlat = v),
              ),
              const SizedBox(height: 16),

              // Dates
              Row(
                children: [
                  Expanded(
                    child: _DateField(
                      label: AppLocalizations.of(context)!.startDate,
                      date: _startDate,
                      onTap: () async {
                        final d = await showDatePicker(context: context, initialDate: _startDate, firstDate: DateTime(2020), lastDate: DateTime(2050));
                        if (d != null) setState(() => _startDate = d);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DateField(
                      label: AppLocalizations.of(context)!.endDate,
                      date: _endDate,
                      onTap: () async {
                        final d = await showDatePicker(context: context, initialDate: _endDate, firstDate: DateTime(2020), lastDate: DateTime(2050));
                        if (d != null) setState(() => _endDate = d);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Amount and Due Day
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.amount,
                        prefixText: r'$',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _dueDayController,
                      decoration: InputDecoration(
                        labelText: '${AppLocalizations.of(context)!.dueDay} (1-28)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        final d = int.tryParse(v ?? '');
                        if (d == null || d < 1 || d > 28) return '1-28';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            if (_selectedResident == null ||
                _selectedOwner == null ||
                _selectedFlat == null ||
                _selectedApartment == null ||
                _selectedSite == null) return;
            
            final orgId = context.read<AuthNotifier>().organizationId ?? '';

            final success = await n.createContract(
              flatId: _selectedFlat!,
              apartmentId: _selectedApartment!,
              siteId: _selectedSite!,
              organizationId: orgId,
              residentId: _selectedResident!,
              ownerId: _selectedOwner!,
              start: _startDate,
              end: _endDate,
              amount: double.parse(_amountController.text),
              paymentDueDay: int.parse(_dueDayController.text),
            );
            if (success && context.mounted) Navigator.pop(context);
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}

class _DropdownField<T> extends StatelessWidget {
  const _DropdownField({required this.label, required this.value, required this.items, required this.onChanged});
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      validator: (v) => v == null ? 'Required' : null,
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({required this.label, required this.date, required this.onTap});
  final String label;
  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        child: Text(DateFormat('yyyy-MM-dd').format(date)),
      ),
    );
  }
}
