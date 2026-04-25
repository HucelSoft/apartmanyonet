import 'package:flutter/foundation.dart';

import 'package:apartmanyonet/features/apartments/data/models/apartment_model.dart';
import 'package:apartmanyonet/features/flats/data/models/flat_model.dart';
import 'package:apartmanyonet/features/site/data/models/site_model.dart';
import 'package:apartmanyonet/features/site/data/repositories/building_repository.dart';

// ─────────────────────────────────────────────────────────────────────────────
// State classes (simple, no Freezed needed for local view-state)
// ─────────────────────────────────────────────────────────────────────────────

/// The view-level tree node for the Buildings page.
///
/// Each [SiteNode] owns its loaded [ApartmentNode] children.
/// Children are loaded on-demand when the user expands a site card.
class SiteNode {
  SiteNode(this.site)
      : apartments = [],
        isExpanded = false,
        isLoadingApartments = false;

  SiteModel site;
  List<ApartmentNode> apartments;
  bool isExpanded;
  bool isLoadingApartments;
}

class ApartmentNode {
  ApartmentNode(this.apartment)
      : flats = [],
        isExpanded = false,
        isLoadingFlats = false;

  ApartmentModel apartment;
  List<FlatModel> flats;
  bool isExpanded;
  bool isLoadingFlats;
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifier
// ─────────────────────────────────────────────────────────────────────────────

/// Manages the complete Buildings-page state: the site/apartment/flat tree,
/// operation loading, and error messages.
///
/// Scoped locally inside [AdminBuildingsPage] via [ChangeNotifierProvider].
class BuildingsNotifier extends ChangeNotifier {
  BuildingsNotifier(this._repo) {
    loadSites();
  }

  final BuildingRepository _repo;

  // ── State ──────────────────────────────────────────────────────────────────
  bool _isLoading = false;
  String? _error;
  List<SiteNode> _nodes = [];

  // ── Getters ────────────────────────────────────────────────────────────────
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<SiteNode> get nodes => _nodes;

  // ══════════════════════════════════════════════════════════════════════════
  // SITE operations
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> loadSites() async {
    _setLoading(true);
    try {
      final sites = await _repo.listSites();
      _nodes = sites.map(SiteNode.new).toList();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<bool> createSite({required String name, String? address}) async {
    try {
      final site = await _repo.createSite(name: name, address: address);
      _nodes.add(SiteNode(site));
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateSite(
    String id, {
    required String name,
    String? address,
  }) async {
    try {
      final updated =
          await _repo.updateSite(id, name: name, address: address);
      final idx = _nodes.indexWhere((n) => n.site.id == id);
      if (idx != -1) _nodes[idx].site = updated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteSite(String id) async {
    try {
      await _repo.deleteSite(id);
      _nodes.removeWhere((n) => n.site.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // APARTMENT expand / operations
  // ══════════════════════════════════════════════════════════════════════════

  /// Toggles the expansion of a site card.
  /// Lazy-loads apartments on first expand.
  Future<void> toggleSite(String siteId) async {
    final node = _nodeFor(siteId);
    if (node == null) return;

    if (!node.isExpanded && node.apartments.isEmpty) {
      node.isLoadingApartments = true;
      notifyListeners();
      try {
        final apts = await _repo.listApartments(siteId);
        node.apartments = apts.map(ApartmentNode.new).toList();
      } catch (e) {
        _error = e.toString();
      }
      node.isLoadingApartments = false;
    }

    node.isExpanded = !node.isExpanded;
    notifyListeners();
  }

  Future<bool> createApartment({
    required String siteId,
    required String name,
    required int floors,
    required int flats,
    String? blockName,
    String? address,
  }) async {
    try {
      final apt = await _repo.createApartment(
        siteId: siteId,
        name: name,
        floors: floors,
        flats: flats,
        blockName: blockName,
        address: address,
      );
      final node = _nodeFor(siteId);
      node?.apartments.add(ApartmentNode(apt));
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateApartment(
    String siteId,
    String aptId, {
    required String name,
    required int floors,
    required int flats,
    String? blockName,
    String? address,
  }) async {
    try {
      final updated = await _repo.updateApartment(
        aptId,
        name: name,
        floors: floors,
        flats: flats,
        blockName: blockName,
        address: address,
      );
      final node = _nodeFor(siteId);
      final aptIdx =
          node?.apartments.indexWhere((a) => a.apartment.id == aptId) ?? -1;
      if (aptIdx != -1) node!.apartments[aptIdx].apartment = updated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteApartment(String siteId, String aptId) async {
    try {
      await _repo.deleteApartment(aptId);
      final node = _nodeFor(siteId);
      node?.apartments.removeWhere((a) => a.apartment.id == aptId);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // FLAT expand / operations
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> toggleApartment(String siteId, String aptId) async {
    final aptNode = _aptNodeFor(siteId, aptId);
    if (aptNode == null) return;

    if (!aptNode.isExpanded && aptNode.flats.isEmpty) {
      aptNode.isLoadingFlats = true;
      notifyListeners();
      try {
        aptNode.flats = await _repo.listFlats(aptId);
      } catch (e) {
        _error = e.toString();
      }
      aptNode.isLoadingFlats = false;
    }

    aptNode.isExpanded = !aptNode.isExpanded;
    notifyListeners();
  }

  Future<bool> createFlat({
    required String siteId,
    required String apartmentId,
    required int flatNumber,
  }) async {
    try {
      final flat = await _repo.createFlat(
        siteId: siteId,
        apartmentId: apartmentId,
        flatNumber: flatNumber,
      );
      _aptNodeFor(siteId, apartmentId)?.flats.add(flat);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteFlat(
      String siteId, String apartmentId, String flatId) async {
    try {
      await _repo.deleteFlat(flatId);
      _aptNodeFor(siteId, apartmentId)?.flats.removeWhere((f) => f.id == flatId);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  SiteNode? _nodeFor(String siteId) {
    try {
      return _nodes.firstWhere((n) => n.site.id == siteId);
    } catch (_) {
      return null;
    }
  }

  ApartmentNode? _aptNodeFor(String siteId, String aptId) {
    final site = _nodeFor(siteId);
    if (site == null) return null;
    try {
      return site.apartments.firstWhere((a) => a.apartment.id == aptId);
    } catch (_) {
      return null;
    }
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
