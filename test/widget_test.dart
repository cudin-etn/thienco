import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:thien_co/core/models/user_profile.dart';
import 'package:thien_co/main.dart';

void main() {
  late Directory hiveDir;

  setUp(() async {
    hiveDir = await Directory.systemTemp.createTemp('thien_co_test_');
    Hive.init(hiveDir.path);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProfileAdapter());
    }

    await Hive.openBox<UserProfile>('user_profiles_box');
    await Hive.openBox('app_settings_box');
  });

  tearDown(() async {
    await Hive.close();
    if (await hiveDir.exists()) {
      await hiveDir.delete(recursive: true);
    }
  });

  testWidgets('renders the main Thiên Cơ shell', (tester) async {
    await tester.pumpWidget(const ThienCoApp());
    await tester.pumpAndSettle();

    expect(find.text('Hôm Nay'), findsAtLeastNWidgets(1));
    expect(find.text('Tử Vi'), findsOneWidget);
    expect(find.text('Tướng'), findsOneWidget);
    expect(find.text('Hợp Tuổi'), findsOneWidget);
    expect(find.text('Hồ Sơ'), findsOneWidget);
  });
}
