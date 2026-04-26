import 'package:flutter/foundation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/features/apartments/data/models/apartment_model.dart';
import 'package:apartmanyonet/features/flats/data/models/flat_model.dart';
import 'package:apartmanyonet/features/site/data/models/site_model.dart';
import 'package:apartmanyonet/features/transaction/data/models/transaction_type_model.dart';
import 'package:apartmanyonet/features/transaction/data/repositories/transaction_repository.dart';

/// State for [TransactionsNotifier].
class TransactionsNotifier extends ChangeNotifier {
  TransactionsNotifier(this._repo) {
    Future.microtask(_loadAll);
  }

  final TransactionRepository _repo;

  // ── List state ─────────────────────────────────────────────────────────────
  bool _isLoading = false;
  String? _error;
  List<TransactionItem> _all = [];

  // ── Active filters ─────────────────────────────────────────────────────────
  RecordStatus? _statusFilter;
  String? _siteFilter; // site ID

  // ── Form lookup caches ─────────────────────────────────────────────────────
  List<TransactionTypeModel> _types = [];
  List<SiteModel> _sites = [];

  /// Apartments loaded lazily when user picks a site in the dialog.
  List<ApartmentModel> _apartments = [];

  /// Flats loaded lazily when user picks an apartment in the dialog.
  List<FlatModel> _flats = [];

  // ── Getters ────────────────────────────────────────────────────────────────
  bool get isLoading => _isLoading;
  String? get error => _error;
  RecordStatus? get statusFilter => _statusFilter;
  String? get siteFilter => _siteFilter;

  List<TransactionTypeModel> get types => _types;
  List<SiteModel> get sites => _sites;
  List<ApartmentModel> get apartments => _apartments;
  List<FlatModel> get flats => _flats;

  /// Filtered view — applied entirely in memory for instant response.
  List<TransactionItem> get items {
    var result = _all;
    if (_statusFilter != null) {
      result =
          result.where((t) => t.transaction.status == _statusFilter).toList();
    }
    if (_siteFilter != null) {
      result = result.where((t) => t.transaction.site == _siteFilter).toList();
    }
    return result;
  }

  // ── Stats (always over full list) ──────────────────────────────────────────
  int get totalCount => _all.length;
  double get totalCollected => _all
      .where((t) => t.transaction.status == RecordStatus.completed)
      .fold(0.0, (s, t) => s + (t.transaction.amount ?? 0));
  double get totalPending => _all
      .where((t) => t.transaction.status == RecordStatus.pending)
      .fold(0.0, (s, t) => s + (t.transaction.amount ?? 0));

  // ── Filter actions ─────────────────────────────────────────────────────────
  void setStatusFilter(RecordStatus? s) {
    _statusFilter = s;
    notifyListeners();
  }

  void setSiteFilter(String? id) {
    _siteFilter = id;
    notifyListeners();
  }

  // ── Dialog helpers ─────────────────────────────────────────────────────────

  /// Load apartments for the selected site in the create/edit dialog.
  Future<void> loadApartmentsForSite(String siteId) async {
    _apartments = await _repo.fetchApartments(siteId);
    _flats = [];
    notifyListeners();
  }

  /// Load flats for the selected apartment in the create/edit dialog.
  Future<void> loadFlatsForApartment(String apartmentId) async {
    _flats = await _repo.fetchFlats(apartmentId);
    notifyListeners();
  }

  void clearApartmentsAndFlats() {
    _apartments = [];
    _flats = [];
    notifyListeners();
  }

  // ── CRUD ──────────────────────────────────────────────────────────────────

  Future<void> refresh() => _loadAll();

  Future<bool> createTransaction({
    required String typeId,
    required String siteId,
    required String apartmentId,
    required String flatId,
    required double amount,
    required DateTime date,
    required RecordStatus status,
    String? description,
    DateTime? dueDate,
    DateTime? paymentDate,
  }) async {
    try {
      final item = await _repo.createTransaction(
        typeId: typeId,
        siteId: siteId,
        apartmentId: apartmentId,
        flatId: flatId,
        amount: amount,
        date: date,
        status: status,
        description: description,
        dueDate: dueDate,
        paymentDate: paymentDate,
      );
      _all.insert(0, item);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTransaction(
    String id, {
    required String typeId,
    required String siteId,
    required String apartmentId,
    required String flatId,
    required double amount,
    required DateTime date,
    required RecordStatus status,
    String? description,
    DateTime? dueDate,
    DateTime? paymentDate,
  }) async {
    try {
      final updated = await _repo.updateTransaction(
        id,
        typeId: typeId,
        siteId: siteId,
        apartmentId: apartmentId,
        flatId: flatId,
        amount: amount,
        date: date,
        status: status,
        description: description,
        dueDate: dueDate,
        paymentDate: paymentDate,
      );
      final idx = _all.indexWhere((t) => t.id == id);
      if (idx != -1) _all[idx] = updated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTransaction(String id) async {
    try {
      await _repo.deleteTransaction(id);
      _all.removeWhere((t) => t.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ── Transaction Type CRUD ──────────────────────────────────────────────────

  String? _typeError;
  String? get typeError => _typeError;

  Future<void> refreshTypes() async {
    _types = await _repo.fetchTypes();
    notifyListeners();
  }

  Future<bool> createType({
    required String name,
    required TransactionGenre genre,
    String? description,
  }) async {
    try {
      final created = await _repo.createType(
        name: name,
        genre: genre,
        description: description,
      );
      _types = [..._types, created]
        ..sort((a, b) => a.type.compareTo(b.type));
      _typeError = null;
      notifyListeners();
      return true;
    } catch (e) {
      _typeError = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateType(
    String id, {
    required String name,
    required TransactionGenre genre,
    String? description,
  }) async {
    try {
      final updated = await _repo.updateType(
        id,
        name: name,
        genre: genre,
        description: description,
      );
      final idx = _types.indexWhere((t) => t.id == id);
      if (idx != -1) {
        _types = List.of(_types)..[idx] = updated;
        _types.sort((a, b) => a.type.compareTo(b.type));
      }
      _typeError = null;
      notifyListeners();
      return true;
    } catch (e) {
      _typeError = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteType(String id) async {
    try {
      await _repo.deleteType(id);
      _types = _types.where((t) => t.id != id).toList();
      _typeError = null;
      notifyListeners();
      return true;
    } catch (e) {
      _typeError = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ── Private ────────────────────────────────────────────────────────────────

  Future<void> _loadAll() async {
    _setLoading(true);
    try {
      final results = await Future.wait([
        _repo.listTransactions(),
        _repo.fetchTypes(),
        _repo.fetchSites(),
      ]);
      _all = results[0] as List<TransactionItem>;
      _types = results[1] as List<TransactionTypeModel>;
      _sites = results[2] as List<SiteModel>;
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
