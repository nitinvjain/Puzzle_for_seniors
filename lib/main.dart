import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:window_manager/window_manager.dart';
import 'package:puzzle/l10n/app_localizations.dart';
import 'config/senior_mode.dart';
import 'data/models/user_data.dart';
import 'data/models/game_streak.dart';
import 'data/repositories/user_repository.dart';
import 'providers/user_providers.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'ui/features/main_shell/main_shell.dart';
import 'utils/design_system.dart';
import 'widgets/error_boundary.dart';

void main() async {
  final stopwatch = Stopwatch()..start();

  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
      minimumSize: Size(800, 600),
      center: true,
      title: "Puzzle Games",
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  // Performance monitoring
  if (kDebugMode) {
    FlutterError.onError = (details) {
      debugPrint('Flutter Error: ${details.exception}');
      debugPrint('Stack: ${details.stack}');
    };
  }

  await Hive.initFlutter();

  Hive.registerAdapter(UserDataAdapter());
  Hive.registerAdapter(GameStreakAdapter());

  final userRepository = UserRepository();
  await userRepository.init();



  // Log app startup time
  stopwatch.stop();
  debugPrint('App startup time (sync): ${stopwatch.elapsedMilliseconds}ms');

  runApp(
    ProviderScope(
      overrides: [
        userRepositoryProvider.overrideWithValue(userRepository),
      ],
      child: const ErrorBoundary(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(themeNotifierProvider);
    final appLocale = ref.watch(localeNotifierProvider);

    ThemeMode themeMode;
    switch (appThemeMode) {
      case AppThemeMode.light:
        themeMode = ThemeMode.light;
        break;
      case AppThemeMode.dark:
        themeMode = ThemeMode.dark;
        break;
      case AppThemeMode.system:
        themeMode = ThemeMode.system;
        break;
    }

    // Senior build is always dark-on-light: a dark theme that follows the
    // system at dusk would silently change the app's appearance, which reads
    // as "something is wrong with it".
    if (SeniorMode.enabled) {
      themeMode = ThemeMode.light;
    }

    return MaterialApp(
      title: 'Puzzle Games',
      debugShowCheckedModeBanner: false,
      theme: DesignSystem.lightTheme,
      darkTheme: DesignSystem.darkTheme,
      themeMode: themeMode,
      // Enlarge the type across the whole app.
      //
      // DesignSystem.fontSize* is scaled for the senior build, but only about
      // sixty of the app's thousand-odd text styles go through it -- the rest
      // name a size outright, and a few hundred of those are under 14. Raising
      // them one at a time across three hundred screens is not realistic, and
      // every screen added later would start small again. Clamping the text
      // scale here lifts all of them at once, including any screen written
      // after this.
      //
      // A floor rather than a fixed scale, so a larger system font setting on
      // his tablet still wins. The ceiling is there because these screens were
      // laid out against unscaled text: past about 1.6 the tighter ones start
      // to overflow, and a clipped board is worse than slightly smaller type.
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        minScaleFactor: SeniorMode.enabled ? SeniorMode.uiTextScale : 1.0,
        maxScaleFactor: SeniorMode.enabled ? SeniorMode.uiTextScaleCeiling : double.infinity,
        child: child ?? const SizedBox.shrink(),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: appLocale,
      supportedLocales: [
        const Locale('en'),
        ...AppLocalizations.supportedLocales.where((l) => l.languageCode != 'en'),
      ],
      localeListResolutionCallback: (locales, supportedLocales) {
        if (locales != null) {
          for (var locale in locales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
          }
        }
        return const Locale('en');
      },
      home: const MainShell(),
    );
  }
}


