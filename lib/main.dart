import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'UI/Screens/splash_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

double screenWidth = 0.0;
double screenHeight = 0.0;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('user_data');
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: [Locale('ar'), Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    startLocale: const Locale('en'),
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Hayyak',
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'TisaSansPro'),
      ),
    );
  }
}
