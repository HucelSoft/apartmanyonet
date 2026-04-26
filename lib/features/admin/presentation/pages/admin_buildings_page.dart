import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/network/pocketbase_client.dart';
import 'package:apartmanyonet/features/admin/presentation/providers/buildings_notifier.dart';
import 'package:apartmanyonet/features/apartments/data/models/apartment_model.dart';
import 'package:apartmanyonet/features/auth/presentation/providers/auth_notifier.dart';
import 'package:apartmanyonet/features/flats/data/models/flat_model.dart';
import 'package:apartmanyonet/features/site/data/models/site_model.dart';
import 'package:apartmanyonet/features/site/data/repositories/building_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Design tokens (Architectural Lens — from Stitch "Apex Facility" system)
// ─────────────────────────────────────────────────────────────────────────────

class _C {
  static const bg = Color(0xFFF6FAFE);
  static const surface = Colors.white;
  static const surfaceLow = Color(0xFFF0F4F8);
  static const surfaceHigh = Color(0xFFE4E9ED);
  static const primary = Color(0xFF005BAF);
  static const primaryLight = Color(0xFFD5E3FF);
  static const onSurface = Color(0xFF171C1F);
  static const onSurfaceVar = Color(0xFF414753);
  static const outline = Color(0xFFC1C6D5);

  // Status
  static const occupiedBg = Color(0xFFDCFCE7);
  static const occupiedFg = Color(0xFF15803D);
  static const emptyBg = Color(0xFFDFE3E7);
  static const emptyFg = Color(0xFF414753);
  static const maintenanceBg = Color(0xFFFFDBC9);
  static const maintenanceFg = Color(0xFF964400);

  static const shadow = Color(0x0F171C1F);
}

const _kLeftPanelWidth = 340.0;

// ─────────────────────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────────────────────

