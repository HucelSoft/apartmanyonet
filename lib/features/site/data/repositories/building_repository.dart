import 'package:pocketbase/pocketbase.dart';

import 'package:apartmanyonet/features/apartments/data/models/apartment_model.dart';
import 'package:apartmanyonet/features/flats/data/models/flat_model.dart';
import 'package:apartmanyonet/features/site/data/models/site_model.dart';

/// Data-access layer for the three-level building hierarchy:
///
/// ```
/// Site (Bina)
///  └─ Apartment (Blok/Giriş)
///      └─ Flat (Daire)
/// ```
///
/// Every write operation automatically scopes records to [organizationId].
class BuildingRepository {
  const BuildingRepository({
    required PocketBase pb,
    required String organizationId,
  })  : _pb = pb,
        _orgId = organizationId;

  final PocketBase _pb;
  final String _orgId;

  // ══════════════════════════════════════════════════════════════════════════
  // SITE (Bina)
  // ══════════════════════════════════════════════════════════════════════════

  Future<List<SiteModel>> listSites() async {
    final result = await _pb.collection(SiteModel.collectionName).getList(
          perPage: 500,
          filter: 'organization = "$_orgId"',
          sort: 'name',
        );
    return result.items.map((r) => SiteModel.fromJson(r.toJson())).toList();
  }

  Future<SiteModel> createSite({
    required String name,
    String? address,
  }) async {
    final body = {
      'name': name,
      'organization': _orgId,
      if (address != null && address.isNotEmpty) 'address': address,
    };
    final record =
        await _pb.collection(SiteModel.collectionName).create(body: body);
    return SiteModel.fromJson(record.toJson());
  }

  Future<SiteModel> updateSite(
    String id, {
    required String name,
    String? address,
  }) async {
    final body = {
      'name': name,
      'address': address ?? '',
    };
    final record = await _pb
        .collection(SiteModel.collectionName)
        .update(id, body: body);
    return SiteModel.fromJson(record.toJson());
  }

  Future<void> deleteSite(String id) =>
      _pb.collection(SiteModel.collectionName).delete(id);

  // ══════════════════════════════════════════════════════════════════════════
  // APARTMENT (Blok / Giriş)
  // ══════════════════════════════════════════════════════════════════════════

  Future<List<ApartmentModel>> listApartments(String siteId) async {
    final result =
        await _pb.collection(ApartmentModel.collectionName).getList(
              perPage: 500,
              filter: 'site = "$siteId" && organization = "$_orgId"',
              sort: 'name',
            );
    return result.items
        .map((r) => ApartmentModel.fromJson(r.toJson()))
        .toList();
  }

  Future<ApartmentModel> createApartment({
    required String siteId,
    required String name,
    required int floors,
    required int flats,
    String? blockName,
    String? address,
  }) async {
    final body = {
      'name': name,
      'site': siteId,
      'organization': _orgId,
      'floors': floors,
      'flats': flats,
      if (blockName != null && blockName.isNotEmpty) 'block_name': blockName,
      if (address != null && address.isNotEmpty) 'address': address,
    };
    final record = await _pb
        .collection(ApartmentModel.collectionName)
        .create(body: body);
    return ApartmentModel.fromJson(record.toJson());
  }

  Future<ApartmentModel> updateApartment(
    String id, {
    required String name,
    required int floors,
    required int flats,
    String? blockName,
    String? address,
  }) async {
    final body = {
      'name': name,
      'floors': floors,
      'flats': flats,
      'block_name': blockName ?? '',
      'address': address ?? '',
    };
    final record = await _pb
        .collection(ApartmentModel.collectionName)
        .update(id, body: body);
    return ApartmentModel.fromJson(record.toJson());
  }

  Future<void> deleteApartment(String id) =>
      _pb.collection(ApartmentModel.collectionName).delete(id);

  // ══════════════════════════════════════════════════════════════════════════
  // FLAT (Daire)
  // ══════════════════════════════════════════════════════════════════════════

  Future<List<FlatModel>> listFlats(String apartmentId) async {
    final result = await _pb.collection(FlatModel.collectionName).getList(
          perPage: 500,
          filter: 'apartment = "$apartmentId" && organization = "$_orgId"',
          sort: 'flat',
        );
    return result.items.map((r) => FlatModel.fromJson(r.toJson())).toList();
  }

  Future<FlatModel> createFlat({
    required String siteId,
    required String apartmentId,
    required int flatNumber,
  }) async {
    final body = {
      'flat': flatNumber,
      'apartment': apartmentId,
      'site': siteId,
      'organization': _orgId,
      'status': 'vacant',
    };
    final record =
        await _pb.collection(FlatModel.collectionName).create(body: body);
    return FlatModel.fromJson(record.toJson());
  }

  Future<void> deleteFlat(String flatId) =>
      _pb.collection(FlatModel.collectionName).delete(flatId);

  Future<void> deleteFlatsByApartment(String apartmentId) async {
    final flats = await listFlats(apartmentId);
    for (final f in flats) {
      await _pb.collection(FlatModel.collectionName).delete(f.id);
    }
  }
}
