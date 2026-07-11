import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'core/layouts/main_layout.dart';
import 'core/database/hive_service.dart';
import 'core/database/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const ThienCoApp());
}

class ThienCoApp extends StatelessWidget {
  const ThienCoApp({super.key});

  ThemeMode _resolveThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: SettingsService.listenable,
      builder: (context, box, _) {
        final String themeMode = SettingsService.getThemeMode();

        return MaterialApp(
          builder: (context, child) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 820),
                child: child!,
              ),
            );
          },
          title: 'Thiên Cơ',
          debugShowCheckedModeBanner: false,
          locale: const Locale('vi', 'VN'),
          supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'US')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          themeMode: _resolveThemeMode(themeMode),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const MainLayout(),
        );
      },
    );
  }
}