class AdminBuildingsPage extends StatelessWidget {
  const AdminBuildingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pb = context.read<PocketBaseService>().pb;
    final orgId = context.read<AuthNotifier>().organizationId ?? '';
    return ChangeNotifierProvider(
      create: (_) => BuildingsNotifier(
        BuildingRepository(pb: pb, organizationId: orgId),
      ),
      child: const _SplitLayout(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Split layout root
// ─────────────────────────────────────────────────────────────────────────────

class _SplitLayout extends StatefulWidget {
  const _SplitLayout();

  @override
  State<_SplitLayout> createState() => _SplitLayoutState();
}

class _SplitLayoutState extends State<_SplitLayout> {
  /// Currently selected block to show on the right panel.
  /// null = show "select a block" placeholder.
  _Selection? _selection;

  void _select(_Selection sel) => setState(() => _selection = sel);
  void _deselect() => setState(() => _selection = null);

  @override
  Widget build(BuildContext context) {
    final n = context.watch<BuildingsNotifier>();

    return Scaffold(
      backgroundColor: _C.bg,
      body: Row(
        children: [
          // ── LEFT: Site / Block tree ─────────────────────────────────────────
          SizedBox(
            width: _kLeftPanelWidth,
            child: _LeftPanel(
              notifier: n,
              selection: _selection,
              onSelect: _select,
              onDeselect: _deselect,
            ),
          ),

          // Thin divider
          Container(width: 1, color: _C.outline.withValues(alpha: 0.2)),

          // ── RIGHT: Flat grid ────────────────────────────────────────────────
          Expanded(
            child: _selection == null
                ? const _EmptySelection()
                : _RightPanel(
                    key: ValueKey(_selection!.apartmentNode.apartment.id),
                    siteNode: _selection!.siteNode,
                    apartmentNode: _selection!.apartmentNode,
                    notifier: n,
                    onApartmentDeleted: _deselect,
                  ),
          ),
        ],
      ),
    );
  }
}

/// Immutable selection state.
class _Selection {
  const _Selection({required this.siteNode, required this.apartmentNode});
  final SiteNode siteNode;
  final ApartmentNode apartmentNode;
}

// ─────────────────────────────────────────────────────────────────────────────
// LEFT PANEL
// ─────────────────────────────────────────────────────────────────────────────

class _LeftPanel extends StatelessWidget {
  const _LeftPanel({
    required this.notifier,
    required this.selection,
    required this.onSelect,
    required this.onDeselect,
  });

  final BuildingsNotifier notifier;
  final _Selection? selection;
  final ValueChanged<_Selection> onSelect;
  final VoidCallback onDeselect;

  @override
  Widget build(BuildContext context) {
    final n = notifier;

    return Container(
      color: _C.surfaceLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _PanelHeader(
            title: 'Portfolio Sites',
            count: n.nodes.length,
            onAdd: () => _showSiteDialog(context, n),
            onRefresh: n.loadSites,
            isLoading: n.isLoading,
          ),

          // Body
          Expanded(
            child: n.isLoading && n.nodes.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(strokeWidth: 2))
                : n.error != null && n.nodes.isEmpty
                    ? _PanelError(message: n.error!, onRetry: n.loadSites)
                    : n.nodes.isEmpty
                        ? _PanelEmpty(
                            onAdd: () => _showSiteDialog(context, n))
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 80),
                            itemCount: n.nodes.length,
                            itemBuilder: (_, i) => _SiteCard(
                              node: n.nodes[i],
                              notifier: n,
                              selection: selection,
                              onSelect: onSelect,
                              onDeselect: onDeselect,
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader({
    required this.title,
    required this.count,
    required this.onAdd,
    required this.onRefresh,
    required this.isLoading,
  });

  final String title;
  final int count;
  final VoidCallback onAdd;
  final VoidCallback onRefresh;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 12),
      decoration: BoxDecoration(
        color: _C.surfaceLow,
        border: Border(bottom: BorderSide(color: _C.outline.withValues(alpha: 0.3))),
      ),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _C.onSurface)),
          Text('$count sites',
              style: const TextStyle(
                  fontSize: 12, color: _C.onSurfaceVar)),
        ]),
        const Spacer(),
        IconButton(
          onPressed: isLoading ? null : onRefresh,
          icon: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.refresh_rounded, size: 18),
          color: _C.onSurfaceVar,
          tooltip: 'Refresh',
        ),
        FilledButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add_rounded, size: 16),
          label: const Text('Add Site',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          style: FilledButton.styleFrom(
            backgroundColor: _C.primary,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Site card (left panel)
// ─────────────────────────────────────────────────────────────────────────────

class _SiteCard extends StatelessWidget {
  const _SiteCard({
    required this.node,
    required this.notifier,
    required this.selection,
    required this.onSelect,
    required this.onDeselect,
  });

  final SiteNode node;
  final BuildingsNotifier notifier;
  final _Selection? selection;
  final ValueChanged<_Selection> onSelect;
  final VoidCallback onDeselect;

  bool get _isActive =>
      selection != null && selection!.siteNode.site.id == node.site.id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            width: 4,
            color: _isActive ? _C.primary : Colors.transparent,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: _C.shadow,
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Site header row
          InkWell(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10)),
            onTap: () => notifier.toggleSite(node.site.id),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 8, 10),
              child: Row(children: [
                // Avatar
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _C.primaryLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.domain_rounded,
                      size: 18, color: _C.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(node.site.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13.5,
                                color: _C.onSurface),
                            overflow: TextOverflow.ellipsis),
                        if (node.site.address?.isNotEmpty ?? false)
                          Text(node.site.address!,
                              style: const TextStyle(
                                  fontSize: 11, color: _C.onSurfaceVar),
                              overflow: TextOverflow.ellipsis),
                      ]),
                ),
                // Edit / Delete
                _SmallIconBtn(
                  icon: Icons.edit_rounded,
                  tooltip: 'Edit',
                  onTap: () => _showSiteDialog(context, notifier,
                      existing: node.site),
                ),
                _SmallIconBtn(
                  icon: Icons.delete_outline_rounded,
                  tooltip: 'Delete',
                  color: const Color(0xFFDC2626),
                  onTap: () => _confirmDeleteSite(context, notifier, node),
                ),
                Icon(
                  node.isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: _C.onSurfaceVar,
                ),
              ]),
            ),
          ),

          // Stats row
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: Row(children: [
              _StatChip(Icons.apartment_rounded,
                  '${node.apartments.length} blocks'),
              const SizedBox(width: 8),
              _StatChip(
                  Icons.door_front_door_rounded,
                  '${node.apartments.fold(0, (s, a) => s + a.flats.length)} flats'),
            ]),
          ),

          // Expanded block list
          if (node.isExpanded) ...[
            Divider(
                height: 1,
                color: _C.outline.withValues(alpha: 0.3),
                indent: 12,
                endIndent: 12),
            const SizedBox(height: 4),
            if (node.isLoadingApartments)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2)),
              )
            else ...[
              ...node.apartments.map((aptNode) => _BlockRow(
                    siteNode: node,
                    aptNode: aptNode,
                    notifier: notifier,
                    isSelected: selection?.apartmentNode.apartment.id ==
                        aptNode.apartment.id,
                    onTap: () {
                      // Auto-load flats when selecting a block
                      if (aptNode.flats.isEmpty) {
                        notifier
                            .toggleApartment(
                                node.site.id, aptNode.apartment.id)
                            .then((_) {
                          onSelect(_Selection(
                              siteNode: node, apartmentNode: aptNode));
                        });
                      } else {
                        onSelect(_Selection(
                            siteNode: node, apartmentNode: aptNode));
                      }
                    },
                    onDeselect: onDeselect,
                  )),
              // + Add Block
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                child: TextButton.icon(
                  onPressed: () =>
                      _showApartmentDialog(context, notifier, node.site.id),
                  icon: const Icon(Icons.add_rounded, size: 14),
                  label: const Text('Add Block',
                      style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                    foregroundColor: _C.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Block row inside expanded site
// ─────────────────────────────────────────────────────────────────────────────

class _BlockRow extends StatelessWidget {
  const _BlockRow({
    required this.siteNode,
    required this.aptNode,
    required this.notifier,
    required this.isSelected,
    required this.onTap,
    required this.onDeselect,
  });

  final SiteNode siteNode;
  final ApartmentNode aptNode;
  final BuildingsNotifier notifier;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDeselect;

  @override
  Widget build(BuildContext context) {
    final apt = aptNode.apartment;

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? _C.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isSelected ? _C.primaryLight : _C.surfaceHigh,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.business_rounded,
                size: 14,
                color: isSelected ? _C.primary : _C.onSurfaceVar),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(apt.name,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? _C.primary : _C.onSurface)),
                Text('${aptNode.flats.length} flats',
                    style: const TextStyle(
                        fontSize: 11, color: _C.onSurfaceVar)),
              ],
            ),
          ),
          _SmallIconBtn(
            icon: Icons.edit_rounded,
            tooltip: 'Edit block',
            onTap: () => _showApartmentDialog(
              context,
              notifier,
              siteNode.site.id,
              existing: apt,
            ),
          ),
          _SmallIconBtn(
            icon: Icons.delete_outline_rounded,
            tooltip: 'Delete block',
            color: const Color(0xFFDC2626),
            onTap: () => _confirmDeleteApartment(
                context, notifier, siteNode, aptNode, onDeselect),
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 16,
            color: isSelected ? _C.primary : _C.onSurfaceVar,
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RIGHT PANEL — Flat grid
// ─────────────────────────────────────────────────────────────────────────────

class _RightPanel extends StatelessWidget {
  const _RightPanel({
    super.key,
    required this.siteNode,
    required this.apartmentNode,
    required this.notifier,
    required this.onApartmentDeleted,
  });

  final SiteNode siteNode;
  final ApartmentNode apartmentNode;
  final BuildingsNotifier notifier;
  final VoidCallback onApartmentDeleted;

  @override
  Widget build(BuildContext context) {
    final apt = apartmentNode.apartment;
    final flats = apartmentNode.flats;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 14),
          color: _C.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              Row(children: [
                const Icon(Icons.domain_rounded,
                    size: 14, color: _C.onSurfaceVar),
                const SizedBox(width: 4),
                Text(siteNode.site.name,
                    style: const TextStyle(
                        fontSize: 12, color: _C.onSurfaceVar)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.chevron_right_rounded,
                      size: 14, color: _C.onSurfaceVar),
                ),
                Text(apt.name,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _C.onSurface)),
              ]),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Block title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(apt.name,
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: _C.onSurface,
                              letterSpacing: -0.5)),
                      Row(children: [
                        _MetaBadge(
                            label: '${flats.length} Total Units'),
                        const SizedBox(width: 8),
                        _MetaBadge(
                            label:
                                '${flats.where((f) => f.status == FlatStatus.occupied).length} Occupied',
                            color: _C.occupiedFg),
                        const SizedBox(width: 8),
                        _MetaBadge(
                            label:
                                '${flats.where((f) => f.status == FlatStatus.empty).length} Empty',
                            color: _C.onSurfaceVar),
                        if (flats.any((f) =>
                            f.status == FlatStatus.maintenance)) ...[
                          const SizedBox(width: 8),
                          _MetaBadge(
                              label:
                                  '${flats.where((f) => f.status == FlatStatus.maintenance).length} Maintenance',
                              color: _C.maintenanceFg),
                        ],
                      ]),
                    ],
                  ),
                  const Spacer(),
                  // Actions
                  OutlinedButton.icon(
                    onPressed: () => _showApartmentDialog(
                      context,
                      notifier,
                      siteNode.site.id,
                      existing: apt,
                    ),
                    icon: const Icon(Icons.edit_rounded, size: 14),
                    label: const Text('Edit Block',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _C.onSurfaceVar,
                      side: const BorderSide(color: _C.outline),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () => _showFlatDialog(
                      context,
                      notifier,
                      siteId: siteNode.site.id,
                      apartmentId: apt.id,
                    ),
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: const Text('Add Flat',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    style: FilledButton.styleFrom(
                      backgroundColor: _C.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Divider(height: 1, color: _C.outline.withValues(alpha: 0.3)),

        // ── Flat grid body ───────────────────────────────────────────────────
        Expanded(
          child: apartmentNode.isLoadingFlats
              ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
              : flats.isEmpty
                  ? _EmptyFlats(
                      onAdd: () => _showFlatDialog(
                        context,
                        notifier,
                        siteId: siteNode.site.id,
                        apartmentId: apt.id,
                      ),
                    )
                  : _FlatGrid(
                      flats: flats,
                      siteId: siteNode.site.id,
                      apartmentId: apt.id,
                      notifier: notifier,
                    ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Flat grid
// ─────────────────────────────────────────────────────────────────────────────

class _FlatGrid extends StatelessWidget {
  const _FlatGrid({
    required this.flats,
    required this.siteId,
    required this.apartmentId,
    required this.notifier,
  });

  final List<FlatModel> flats;
  final String siteId;
  final String apartmentId;
  final BuildingsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 130,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: flats.length,
      itemBuilder: (_, i) => _FlatCard(
        flat: flats[i],
        siteId: siteId,
        apartmentId: apartmentId,
        notifier: notifier,
      ),
    );
  }
}

class _FlatCard extends StatefulWidget {
  const _FlatCard({
    required this.flat,
    required this.siteId,
    required this.apartmentId,
    required this.notifier,
  });

  final FlatModel flat;
  final String siteId;
  final String apartmentId;
  final BuildingsNotifier notifier;

  @override
  State<_FlatCard> createState() => _FlatCardState();
}

class _FlatCardState extends State<_FlatCard> {
  bool _hovered = false;

  FlatModel get f => widget.flat;

  (Color bg, Color fg, String label) get _status => switch (f.status) {
        FlatStatus.occupied => (
            _C.occupiedBg,
            _C.occupiedFg,
            'Occupied'
          ),
        FlatStatus.empty => (_C.emptyBg, _C.emptyFg, 'Empty'),
        FlatStatus.maintenance => (
            _C.maintenanceBg,
            _C.maintenanceFg,
            'Maintenance'
          ),
      };

  @override
  Widget build(BuildContext context) {
    final (bg, fg, label) = _status;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        decoration: BoxDecoration(
          color: _hovered ? _C.surfaceLow : _C.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(width: 4, color: fg),
          ),
          boxShadow: [
            BoxShadow(
              color: _C.shadow,
              blurRadius: _hovered ? 16 : 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${f.flat}',
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: _C.onSurface,
                              letterSpacing: -1)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(label,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: fg)),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (f.status == FlatStatus.occupied &&
                      (f.residentName?.isNotEmpty ?? false))
                    Row(children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: _C.primaryLight,
                        child: Text(
                          f.residentName![0].toUpperCase(),
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: _C.primary),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(f.residentName!,
                            style: const TextStyle(
                                fontSize: 11,
                                color: _C.onSurfaceVar,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ])
                  else
                    Text(
                      f.status == FlatStatus.empty
                          ? 'Ready for viewing'
                          : 'Under maintenance',
                      style: const TextStyle(
                          fontSize: 11, color: _C.onSurfaceVar),
                    ),
                ],
              ),
            ),

            // Hover action overlay
            if (_hovered)
              Positioned(
                right: 4,
                top: 4,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _SmallIconBtn(
                      icon: Icons.delete_outline_rounded,
                      tooltip: 'Delete flat',
                      color: const Color(0xFFDC2626),
                      onTap: () => _confirmDeleteFlat(
                          context, widget.notifier, f,
                          siteId: widget.siteId,
                          apartmentId: widget.apartmentId),
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
// Empty / error states
// ─────────────────────────────────────────────────────────────────────────────

class _EmptySelection extends StatelessWidget {
  const _EmptySelection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
              color: _C.primaryLight,
              borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.touch_app_rounded,
              size: 36, color: _C.primary),
        ),
        const SizedBox(height: 20),
        const Text('Select a block to view its flats',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _C.onSurface)),
        const SizedBox(height: 8),
        const Text(
            'Expand a site on the left and pick a block.',
            style: TextStyle(fontSize: 13, color: _C.onSurfaceVar)),
      ]),
    );
  }
}

