import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/network/pocketbase_client.dart';
import 'package:apartmanyonet/core/theme/app_theme.dart';
import 'package:apartmanyonet/features/admin/presentation/providers/buildings_notifier.dart';
import 'package:apartmanyonet/features/apartments/data/models/apartment_model.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';
import 'package:apartmanyonet/features/flats/data/models/flat_model.dart';
import 'package:apartmanyonet/features/site/data/models/site_model.dart';
import 'package:apartmanyonet/features/site/data/repositories/building_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Page entry point
// ─────────────────────────────────────────────────────────────────────────────

class AdminBuildingsPage extends StatelessWidget {
  const AdminBuildingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pb = context.read<PocketBaseService>().pb;
    final orgId = context.read<AuthNotifier>().organizationId ?? '';

    final repo = BuildingRepository(pb: pb, organizationId: orgId);

    return ChangeNotifierProvider(
      create: (_) => BuildingsNotifier(repo),
      child: const _BuildingsView(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Root view
// ─────────────────────────────────────────────────────────────────────────────

class _BuildingsView extends StatelessWidget {
  const _BuildingsView();

  @override
  Widget build(BuildContext context) {
    final n = context.watch<BuildingsNotifier>();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(notifier: n),
          Expanded(
            child: n.isLoading && n.nodes.isEmpty
                ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                : n.error != null && n.nodes.isEmpty
                    ? _ErrorState(
                        message: n.error!,
                        onRetry: n.loadSites,
                      )
                    : n.nodes.isEmpty
                        ? _EmptyState(
                            onAdd: () => _showSiteDialog(context, n),
                          )
                        : ListView.builder(
                            padding:
                                const EdgeInsets.fromLTRB(28, 20, 28, 100),
                            itemCount: n.nodes.length,
                            itemBuilder: (_, i) =>
                                _SiteCard(node: n.nodes[i], notifier: n),
                          ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSiteDialog(context, n),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'New Building',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────────────────────────────────────

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.notifier});
  final BuildingsNotifier notifier;

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
              const Text(
                'Buildings',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                '${notifier.nodes.length} building(s) registered',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const Spacer(),
          Tooltip(
            message: 'Refresh',
            child: IconButton(
              onPressed: notifier.isLoading ? null : notifier.loadSites,
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
// Site Card (Level 1)
// ─────────────────────────────────────────────────────────────────────────────

class _SiteCard extends StatelessWidget {
  const _SiteCard({required this.node, required this.notifier});

  final SiteNode node;
  final BuildingsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Site header row ──────────────────────────────────────────────
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            onTap: () => notifier.toggleSite(node.site.id),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
              child: Row(
                children: [
                  // Icon badge
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.domain_rounded,
                        color: AppColors.primary, size: 22),
                  ),
                  const SizedBox(width: 14),
                  // Name & address
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          node.site.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        if (node.site.address?.isNotEmpty == true) ...[
                          const SizedBox(height: 2),
                          Text(
                            node.site.address!,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF64748B),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Apartment count badge
                  if (node.apartments.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${node.apartments.length} block',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4338CA),
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  // Edit
                  _ActionButton(
                    icon: Icons.edit_rounded,
                    tooltip: 'Edit building',
                    onTap: () =>
                        _showSiteDialog(context, notifier, existing: node.site),
                  ),
                  // Add apartment
                  _ActionButton(
                    icon: Icons.add_business_rounded,
                    tooltip: 'Add block',
                    color: const Color(0xFF16A34A),
                    onTap: () => _showApartmentDialog(
                        context, notifier, node.site.id),
                  ),
                  // Delete
                  _ActionButton(
                    icon: Icons.delete_outline_rounded,
                    tooltip: 'Delete building',
                    color: const Color(0xFFDC2626),
                    onTap: () => _confirmDeleteSite(context, notifier, node),
                  ),
                  // Expand chevron
                  AnimatedRotation(
                    turns: node.isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF94A3B8), size: 20),
                  ),
                ],
              ),
            ),
          ),

          // ── Expanded apartments ──────────────────────────────────────────
          if (node.isExpanded || node.isLoadingApartments) ...[
            const Divider(height: 1, indent: 20, endIndent: 20),
            if (node.isLoadingApartments)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                    child:
                        CircularProgressIndicator(strokeWidth: 2)),
              )
            else if (node.apartments.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.apartment_outlined,
                          size: 36, color: Colors.grey.shade300),
                      const SizedBox(height: 8),
                      const Text(
                        'No blocks yet — tap + to add one.',
                        style: TextStyle(
                            fontSize: 13, color: Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: node.apartments.length,
                separatorBuilder: (_, _) =>
                    const Divider(height: 1, indent: 20, endIndent: 20),
                itemBuilder: (_, i) => _ApartmentTile(
                  siteId: node.site.id,
                  node: node.apartments[i],
                  notifier: notifier,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Apartment Tile (Level 2)
// ─────────────────────────────────────────────────────────────────────────────

class _ApartmentTile extends StatelessWidget {
  const _ApartmentTile({
    required this.siteId,
    required this.node,
    required this.notifier,
  });

  final String siteId;
  final ApartmentNode node;
  final BuildingsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final apt = node.apartment;
    return Column(
      children: [
        // Apartment header
        InkWell(
          onTap: () => notifier.toggleApartment(siteId, apt.id),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(36, 12, 12, 12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.corporate_fare_rounded,
                      color: Color(0xFF16A34A), size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            apt.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          if (apt.blockName?.isNotEmpty == true) ...[
                            const SizedBox(width: 6),
                            _SmallBadge(apt.blockName!,
                                bg: const Color(0xFFF1F5F9),
                                fg: const Color(0xFF475569)),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${apt.floors} kat · ${apt.flats} daire',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add flat button
                _ActionButton(
                  icon: Icons.add_rounded,
                  tooltip: 'Add flat',
                  color: const Color(0xFF0284C7),
                  onTap: () =>
                      _showFlatDialog(context, notifier, siteId, apt),
                ),
                // Edit
                _ActionButton(
                  icon: Icons.edit_rounded,
                  tooltip: 'Edit block',
                  onTap: () => _showApartmentDialog(
                    context,
                    notifier,
                    siteId,
                    existing: apt,
                  ),
                ),
                // Delete
                _ActionButton(
                  icon: Icons.delete_outline_rounded,
                  tooltip: 'Delete block',
                  color: const Color(0xFFDC2626),
                  onTap: () => _confirmDeleteApartment(
                      context, notifier, siteId, node),
                ),
                // Expand chevron
                AnimatedRotation(
                  turns: node.isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF94A3B8), size: 18),
                ),
              ],
            ),
          ),
        ),

        // Flats list
        if (node.isExpanded || node.isLoadingFlats)
          node.isLoadingFlats
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2)),
                )
              : node.flats.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(48, 8, 16, 16),
                      child: Text(
                        'No flats yet.',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade400,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  : _FlatsGrid(
                      siteId: siteId,
                      aptId: apt.id,
                      flats: node.flats,
                      notifier: notifier,
                    ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Flats grid (Level 3)
// ─────────────────────────────────────────────────────────────────────────────

class _FlatsGrid extends StatelessWidget {
  const _FlatsGrid({
    required this.siteId,
    required this.aptId,
    required this.flats,
    required this.notifier,
  });

  final String siteId;
  final String aptId;
  final List<FlatModel> flats;
  final BuildingsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 4, 20, 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: flats
            .map((f) => _FlatChip(
                  flat: f,
                  siteId: siteId,
                  aptId: aptId,
                  notifier: notifier,
                ))
            .toList(),
      ),
    );
  }
}

class _FlatChip extends StatelessWidget {
  const _FlatChip({
    required this.flat,
    required this.siteId,
    required this.aptId,
    required this.notifier,
  });

  final FlatModel flat;
  final String siteId;
  final String aptId;
  final BuildingsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, icon) = switch (flat.status) {
      FlatStatus.occupied => (
          const Color(0xFFDCFCE7),
          const Color(0xFF15803D),
          Icons.person_rounded,
        ),
      FlatStatus.vacant => (
          const Color(0xFFF1F5F9),
          const Color(0xFF475569),
          Icons.door_front_door_rounded,
        ),
    };

    return Tooltip(
      message: 'Flat ${flat.flat} · ${flat.status.name}',
      child: GestureDetector(
        onLongPress: () =>
            _confirmDeleteFlat(context, notifier, siteId, aptId, flat),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: fg.withValues(alpha: 0.25)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: fg),
              const SizedBox(width: 4),
              Text(
                'No. ${flat.flat}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: fg,
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
// Shared small widgets
// ─────────────────────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.onTap,
    this.tooltip = '',
    this.color,
  });

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
          child: Icon(
            icon,
            size: 18,
            color: color ?? const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}

class _SmallBadge extends StatelessWidget {
  const _SmallBadge(this.text, {required this.bg, required this.fg});
  final String text;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty / Error states
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.domain_outlined, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text(
            'No buildings yet',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF334155)),
          ),
          const SizedBox(height: 6),
          const Text(
            'Add your first building to get started.',
            style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('New Building'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
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
          const Text('Failed to load buildings',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334155))),
          const SizedBox(height: 6),
          Text(message,
              style: const TextStyle(
                  fontSize: 13, color: Color(0xFF94A3B8)),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text('Retry'),
            style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dialogs — Site
// ─────────────────────────────────────────────────────────────────────────────

void _showSiteDialog(
  BuildContext context,
  BuildingsNotifier notifier, {
  SiteModel? existing,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _SiteDialog(notifier: notifier, existing: existing),
  );
}

class _SiteDialog extends StatefulWidget {
  const _SiteDialog({required this.notifier, this.existing});
  final BuildingsNotifier notifier;
  final SiteModel? existing;

  @override
  State<_SiteDialog> createState() => _SiteDialogState();
}

class _SiteDialogState extends State<_SiteDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _address;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.existing?.name);
    _address = TextEditingController(text: widget.existing?.address);
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final ok = widget.existing == null
        ? await widget.notifier.createSite(
            name: _name.text.trim(),
            address: _address.text.trim(),
          )
        : await widget.notifier.updateSite(
            widget.existing!.id,
            name: _name.text.trim(),
            address: _address.text.trim(),
          );

    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.notifier.error ?? 'Operation failed'),
          backgroundColor: const Color(0xFFDC2626),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return _StyledDialog(
      title: isEdit ? 'Edit Building' : 'New Building',
      icon: isEdit ? Icons.edit_rounded : Icons.domain_add_rounded,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DialogField(
              controller: _name,
              label: 'Building Name',
              hint: 'e.g. Lale Sitesi',
              icon: Icons.domain_rounded,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),
            _DialogField(
              controller: _address,
              label: 'Address',
              hint: 'e.g. Atatürk Mah. No:1, İstanbul',
              icon: Icons.location_on_rounded,
            ),
            const SizedBox(height: 24),
            _DialogActions(
              saving: _saving,
              onCancel: () => Navigator.of(context).pop(),
              onSave: _save,
              saveLabel: isEdit ? 'Update' : 'Create',
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dialogs — Apartment
// ─────────────────────────────────────────────────────────────────────────────

void _showApartmentDialog(
  BuildContext context,
  BuildingsNotifier notifier,
  String siteId, {
  ApartmentModel? existing,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ApartmentDialog(
      notifier: notifier,
      siteId: siteId,
      existing: existing,
    ),
  );
}

class _ApartmentDialog extends StatefulWidget {
  const _ApartmentDialog({
    required this.notifier,
    required this.siteId,
    this.existing,
  });
  final BuildingsNotifier notifier;
  final String siteId;
  final ApartmentModel? existing;

  @override
  State<_ApartmentDialog> createState() => _ApartmentDialogState();
}

class _ApartmentDialogState extends State<_ApartmentDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _blockName;
  late final TextEditingController _address;
  late final TextEditingController _floors;
  late final TextEditingController _flats;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?.name);
    _blockName = TextEditingController(text: e?.blockName);
    _address = TextEditingController(text: e?.address);
    _floors = TextEditingController(text: e?.floors.toString() ?? '');
    _flats = TextEditingController(text: e?.flats.toString() ?? '');
  }

