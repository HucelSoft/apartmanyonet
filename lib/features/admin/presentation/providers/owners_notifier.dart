import 'package:flutter/material.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/features/owner/data/models/owner_model.dart';
import 'package:apartmanyonet/features/owner/data/repositories/owner_repository.dart';

class OwnersNotifier extends ChangeNotifier {
  OwnersNotifier({required OwnerRepository repository})
      : _repo = repository {
    loadOwners();
  }

  final OwnerRepository _repo;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<OwnerModel> _owners = [];
  List<OwnerModel> get owners => _owners;

  Future<void> loadOwners() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _owners = await _repo.listOwners();
    } catch (e) {
      _error = 'Failed to load owners: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createOwner({
    required String name,
    required String surname,
    PersonType? type,
    String? email,
    String? phone,
  }) async {
    try {
      final newOwner = await _repo.createOwner(
        name: name,
        surname: surname,
        type: type,
        email: email,
        phone: phone,
      );
      _owners.insert(0, newOwner);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to create owner: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateOwner(
    String id, {
    String? name,
    String? surname,
    PersonType? type,
    String? email,
    String? phone,
  }) async {
    try {
      final updated = await _repo.updateOwner(
        id,
        name: name,
        surname: surname,
        type: type,
        email: email,
        phone: phone,
      );
      final index = _owners.indexWhere((o) => o.id == id);
      if (index != -1) {
        _owners[index] = updated;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = 'Failed to update owner: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> deleteOwner(String id) async {
    final prevOwners = List<OwnerModel>.from(_owners);
    try {
      _owners.removeWhere((o) => o.id == id);
      notifyListeners();

      await _repo.deleteOwner(id);
    } catch (e) {
      _owners = prevOwners;
      _error = 'Failed to delete owner: $e';
      notifyListeners();
    }
  }
}
