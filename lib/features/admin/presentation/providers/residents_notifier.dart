import 'package:flutter/material.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/features/resident/data/models/resident_model.dart';
import 'package:apartmanyonet/features/resident/data/repositories/resident_repository.dart';

class ResidentsNotifier extends ChangeNotifier {
  ResidentsNotifier({required ResidentRepository repository})
      : _repo = repository {
    loadResidents();
  }

  final ResidentRepository _repo;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<ResidentModel> _residents = [];
  List<ResidentModel> get residents => _residents;

  Future<void> loadResidents() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _residents = await _repo.listResidents();
    } catch (e) {
      _error = 'Failed to load residents: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createResident({
    required String name,
    required String surname,
    PersonType? type,
    String? email,
    String? phone,
  }) async {
    try {
      final newResident = await _repo.createResident(
        name: name,
        surname: surname,
        type: type,
        email: email,
        phone: phone,
      );
      _residents.insert(0, newResident);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to create resident: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateResident(
    String id, {
    String? name,
    String? surname,
    PersonType? type,
    String? email,
    String? phone,
  }) async {
    try {
      final updated = await _repo.updateResident(
        id,
        name: name,
        surname: surname,
        type: type,
        email: email,
        phone: phone,
      );
      final index = _residents.indexWhere((r) => r.id == id);
      if (index != -1) {
        _residents[index] = updated;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = 'Failed to update resident: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> deleteResident(String id) async {
    final prevResidents = List<ResidentModel>.from(_residents);
    try {
      _residents.removeWhere((r) => r.id == id);
      notifyListeners();

      await _repo.deleteResident(id);
    } catch (e) {
      _residents = prevResidents;
      _error = 'Failed to delete resident: $e';
      notifyListeners();
    }
  }
}