  @override
  void dispose() {
    for (final c in [_name, _blockName, _address, _floors, _flats]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final ok = widget.existing == null
        ? await widget.notifier.createApartment(
            siteId: widget.siteId,
            name: _name.text.trim(),
            floors: int.parse(_floors.text),
            flats: int.parse(_flats.text),
            blockName: _blockName.text.trim(),
            address: _address.text.trim(),
          )
        : await widget.notifier.updateApartment(
            widget.siteId,
            widget.existing!.id,
            name: _name.text.trim(),
            floors: int.parse(_floors.text),
            flats: int.parse(_flats.text),
            blockName: _blockName.text.trim(),
            address: _address.text.trim(),
          );

    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.notifier.error ?? 'Operation failed'),
          backgroundColor: const Color(0xFFDC2626),
        ),
      );
    }
  }

  String? _positiveInt(String? v) {
    if (v == null || v.isEmpty) return 'Required';
    final n = int.tryParse(v);
    if (n == null || n <= 0) return 'Enter a positive number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return _StyledDialog(
      title: isEdit ? 'Edit Block' : 'New Block',
      icon:
          isEdit ? Icons.edit_rounded : Icons.add_business_rounded,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DialogField(
              controller: _name,
              label: 'Block Name',
              hint: 'e.g. A Blok',
              icon: Icons.corporate_fare_rounded,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),
            _DialogField(
              controller: _blockName,
              label: 'Block Label (optional)',
              hint: 'e.g. A Block',
              icon: Icons.label_rounded,
            ),
            const SizedBox(height: 12),
            _DialogField(
              controller: _address,
              label: 'Address (optional)',
              hint: 'Block address',
              icon: Icons.location_on_rounded,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _DialogField(
                    controller: _floors,
                    label: 'Floors',
                    hint: '8',
                    icon: Icons.layers_rounded,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: _positiveInt,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DialogField(
                    controller: _flats,
                    label: 'Total Flats',
                    hint: '32',
                    icon: Icons.door_front_door_rounded,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: _positiveInt,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _DialogActions(
              saving: _saving,
              onCancel: () => Navigator.of(context).pop(),
              onSave: _save,
              saveLabel: isEdit ? 'Update' : 'Create',
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dialogs — Flat
// ─────────────────────────────────────────────────────────────────────────────

void _showFlatDialog(
  BuildContext context,
  BuildingsNotifier notifier,
  String siteId,
  ApartmentModel apt,
) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) =>
        _FlatDialog(notifier: notifier, siteId: siteId, apartment: apt),
  );
}

class _FlatDialog extends StatefulWidget {
  const _FlatDialog({
    required this.notifier,
    required this.siteId,
    required this.apartment,
  });
  final BuildingsNotifier notifier;
  final String siteId;
  final ApartmentModel apartment;

  @override
  State<_FlatDialog> createState() => _FlatDialogState();
}

class _FlatDialogState extends State<_FlatDialog> {
  final _formKey = GlobalKey<FormState>();
  final _flatNo = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _flatNo.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final ok = await widget.notifier.createFlat(
      siteId: widget.siteId,
      apartmentId: widget.apartment.id,
      flatNumber: int.parse(_flatNo.text),
    );

    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.notifier.error ?? 'Operation failed'),
          backgroundColor: const Color(0xFFDC2626),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _StyledDialog(
      title: 'Add Flat',
      icon: Icons.door_front_door_rounded,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Adding flat to: ${widget.apartment.name}',
              style: const TextStyle(
                  fontSize: 13, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),
            _DialogField(
              controller: _flatNo,
              label: 'Flat Number',
              hint: 'e.g. 14',
              icon: Icons.tag_rounded,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                final n = int.tryParse(v);
                if (n == null || n <= 0) return 'Enter a positive number';
                return null;
              },
            ),
            const SizedBox(height: 24),
            _DialogActions(
              saving: _saving,
              onCancel: () => Navigator.of(context).pop(),
              onSave: _save,
              saveLabel: 'Add Flat',
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Delete confirmations
// ─────────────────────────────────────────────────────────────────────────────

void _confirmDeleteSite(
  BuildContext context,
  BuildingsNotifier notifier,
  SiteNode node,
) {
  _showConfirm(
    context,
    title: 'Delete Building?',
    content:
        'This will permanently delete "${node.site.name}" and all its blocks/flats.',
    onConfirm: () => notifier.deleteSite(node.site.id),
  );
}

void _confirmDeleteApartment(
  BuildContext context,
  BuildingsNotifier notifier,
  String siteId,
  ApartmentNode node,
) {
  _showConfirm(
    context,
    title: 'Delete Block?',
    content:
        'This will permanently delete "${node.apartment.name}" and all its flats.',
    onConfirm: () => notifier.deleteApartment(siteId, node.apartment.id),
  );
}

void _confirmDeleteFlat(
  BuildContext context,
  BuildingsNotifier notifier,
  String siteId,
  String aptId,
  FlatModel flat,
) {
  _showConfirm(
    context,
    title: 'Delete Flat No. ${flat.flat}?',
    content: 'This action cannot be undone.',
    onConfirm: () => notifier.deleteFlat(siteId, aptId, flat.id),
  );
}

void _showConfirm(
  BuildContext context, {
  required String title,
  required String content,
  required Future<bool> Function() onConfirm,
}) {
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      title: Text(title),
      content: Text(content),
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
            await onConfirm();
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable dialog shell
// ─────────────────────────────────────────────────────────────────────────────

class _StyledDialog extends StatelessWidget {
  const _StyledDialog({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title bar
            Container(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
              color: AppColors.primary,
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

// Form field wrapper
class _DialogField extends StatelessWidget {
  const _DialogField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}

// Dialog action buttons
class _DialogActions extends StatelessWidget {
  const _DialogActions({
    required this.saving,
    required this.onCancel,
    required this.onSave,
    required this.saveLabel,
  });

  final bool saving;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String saveLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: saving ? null : onCancel,
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: saving ? null : onSave,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(saveLabel,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
