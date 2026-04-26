// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

/// Roles available to users in the multi-tenant system.
enum UserRole {
  @JsonValue('super_admin')
  superAdmin,
  @JsonValue('site_admin')
  siteAdmin,
  @JsonValue('resident')
  resident,
  @JsonValue('owner')
  owner,
}

/// Occupancy status of a flat unit.
enum FlatStatus {
  @JsonValue('occupied')
  occupied,
  @JsonValue('vacant')
  empty,
  @JsonValue('maintenance')
  maintenance,
}

/// Lifecycle state of a lease contract.
enum ContractStatus {
  @JsonValue('expired')
  expired,
  @JsonValue('active')
  active,
  @JsonValue('terminated')
  terminated,
}

/// Generic status shared by [transaction] and [ticket] collections.
enum RecordStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

/// Severity level of a maintenance ticket.
enum TicketPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('very high')
  veryHigh,
  @JsonValue('urgent')
  urgent,
}

/// Utility meter type.
enum MeterType {
  @JsonValue('water')
  water,
  @JsonValue('gas')
  gas,
  @JsonValue('electric')
  electric,
}

/// Whether a transaction type represents money coming in or going out.
enum TransactionGenre {
  @JsonValue('debit')
  debit,
  @JsonValue('credit')
  credit,
}
