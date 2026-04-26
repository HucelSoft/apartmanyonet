import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/network/pocketbase_client.dart';
import 'package:apartmanyonet/core/theme/app_theme.dart';
import 'package:apartmanyonet/features/admin/presentation/providers/owners_notifier.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';
import 'package:apartmanyonet/features/owner/data/models/owner_model.dart';
import 'package:apartmanyonet/features/owner/data/repositories/owner_repository.dart';

class AdminOwnersPage extends StatelessWidget {
  const AdminOwnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pb = context.read<PocketBaseService>().pb;
    final orgId = context.read<AuthNotifier>().organizationId ?? '';

    return ChangeNotifierProvider(
      create: (_) => OwnersNotifier(
        repository: OwnerRepository(pb: pb, organizationId: orgId),
      ),
      child: const _OwnersView(),
    );
  }
}

class _OwnersView extends StatelessWidget {
  const _OwnersView();

  @override
  Widget build(BuildContext context) {
    final n = context.watch<OwnersNotifier>();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(notifier: n),
          Expanded(
            child: n.isLoading && n.owners.isEmpty
                ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                : n.error != null && n.owners.isEmpty
                    ? _ErrorState(message: n.error!, onRetry: n.loadOwners)
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(28, 24, 28, 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SummaryCards(notifier: n),
                            const SizedBox(height: 24),
                            _OwnersTable(notifier: n),
                          ],
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showOwnerFormDialog(context, n, null),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('Add Owner', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.notifier});
  final OwnersNotifier notifier;

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
              const Text('Owners',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  )),
              Text('${notifier.owners.length} total owners',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
            ],
          ),
          const Spacer(),
          Tooltip(
            message: 'Refresh',
            child: IconButton(
              onPressed: notifier.isLoading ? null : notifier.loadOwners,
              icon: notifier.isLoading
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
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
  final OwnersNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final individuals = notifier.owners.where((o) => o.type == PersonType.individual).length;
    final corporates = notifier.owners.where((o) => o.type == PersonType.corporate).length;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Total',
            value: '${notifier.owners.length}',
            icon: Icons.groups_rounded,
            iconColor: const Color(0xFF6366F1),
            iconBg: const Color(0xFFEEF2FF),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Individuals',
            value: '$individuals',
            icon: Icons.person_rounded,
            iconColor: const Color(0xFF16A34A),
            iconBg: const Color(0xFFDCFCE7),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Corporate',
            value: '$corporates',
            icon: Icons.business_rounded,
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
          decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.5)),
        ]),
      ]),
    );
  }
}

class _OwnersTable extends StatelessWidget {
  const _OwnersTable({required this.notifier});
  final OwnersNotifier notifier;

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
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Text('Owner List', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
          ),
          const Divider(height: 1),
          notifier.owners.isEmpty
              ? const _EmptyTable()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                    headingTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                    columnSpacing: 24,
                    horizontalMargin: 20,
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Phone')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: notifier.owners.map((o) => _buildRow(context, o)).toList(),
                  ),
                ),
        ],
      ),
    );
  }

  DataRow _buildRow(BuildContext context, OwnerModel o) {
    final typeLabel = o.type == PersonType.individual ? 'Individual' : o.type == PersonType.corporate ? 'Corporate' : '-';
    final name = '${o.name ?? ''} ${o.surname ?? ''}'.trim();
    
    return DataRow(cells: [
      DataCell(Text(name.isEmpty ? 'Unknown' : name, style: const TextStyle(fontWeight: FontWeight.w600))),
      DataCell(Text(typeLabel)),
      DataCell(Text(o.phone?.isEmpty == false ? o.phone! : '-')),
      DataCell(Text(o.email?.isEmpty == false ? o.email! : '-')),
      DataCell(Row(children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF64748B)),
          onPressed: () => _showOwnerFormDialog(context, notifier, o),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFDC2626)),
          onPressed: () => _confirmDelete(context, notifier, o),
        ),
      ])),
    ]);
  }

  void _confirmDelete(BuildContext context, OwnersNotifier n, OwnerModel o) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Owner?'),
        content: const Text('This action cannot be undone. Make sure they have no active flats before deleting.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              n.deleteOwner(o.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Color(0xFFDC2626))),
          ),
        ],
      ),
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
          Icon(Icons.person_off_outlined, size: 48, color: Color(0xFFCBD5E1)),
          SizedBox(height: 12),
          Text('No owners found.', style: TextStyle(color: Color(0xFF94A3B8))),
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
// Form Dialog
// ─────────────────────────────────────────────────────────────────────────────

void _showOwnerFormDialog(BuildContext context, OwnersNotifier notifier, OwnerModel? existing) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => ChangeNotifierProvider.value(
      value: notifier,
      child: _OwnerFormDialog(owner: existing),
    ),
  );
}

class _OwnerFormDialog extends StatefulWidget {
  const _OwnerFormDialog({this.owner});
  final OwnerModel? owner;

  @override
  State<_OwnerFormDialog> createState() => _OwnerFormDialogState();
}

class _OwnerFormDialogState extends State<_OwnerFormDialog> {
  final _formKey = GlobalKey<FormState>();
  
  late final TextEditingController _nameCtrl;
  late final TextEditingController _surnameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _emailCtrl;
  
  PersonType? _selectedType;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.owner?.name);
    _surnameCtrl = TextEditingController(text: widget.owner?.surname);
    _phoneCtrl = TextEditingController(text: widget.owner?.phone);
    _emailCtrl = TextEditingController(text: widget.owner?.email);
    _selectedType = widget.owner?.type ?? PersonType.individual;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = context.watch<OwnersNotifier>();
    final isEditing = widget.owner != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Owner' : 'New Owner', style: const TextStyle(fontWeight: FontWeight.w800)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<PersonType>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: PersonType.individual, child: Text('Individual')),
                  DropdownMenuItem(value: PersonType.corporate, child: Text('Corporate')),
                ],
                onChanged: (v) => setState(() => _selectedType = v),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                      validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _surnameCtrl,
                      decoration: const InputDecoration(labelText: 'Surname', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone_outlined, size: 20)),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email_outlined, size: 20)),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            
            bool success;
            if (isEditing) {
              success = await n.updateOwner(
                widget.owner!.id,
                name: _nameCtrl.text,
                surname: _surnameCtrl.text,
                type: _selectedType,
                phone: _phoneCtrl.text,
                email: _emailCtrl.text,
              );
            } else {
              success = await n.createOwner(
                name: _nameCtrl.text,
                surname: _surnameCtrl.text,
                type: _selectedType,
                phone: _phoneCtrl.text,
                email: _emailCtrl.text,
              );
            }
            if (success && context.mounted) Navigator.pop(context);
          },
          child: Text(isEditing ? 'Save' : 'Create'),
        ),
      ],
    );
  }
}
