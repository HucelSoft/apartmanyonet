import 'package:pocketbase/pocketbase.dart';

import 'package:apartmanyonet/features/contract/data/models/contract_model.dart';
import 'package:apartmanyonet/features/resident/data/models/resident_model.dart';

class ContractRepository {
  const ContractRepository({
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
          sort: 'name',
        );
    return result.items
        .map((r) => ResidentModel.fromJson(r.toJson()))
        .toList();
  }

  Future<List<ContractModel>> listContracts() async {
    final result = await _pb.collection(ContractModel.collectionName).getList(
          perPage: 500,
          filter: 'flat.organization = "$_orgId"',
          expand: 'flat,flat.apartment,flat.apartment.site,resident',
          sort: '-created',
        );
    return result.items
        .map((r) => ContractModel.fromJson(r.toJson()))
        .toList();
  }

  Future<ContractModel> createContract({
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
    final body = {
      'flat': flatId,
      'apartment': apartmentId,
      'site': siteId,
      'organization': organizationId,
      'resident': residentId,
      'owner': ownerId,
      'start': start.toUtc().toIso8601String(),
      'end': end.toUtc().toIso8601String(),
      'amount': amount,
      'payment_due_day': paymentDueDay,
      'status': 'active',
    };
    final record =
        await _pb.collection(ContractModel.collectionName).create(body: body);
    return ContractModel.fromJson(record.toJson());
  }

  Future<ContractModel> updateContract(
    String id, {
    String? flatId,
    String? residentId,
    DateTime? start,
    DateTime? end,
    double? amount,
    int? paymentDueDay,
    String? status,
  }) async {
    final body = {
      'flat': ?flatId,
      'resident': ?residentId,
      if (start != null) 'start': start.toUtc().toIso8601String(),
      if (end != null) 'end': end.toUtc().toIso8601String(),
      'amount': ?amount,
      'payment_due_day': ?paymentDueDay,
      'status': ?status,
    };
    final record = await _pb
        .collection(ContractModel.collectionName)
        .update(id, body: body);
    return ContractModel.fromJson(record.toJson());
  }

  Future<void> deleteContract(String id) =>
      _pb.collection(ContractModel.collectionName).delete(id);
}
