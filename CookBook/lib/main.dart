import 'package:cookbook/styles/thems.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'NavigationBar/NavigationBar.dart';
import 'local/cashhelper.dart';

// void main() => runApp(const MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await CashHelper.init();

  bool? isdarkcashedthem = CashHelper.getThem(key: "isdark");
  print("cash theme " + isdarkcashedthem.toString());
  if (isdarkcashedthem != null) {
    if (isdarkcashedthem == true) {
      Get.changeTheme(Themes.darkThem);
    } else {
      Get.changeTheme(Themes.lightTheme);
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Initialialze firebase App
  Future<FirebaseApp> _initializeFirebase() async => await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkThem,
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MyNavigationBar(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//   // This class is the configuration for the state.
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
