/// Global string constants for the app.
abstract class AppConstants {
  static const String appName = 'ApartmanYönet';
  static const String appVersion = '1.0.0';

  // PocketBase collection names
  static const String usersCollection = 'users';
  static const String apartmentsCollection = 'apartments';
  static const String flatsCollection = 'flats';
  static const String contractsCollection = 'contracts';
  static const String announcementsCollection = 'announcements';
  static const String paymentsCollection = 'payments';

  // Shared Preferences keys
  static const String prefAuthToken = 'auth_token';
  static const String prefUserId = 'user_id';
}
