 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:resturant_menu/pages/details_page.dart';
import 'package:resturant_menu/pages/homePage.dart';
import 'package:resturant_menu/pages/meal.dart';
import 'package:resturant_menu/railMenu/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(supportedLocales:  [
    Locale('en', 'US'),
    Locale('ru', 'RU'),
    Locale('uz', 'UZ'),
  ],
    path: 'assets/translations',
    child: MultiProvider(providers:[
      ChangeNotifierProvider(create: (_) => ProviderLang())
    ],
    child: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const DetailsPage(),
    );
  }
}