class _EmptyFlats extends StatelessWidget {
  const _EmptyFlats({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.door_front_door_outlined,
            size: 52, color: _C.outline),
        const SizedBox(height: 16),
        const Text('No flats yet',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _C.onSurface)),
        const SizedBox(height: 8),
        const Text('Add the first flat to this block.',
            style: TextStyle(fontSize: 13, color: _C.onSurfaceVar)),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add_rounded, size: 16),
          label: const Text('Add Flat'),
          style: FilledButton.styleFrom(backgroundColor: _C.primary),
        ),
      ]),
    );
  }
}

class _PanelEmpty extends StatelessWidget {
  const _PanelEmpty({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.domain_disabled_rounded,
              size: 44, color: _C.outline),
          const SizedBox(height: 12),
          const Text('No sites yet',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _C.onSurface)),
          const SizedBox(height: 8),
          const Text('Add your first building site.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: _C.onSurfaceVar)),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add_rounded, size: 16),
            label: const Text('Add Site',
                style: TextStyle(fontSize: 12)),
            style: FilledButton.styleFrom(
              backgroundColor: _C.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ]),
      ),
    );
  }
}

class _PanelError extends StatelessWidget {
  const _PanelError({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.error_outline_rounded,
              size: 40, color: _C.outline),
          const SizedBox(height: 12),
          Text(message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12, color: _C.onSurfaceVar)),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text('Retry',
                style: TextStyle(fontSize: 12)),
            style: FilledButton.styleFrom(backgroundColor: _C.primary),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small helper widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SmallIconBtn extends StatelessWidget {
  const _SmallIconBtn({
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
          padding: const EdgeInsets.all(5),
          child:
              Icon(icon, size: 15, color: color ?? _C.onSurfaceVar),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: _C.surfaceLow,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 11, color: _C.onSurfaceVar),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 11, color: _C.onSurfaceVar,
                fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

class _MetaBadge extends StatelessWidget {
  const _MetaBadge({required this.label, this.color});
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          fontSize: 12,
          color: color ?? _C.onSurfaceVar,
          fontWeight: FontWeight.w500),
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
  late final _name = TextEditingController(text: widget.existing?.name ?? '');
  late final _addr =
      TextEditingController(text: widget.existing?.address ?? '');
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _addr.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final bool ok;
    if (widget.existing == null) {
      ok = await widget.notifier.createSite(
          name: _name.text.trim(), address: _addr.text.trim());
    } else {
      ok = await widget.notifier.updateSite(widget.existing!.id,
          name: _name.text.trim(), address: _addr.text.trim());
    }
    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(widget.notifier.error ?? 'Operation failed'),
        backgroundColor: const Color(0xFFDC2626),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return _FormDialog(
      title: isEdit ? 'Edit Site' : 'Add Site',
      icon: Icons.domain_rounded,
      saving: _saving,
      onSave: _save,
      formKey: _formKey,
      children: [
        _DialogField(
            ctrl: _name,
            label: 'Site Name *',
            hint: 'e.g. Yeşilpark Residences',
            icon: Icons.domain_rounded,
            validator: (v) => (v?.trim().isEmpty ?? true) ? 'Required' : null),
        const SizedBox(height: 14),
        _DialogField(
            ctrl: _addr,
            label: 'Address',
            hint: 'Optional full address',
            icon: Icons.location_on_rounded),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dialogs — Apartment / Block
// ─────────────────────────────────────────────────────────────────────────────

void _showApartmentDialog(
  BuildContext context,
  BuildingsNotifier notifier,
  String siteId, {
  ApartmentModel? existing,
}) {
  showDialog<void>(
    context: context,
    builder: (_) => _ApartmentDialog(
        notifier: notifier, siteId: siteId, existing: existing),
  );
}

class _ApartmentDialog extends StatefulWidget {
  const _ApartmentDialog(
      {required this.notifier, required this.siteId, this.existing});
  final BuildingsNotifier notifier;
  final String siteId;
  final ApartmentModel? existing;

  @override
  State<_ApartmentDialog> createState() => _ApartmentDialogState();
}

class _ApartmentDialogState extends State<_ApartmentDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _name =
      TextEditingController(text: widget.existing?.name ?? '');
  late final _block =
      TextEditingController(text: widget.existing?.blockName ?? '');
  late final _floors = TextEditingController(
      text: (widget.existing?.floors ?? 1).toString());
  late final _flats = TextEditingController(
      text: (widget.existing?.flats ?? 0).toString());
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _block.dispose();
    _floors.dispose();
    _flats.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final bool ok;
    final f = int.tryParse(_floors.text) ?? 1;
    final fl = int.tryParse(_flats.text) ?? 0;
    if (widget.existing == null) {
      ok = await widget.notifier.createApartment(
        siteId: widget.siteId,
        name: _name.text.trim(),
        floors: f,
        flats: fl,
        blockName: _block.text.trim(),
      );
    } else {
      ok = await widget.notifier.updateApartment(
        widget.siteId,
        widget.existing!.id,
        name: _name.text.trim(),
        floors: f,
        flats: fl,
        blockName: _block.text.trim(),
      );
    }
    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(widget.notifier.error ?? 'Failed'),
        backgroundColor: const Color(0xFFDC2626),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return _FormDialog(
      title: isEdit ? 'Edit Block' : 'Add Block',
      icon: Icons.business_rounded,
      saving: _saving,
      onSave: _save,
      formKey: _formKey,
      children: [
        _DialogField(
          ctrl: _name,
          label: 'Block Name *',
          hint: 'e.g. A Blok',
          icon: Icons.business_rounded,
          validator: (v) => (v?.trim().isEmpty ?? true) ? 'Required' : null,
        ),
        const SizedBox(height: 14),
        _DialogField(
            ctrl: _block,
            label: 'Display Label',
            hint: 'e.g. Kuzey Blok',
            icon: Icons.label_rounded),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(
            child: _DialogField(
              ctrl: _floors,
              label: 'Floors *',
              hint: '1',
              icon: Icons.layers_rounded,
              numeric: true,
              validator: (v) {
                final n = int.tryParse(v ?? '');
                if (n == null || n < 1) return 'Min 1';
                return null;
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _DialogField(
              ctrl: _flats,
              label: 'Total Flats',
              hint: '0',
              icon: Icons.door_front_door_rounded,
              numeric: true,
            ),
          ),
        ]),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dialogs — Flat
// ─────────────────────────────────────────────────────────────────────────────

void _showFlatDialog(
  BuildContext context,
  BuildingsNotifier notifier, {
  required String siteId,
  required String apartmentId,
}) {
  showDialog<void>(
    context: context,
    builder: (_) => _FlatDialog(
        notifier: notifier, siteId: siteId, apartmentId: apartmentId),
  );
}

class _FlatDialog extends StatefulWidget {
  const _FlatDialog(
      {required this.notifier,
      required this.siteId,
      required this.apartmentId});
  final BuildingsNotifier notifier;
  final String siteId;
  final String apartmentId;

  @override
  State<_FlatDialog> createState() => _FlatDialogState();
}

class _FlatDialogState extends State<_FlatDialog> {
  final _formKey = GlobalKey<FormState>();
  final _number = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _number.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final ok = await widget.notifier.createFlat(
      siteId: widget.siteId,
      apartmentId: widget.apartmentId,
      flatNumber: int.parse(_number.text),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(widget.notifier.error ?? 'Failed'),
        backgroundColor: const Color(0xFFDC2626),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _FormDialog(
      title: 'Add Flat',
      icon: Icons.door_front_door_rounded,
      saving: _saving,
      onSave: _save,
      formKey: _formKey,
      children: [
        _DialogField(
          ctrl: _number,
          label: 'Flat Number *',
          hint: 'e.g. 101',
          icon: Icons.tag_rounded,
          numeric: true,
          validator: (v) {
            final n = int.tryParse(v ?? '');
            if (n == null || n < 1) return 'Enter a valid number';
            return null;
          },
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared form dialog shell
// ─────────────────────────────────────────────────────────────────────────────

class _FormDialog extends StatelessWidget {
  const _FormDialog({
    required this.title,
    required this.icon,
    required this.saving,
    required this.onSave,
    required this.formKey,
    required this.children,
  });

  final String title;
  final IconData icon;
  final bool saving;
  final VoidCallback onSave;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: 440, minWidth: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title bar
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
              color: _C.primary,
              child: Row(children: [
                Icon(icon, color: Colors.white, size: 18),
                const SizedBox(width: 10),
                Text(title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ]),
            ),
            // Form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed:
                        saving ? null : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: saving ? null : onSave,
                    style: FilledButton.styleFrom(
                      backgroundColor: _C.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : const Text('Save',
                            style:
                                TextStyle(fontWeight: FontWeight.w600)),
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

class _DialogField extends StatelessWidget {
  const _DialogField({
    required this.ctrl,
    required this.label,
    required this.hint,
    required this.icon,
    this.numeric = false,
    this.validator,
  });

  final TextEditingController ctrl;
  final String label;
  final String hint;
  final IconData icon;
  final bool numeric;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151))),
      const SizedBox(height: 6),
      TextFormField(
        controller: ctrl,
        keyboardType: numeric ? TextInputType.number : TextInputType.text,
        inputFormatters:
            numeric ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
          prefixIcon: Icon(icon, size: 18),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        validator: validator,
      ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Confirm delete dialogs
// ─────────────────────────────────────────────────────────────────────────────

void _confirmDeleteSite(
  BuildContext context,
  BuildingsNotifier notifier,
  SiteNode node,
) {
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      title: const Text('Delete Site?'),
      content: Text(
          '"${node.site.name}" and all its blocks/flats will be removed permanently.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626)),
          onPressed: () async {
            Navigator.pop(context);
            await notifier.deleteSite(node.site.id);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

void _confirmDeleteApartment(
  BuildContext context,
  BuildingsNotifier notifier,
  SiteNode siteNode,
  ApartmentNode aptNode,
  VoidCallback onDeselect,
) {
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      title: const Text('Delete Block?'),
      content: Text(
          '"${aptNode.apartment.name}" and all its flats will be removed permanently.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626)),
          onPressed: () async {
            Navigator.pop(context);
            onDeselect();
            await notifier.deleteApartment(
                siteNode.site.id, aptNode.apartment.id);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

void _confirmDeleteFlat(
  BuildContext context,
  BuildingsNotifier notifier,
  FlatModel flat, {
  required String siteId,
  required String apartmentId,
}) {
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      title: const Text('Delete Flat?'),
      content:
          Text('Flat No.${flat.flat} will be permanently removed.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626)),
          onPressed: () async {
            Navigator.pop(context);
            await notifier.deleteFlat(siteId, apartmentId, flat.id);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
