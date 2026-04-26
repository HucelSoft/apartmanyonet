import 'package:pocketbase/pocketbase.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/features/owner/data/models/owner_model.dart';

class OwnerRepository {
  const OwnerRepository({
    required PocketBase pb,
    required String organizationId,
  })  : _pb = pb,
        _orgId = organizationId;

  final PocketBase _pb;
  final String _orgId;

  Future<List<OwnerModel>> listOwners() async {
    final result = await _pb.collection(OwnerModel.collectionName).getList(
          perPage: 500,
          filter: 'organization = "$_orgId"',
          sort: '-created',
        );
    return result.items.map((r) => OwnerModel.fromJson(r.toJson())).toList();
  }

  Future<OwnerModel> createOwner({
    required String name,
    required String surname,
    PersonType? type,
    String? email,
    String? phone,
  }) async {
    final body = {
      'organization': _orgId,
      'name': name,
      'surname': surname,
      if (type != null) 'type': type.name, // assumes simple string mapping
      if (email != null && email.isNotEmpty) 'email': email,
      if (phone != null && phone.isNotEmpty) 'phone': phone,
    };

    final record =
        await _pb.collection(OwnerModel.collectionName).create(body: body);
    return OwnerModel.fromJson(record.toJson());
  }

  Future<OwnerModel> updateOwner(
    String id, {
    String? name,
    String? surname,
    PersonType? type,
    String? email,
    String? phone,
  }) async {
    final body = {
      'name': ?name,
      'surname': ?surname,
      if (type != null) 'type': type.name,
      'email': ?email,
      'phone': ?phone,
    };

    final record = await _pb
        .collection(OwnerModel.collectionName)
        .update(id, body: body);
    return OwnerModel.fromJson(record.toJson());
  }

  Future<void> deleteOwner(String id) =>
      _pb.collection(OwnerModel.collectionName).delete(id);
}
