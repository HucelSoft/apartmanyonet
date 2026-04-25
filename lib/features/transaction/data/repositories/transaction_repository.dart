import 'package:pocketbase/pocketbase.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/features/apartments/data/models/apartment_model.dart';
import 'package:apartmanyonet/features/flats/data/models/flat_model.dart';
import 'package:apartmanyonet/features/site/data/models/site_model.dart';
import 'package:apartmanyonet/features/transaction/data/models/transaction_model.dart';
import 'package:apartmanyonet/features/transaction/data/models/transaction_type_model.dart';

/// Enriched transaction DTO: raw model + human-readable labels extracted
/// from PocketBase expand relations.
class TransactionItem {
  const TransactionItem({
    required this.transaction,
    required this.typeName,
    required this.typeGenre,
    required this.flatLabel,
    required this.apartmentLabel,
    required this.siteName,
  });

  final TransactionModel transaction;
  final String typeName;
  final TransactionGenre typeGenre;
  final String flatLabel;
  final String apartmentLabel;
  final String siteName;

  String get id => transaction.id;
}

/// Lookup payloads for populating the Create/Edit form dropdowns.
class TransactionFormData {
  const TransactionFormData({
    required this.types,
    required this.sites,
    required this.apartments,
    required this.flats,
  });

  final List<TransactionTypeModel> types;
  final List<SiteModel> sites;
  final List<ApartmentModel> apartments;
  final List<FlatModel> flats;
}

// ─────────────────────────────────────────────────────────────────────────────

/// Data-access layer for the Transaction collection.
///
/// All queries are scoped to [organizationId].
class TransactionRepository {
  const TransactionRepository({
    required PocketBase pb,
    required String organizationId,
  })  : _pb = pb,
        _orgId = organizationId;

  final PocketBase _pb;
  final String _orgId;

  // ── List ──────────────────────────────────────────────────────────────────

  Future<List<TransactionItem>> listTransactions({
    RecordStatus? statusFilter,
    String? siteId,
    DateTime? from,
    DateTime? to,
  }) async {
    final filters = <String>['organization = "$_orgId"'];
    if (statusFilter != null) filters.add('status = "${statusFilter.name}"');
    if (siteId != null) filters.add('site = "$siteId"');
    if (from != null) {
      filters.add('date >= "${from.toIso8601String()}"');
    }
    if (to != null) {
      filters.add('date <= "${to.toIso8601String()}"');
    }

    final result = await _pb.collection(TransactionModel.collectionName).getList(
          perPage: 500,
          filter: filters.join(' && '),
          sort: '-date',
          expand: 'type,flat,apartment,site',
        );

    return result.items.map(_toItem).toList();
  }

  // ── Create ─────────────────────────────────────────────────────────────────

  Future<TransactionItem> createTransaction({
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
    final body = {
      'type': typeId,
      'organization': _orgId,
      'site': siteId,
      'apartment': apartmentId,
      'flat': flatId,
      'amount': amount,
      'date': _pbDate(date),
      'status': status.name,
      if (description != null && description.isNotEmpty)
        'description': description,
      if (dueDate != null) 'due_date': _pbDate(dueDate),
      if (paymentDate != null) 'payment_date': _pbDate(paymentDate),
    };

    final record = await _pb
        .collection(TransactionModel.collectionName)
        .create(body: body, expand: 'type,flat,apartment,site');
    return _toItem(record);
  }

  // ── Update ─────────────────────────────────────────────────────────────────

  Future<TransactionItem> updateTransaction(
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
    final body = {
      'type': typeId,
      'site': siteId,
      'apartment': apartmentId,
      'flat': flatId,
      'amount': amount,
      'date': _pbDate(date),
      'status': status.name,
      'description': description ?? '',
      'due_date': dueDate != null ? _pbDate(dueDate) : '',
      'payment_date': paymentDate != null ? _pbDate(paymentDate) : '',
    };

    final record = await _pb
        .collection(TransactionModel.collectionName)
        .update(id, body: body, expand: 'type,flat,apartment,site');
    return _toItem(record);
  }

  // ── Delete ─────────────────────────────────────────────────────────────────

  Future<void> deleteTransaction(String id) =>
      _pb.collection(TransactionModel.collectionName).delete(id);

  // ── Form data lookups ─────────────────────────────────────────────────────

  Future<List<TransactionTypeModel>> fetchTypes() async {
    final result = await _pb
        .collection(TransactionTypeModel.collectionName)
        .getList(
          perPage: 200,
          filter: 'organization = "$_orgId"',
          sort: 'type',
        );
    return result.items
        .map((r) => TransactionTypeModel.fromJson(r.toJson()))
        .toList();
  }

  Future<List<SiteModel>> fetchSites() async {
    final result = await _pb.collection(SiteModel.collectionName).getList(
          perPage: 200,
          filter: 'organization = "$_orgId"',
          sort: 'name',
        );
    return result.items.map((r) => SiteModel.fromJson(r.toJson())).toList();
  }

  Future<List<ApartmentModel>> fetchApartments(String siteId) async {
    final result =
        await _pb.collection(ApartmentModel.collectionName).getList(
              perPage: 200,
              filter: 'site = "$siteId" && organization = "$_orgId"',
              sort: 'name',
            );
    return result.items
        .map((r) => ApartmentModel.fromJson(r.toJson()))
        .toList();
  }

  Future<List<FlatModel>> fetchFlats(String apartmentId) async {
    final result = await _pb.collection(FlatModel.collectionName).getList(
          perPage: 500,
          filter: 'apartment = "$apartmentId" && organization = "$_orgId"',
          sort: 'flat',
        );
    return result.items.map((r) => FlatModel.fromJson(r.toJson())).toList();
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  TransactionItem _toItem(RecordModel r) {
    final tx = TransactionModel.fromJson(r.toJson());

    final typeList = r.get<List<RecordModel>>('expand.type');
    final typeName = typeList.isNotEmpty
        ? (typeList.first.data['type'] as String? ?? tx.type)
        : tx.type;
    final typeGenreRaw =
        typeList.isNotEmpty ? typeList.first.data['genre'] as String? : null;
    final typeGenre = typeGenreRaw == 'credit'
        ? TransactionGenre.credit
        : TransactionGenre.debit;

    final flatList = r.get<List<RecordModel>>('expand.flat');
    final flatLabel = flatList.isNotEmpty
        ? 'No. ${flatList.first.data['flat']}'
        : 'Flat';

    final aptList = r.get<List<RecordModel>>('expand.apartment');
    final apartmentLabel =
        aptList.isNotEmpty ? (aptList.first.data['name'] as String? ?? '') : '';

    final siteList = r.get<List<RecordModel>>('expand.site');
    final siteName =
        siteList.isNotEmpty ? (siteList.first.data['name'] as String? ?? '') : '';

    return TransactionItem(
      transaction: tx,
      typeName: typeName,
      typeGenre: typeGenre,
      flatLabel: flatLabel,
      apartmentLabel: apartmentLabel,
      siteName: siteName,
    );
  }

  String _pbDate(DateTime d) => d.toUtc().toIso8601String();
}
