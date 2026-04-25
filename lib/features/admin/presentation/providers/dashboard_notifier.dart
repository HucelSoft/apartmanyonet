import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/features/site/data/models/site_model.dart';
import 'package:apartmanyonet/features/transaction/data/models/transaction_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Display DTO
// ─────────────────────────────────────────────────────────────────────────────

/// A display-ready row that combines a raw [TransactionModel] with labels
/// extracted from its expanded PocketBase relations.
class TransactionRow {
  const TransactionRow({
    required this.transaction,
    required this.typeName,
    required this.flatLabel,
  });

  /// The raw transaction record.
  final TransactionModel transaction;

  /// Human-readable type label from the expanded `type` relation
  /// (e.g. "Aidat", "Kira"). Falls back to the raw relation ID.
  final String typeName;

  /// Flat-number label from the expanded `flat` relation
  /// (e.g. "No. 12"). Falls back to the raw relation ID.
  final String flatLabel;
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifier
// ─────────────────────────────────────────────────────────────────────────────

/// Manages data for the Admin Dashboard:
///   1. Loads all sites belonging to the admin's organisation.
///   2. Auto-selects the first site and fetches its transactions.
///   3. Supports switching sites and filtering by [RecordStatus].
///
/// Provide this locally inside [AdminDashboardPage] so it is disposed
/// automatically when the page leaves the tree (no need to register in main).
class DashboardNotifier extends ChangeNotifier {
  DashboardNotifier({required PocketBase pb, required String organizationId})
    : _pb = pb,
      _organizationId = organizationId {
    _init();
  }

  final PocketBase _pb;
  final String _organizationId;

  // ── Raw state ───────────────────────────────────────────────────────────────
  bool _isLoading = false;
  String? _error;
  List<SiteModel> _sites = [];
  SiteModel? _selectedSite;
  List<TransactionRow> _allRows = [];
  RecordStatus? _statusFilter; // null = show all

  // ── Public getters ──────────────────────────────────────────────────────────
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<SiteModel> get sites => _sites;
  SiteModel? get selectedSite => _selectedSite;
  RecordStatus? get statusFilter => _statusFilter;

  /// Transactions visible in the current table (after status filter applied).
  List<TransactionRow> get rows => _statusFilter == null
      ? List.unmodifiable(_allRows)
      : _allRows
            .where((r) => r.transaction.status == _statusFilter)
            .toList(growable: false);

  // ── Stats (always computed over ALL rows, independent of filter) ────────────
  int get totalCount => _allRows.length;
  int get completedCount => _allRows
      .where((r) => r.transaction.status == RecordStatus.completed)
      .length;
  int get pendingCount => _allRows
      .where((r) => r.transaction.status == RecordStatus.pending)
      .length;

  double get collectedAmount => _allRows
      .where((r) => r.transaction.status == RecordStatus.completed)
      .fold(0.0, (sum, r) => sum + (r.transaction.amount ?? 0));

  double get pendingAmount => _allRows
      .where((r) => r.transaction.status == RecordStatus.pending)
      .fold(0.0, (sum, r) => sum + (r.transaction.amount ?? 0));

  // ── Actions ─────────────────────────────────────────────────────────────────

  /// Switch the active site and reload transactions.
  void selectSite(SiteModel site) {
    if (site.id == _selectedSite?.id) return;
    _selectedSite = site;
    _fetchTransactions();
  }

  /// Set (or clear when [null]) the status filter chip.
  void setStatusFilter(RecordStatus? status) {
    _statusFilter = status;
    notifyListeners();
  }

  /// Force-refresh the transaction list for the selected site.
  Future<void> refresh() => _fetchTransactions();

  // ── Private helpers ─────────────────────────────────────────────────────────

  /// Boot sequence: load sites → auto-select first → load transactions.
  Future<void> _init() async {
    _setLoading(true);
    try {
      final result = await _pb
          .collection(SiteModel.collectionName)
          .getList(
            perPage: 200,
            filter: 'organization = "$_organizationId"',
            sort: 'name',
          );
      _sites = result.items.map((r) => SiteModel.fromJson(r.toJson())).toList();

      if (_sites.isNotEmpty) {
        _selectedSite = _sites.first;
        // Fetch without a second _setLoading(false) so we dispatch once.
        await _fetchTransactions(notifyAtEnd: false);
      }
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> _fetchTransactions({bool notifyAtEnd = true}) async {
    if (_selectedSite == null) return;
    _error = null;
    if (notifyAtEnd) _setLoading(true);

    try {
      final result = await _pb
          .collection(TransactionModel.collectionName)
          .getList(
            perPage: 500,
            filter: 'site = "${_selectedSite!.id}"',
            sort: '-date',
            expand: 'type,flat',
          );

      _allRows = result.items.map(_toRow).toList();
    } catch (e) {
      _error = e.toString();
    }

    if (notifyAtEnd) _setLoading(false);
  }

  /// Maps a raw [RecordModel] (with optional `expand` data) to a
  /// display-ready [TransactionRow].
  TransactionRow _toRow(RecordModel r) {
    final tx = TransactionModel.fromJson(r.toJson());

    // ── Type name ──────────────────────────────────────────────────────────────
    // Use the SDK's recommended get<T>('expand.field') API instead of the
    // deprecated `.expand` Map accessor.
    final typeList = r.get<List<RecordModel>>('expand.type');
    final typeName = typeList.isNotEmpty
        ? (typeList.first.data['type'] as String? ?? tx.type)
        : tx.type;

    // ── Flat label ─────────────────────────────────────────────────────────────
    final flatList = r.get<List<RecordModel>>('expand.flat');
    final flatLabel = flatList.isNotEmpty
        ? 'No. ${flatList.first.data['flat']}'
        : tx.flat;

    return TransactionRow(
      transaction: tx,
      typeName: typeName,
      flatLabel: flatLabel,
    );
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
