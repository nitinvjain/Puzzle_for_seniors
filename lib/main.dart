import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:window_manager/window_manager.dart';
import 'package:puzzle/l10n/app_localizations.dart';
import 'config/app_settings.dart';
import 'config/senior_mode.dart';
import 'data/models/user_data.dart';
import 'data/models/game_streak.dart';
import 'data/repositories/user_repository.dart';
import 'providers/user_providers.dart';
import 'providers/settings_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'ui/features/main_shell/main_shell.dart';
import 'utils/design_system.dart';
import 'widgets/error_boundary.dart';

/// Held for the life of the process so the listener is not collected.
AppLifecycleListener? _immersiveWatcher;

/// Hide the system bars, if this build wants them hidden.
///
/// Re-applied on resume as well as at startup: coming back from another app,
/// or from the launcher, can leave the bars showing again, and the whole
/// point is that they are not there while he plays.
Future<void> _applyImmersiveMode() async {
  if (kIsWeb) return;
  if (defaultTargetPlatform != TargetPlatform.android &&
      defaultTargetPlatform != TargetPlatform.iOS) {
    return;
  }
  if (!SeniorMode.enabled || !SeniorMode.immersiveFullScreen) return;
  try {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  } catch (_) {
    // A platform that will not hide its bars still runs the games.
  }
}

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

  await _applyImmersiveMode();
  _immersiveWatcher = AppLifecycleListener(onResume: _applyImmersiveMode);

  await Hive.initFlutter();

  Hive.registerAdapter(UserDataAdapter());
  Hive.registerAdapter(GameStreakAdapter());

  // Before the first frame, so AppSettings can be read synchronously from the
  // tap handlers that cannot await anything.
  await AppSettings.init();

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
      //
      // The floor is now a setting rather than a constant. It is watched
      // inside a Consumer here rather than at the top of build, because
      // rebuilding MaterialApp itself on a settings change would drop the
      // navigation stack -- changing the text size would bounce whoever did
      // it back to the home screen.
      builder: (context, child) => Consumer(
        builder: (context, ref, _) {
          final scale = ref.watch(settingsProvider.select((s) => s.textScale));
          final Widget scaled = MediaQuery.withClampedTextScaling(
            minScaleFactor: SeniorMode.enabled ? scale : 1.0,
            maxScaleFactor: SeniorMode.enabled
                ? SeniorMode.uiTextScaleCeiling
                : double.infinity,
            child: child ?? const SizedBox.shrink(),
          );

          // A dead strip along the bottom edge. With the system bars hidden,
          // the app runs right to the edge -- which is where the swipe that
          // brings them back lives, and where a bottom row of keypad buttons
          // ends up. Shortening the whole app by a few pixels means a
          // mis-aimed tap there hits nothing at all.
          //
          // Done here rather than in each Scaffold because not every screen
          // wraps itself in a SafeArea, and the ones that most need the gap
          // are the ones with a keypad at the bottom. Painted in the scaffold
          // colour so the strip is invisible.
          if (!SeniorMode.enabled || SeniorMode.bottomKeepOut <= 0) {
            return scaled;
          }
          return ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: SeniorMode.bottomKeepOut),
              child: scaled,
            ),
          );
        },
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


