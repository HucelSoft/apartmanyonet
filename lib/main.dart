import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/network/pocketbase_client.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/presentation/providers/auth_notifier.dart';
import 'features/settings/presentation/providers/preference_notifier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ── Infrastructure ─────────────────────────────────────────────────
        Provider<PocketBaseService>(create: (_) => PocketBaseService.instance),

        // ── Data sources ───────────────────────────────────────────────────
        ProxyProvider<PocketBaseService, AuthRemoteDataSource>(
          create: (context) =>
              AuthRemoteDataSource(context.read<PocketBaseService>().pb),
          update: (context, pb, _) => AuthRemoteDataSource(pb.pb),
        ),

        // ── Notifiers ──────────────────────────────────────────────────────
        ChangeNotifierProxyProvider<AuthRemoteDataSource, AuthNotifier>(
          create: (context) =>
              AuthNotifier(context.read<AuthRemoteDataSource>()),
          update: (context, dataSource, previous) =>
              previous ?? AuthNotifier(dataSource),
        ),

        /// Global user preferences (theme + language).
        /// Placed after [AuthNotifier] so it can outlive individual sessions.
        ChangeNotifierProvider<PreferenceNotifier>(
          create: (_) => PreferenceNotifier(),
        ),
      ],
      child: const _RouterScope(),
    ),
  );
}

/// Builds [AppRouter] exactly once after the Provider tree is established.
///
/// Using a [StatefulWidget] with `_router ??= ...` prevents the GoRouter from
/// being recreated on rebuilds (which would reset navigation state).
class _RouterScope extends StatefulWidget {
  const _RouterScope();

  @override
  State<_RouterScope> createState() => _RouterScopeState();
}

class _RouterScopeState extends State<_RouterScope> {
  GoRouter? _router;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Build once; the router's refreshListenable keeps it reactive.
    _router ??= AppRouter(authNotifier: context.read<AuthNotifier>()).router;
  }

  @override
  Widget build(BuildContext context) {
    // Watch [PreferenceNotifier] so theme & locale changes rebuild MaterialApp.
    final prefs = context.watch<PreferenceNotifier>();

    return MaterialApp.router(
      title: 'ApartmanYönet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: prefs.themeMode,
      locale: prefs.locale,
      supportedLocales: const [Locale('tr'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: _router!,
    );
  }
}
