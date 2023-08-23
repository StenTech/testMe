import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:testme/common/theme/theme.dart';
import 'package:testme/repository/db/db.helper.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:testme/utils/service_locator.dart';
import 'package:testme/viewmodel/user.dart';

import 'view/home.page.dart';

void main() {
  // ensure initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Service Locator
  ServiceLocator.setup();

  // Run the app
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      builder: (context, child) => const TestmeApp(),
    ),
  );
}

class TestmeApp extends StatelessWidget {
  const TestmeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // restorationScopeId is used to persist and restore the state of the app
      // when the app is killed and restarted
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      restorationScopeId: 'testme app',
      title: 'Test Me',
      theme: testmeAppThemeData,
      home: const HomePage(title: 'Test Me'),
    );
  }
}
