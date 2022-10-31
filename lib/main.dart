import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'UI/Screens/splash_screen.dart';
double screenWidth = 0.0;
double screenHeight = 0.0;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('user_data');
  runApp(ProviderScope(
    child: MaterialApp(
      home: const App(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserra'
      ),
  )));
}
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return const SplashScreen();
  }
}
