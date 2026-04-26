import 'package:pocketbase/pocketbase.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/features/resident/data/models/resident_model.dart';

class ResidentRepository {
  const ResidentRepository({
    required PocketBase pb,
    required String organizationId,
  })  : _pb = pb,
        _orgId = organizationId;

  final PocketBase _pb;
  final String _orgId;

  Future<List<ResidentModel>> listResidents() async {
    final result = await _pb.collection(ResidentModel.collectionName).getList(
          perPage: 500,
          filter: 'organization = "$_orgId"',
          sort: '-created',
        );
    return result.items
        .map((r) => ResidentModel.fromJson(r.toJson()))
        .toList();
  }

  Future<ResidentModel> createResident({
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
      if (type != null) 'type': type.name, // assumes pb has simple string mapping
      if (email != null && email.isNotEmpty) 'email': email,
      if (phone != null && phone.isNotEmpty) 'phone': phone,
    };

    final record =
        await _pb.collection(ResidentModel.collectionName).create(body: body);
    return ResidentModel.fromJson(record.toJson());
  }

  Future<ResidentModel> updateResident(
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
        .collection(ResidentModel.collectionName)
        .update(id, body: body);
    return ResidentModel.fromJson(record.toJson());
  }

  Future<void> deleteResident(String id) =>
      _pb.collection(ResidentModel.collectionName).delete(id);
}
