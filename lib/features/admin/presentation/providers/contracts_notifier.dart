import 'package:flutter/foundation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/features/resident/data/models/resident_model.dart';
import 'package:apartmanyonet/features/contract/data/models/contract_model.dart';
import 'package:apartmanyonet/features/contract/data/repositories/contract_repository.dart';
import 'package:apartmanyonet/features/flats/data/models/flat_model.dart';
import 'package:apartmanyonet/features/apartments/data/models/apartment_model.dart';
import 'package:apartmanyonet/features/site/data/models/site_model.dart';
import 'package:apartmanyonet/features/site/data/repositories/building_repository.dart';
import 'package:apartmanyonet/features/owner/data/models/owner_model.dart';
import 'package:apartmanyonet/features/owner/data/repositories/owner_repository.dart';

class ContractsNotifier extends ChangeNotifier {
  ContractsNotifier({
    required ContractRepository contractRepo,
    required BuildingRepository buildingRepo,
    required OwnerRepository ownerRepo,
  })  : _contractRepo = contractRepo,
        _buildingRepo = buildingRepo,
        _ownerRepo = ownerRepo {
    Future.microtask(loadContracts);
  }

  final ContractRepository _contractRepo;
  final BuildingRepository _buildingRepo;
  final OwnerRepository _ownerRepo;

  // ── State ──────────────────────────────────────────────────────────────────
  bool _isLoading = false;
  String? _error;
  List<ContractModel> _contracts = [];

  // ── Selection State (for dialogs) ──────────────────────────────────────────
  List<ResidentModel> _residents = [];
  List<OwnerModel> _owners = [];
  List<SiteModel> _sites = [];
  List<ApartmentModel> _apartments = [];
  List<FlatModel> _flats = [];

  // ── Getters ────────────────────────────────────────────────────────────────
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<ContractModel> get contracts => _contracts;

  List<ResidentModel> get residents => _residents;
  List<OwnerModel> get owners => _owners;
  List<SiteModel> get sites => _sites;
  List<ApartmentModel> get apartments => _apartments;
  List<FlatModel> get flats => _flats;

  // ── CRUD operations ────────────────────────────────────────────────────────

  Future<void> loadContracts() async {
    _setLoading(true);
    try {
      _contracts = await _contractRepo.listContracts();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> prepareFormData() async {
    try {
      _residents = await _contractRepo.listResidents();
      _owners = await _ownerRepo.listOwners();
      _sites = await _buildingRepo.listSites();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadApartments(String siteId) async {
    try {
      _apartments = await _buildingRepo.listApartments(siteId);
      _flats = [];
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadFlats(String apartmentId) async {
    try {
      _flats = await _buildingRepo.listFlats(apartmentId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> createContract({
    required String flatId,
    required String apartmentId,
    required String siteId,
    required String organizationId,
    required String residentId,
    required String ownerId,
    required DateTime start,
    required DateTime end,
    required double amount,
    required int paymentDueDay,
  }) async {
    try {
      final contract = await _contractRepo.createContract(
        flatId: flatId,
        apartmentId: apartmentId,
        siteId: siteId,
        organizationId: organizationId,
        residentId: residentId,
        ownerId: ownerId,
        start: start,
        end: end,
        amount: amount,
        paymentDueDay: paymentDueDay,
      );
      _contracts.insert(0, contract);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateStatus(String id, ContractStatus status) async {
    try {
      final updated = await _contractRepo.updateContract(
        id,
        status: status.name,
      );
      final idx = _contracts.indexWhere((c) => c.id == id);
      if (idx != -1) _contracts[idx] = updated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteContract(String id) async {
    try {
      await _contractRepo.deleteContract(id);
      _contracts.removeWhere((c) => c.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
