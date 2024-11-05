import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tezda_task/Authentication/SignIn.dart';
import 'package:tezda_task/Authentication/SignUp.dart';
import 'package:tezda_task/Controller/AuthController.dart';
import 'package:tezda_task/home/Dashboard.dart';
import 'package:tezda_task/home/HomeScreen.dart';

void main() {
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.find();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Check login status to determine initial route
    authController.checkLoginStatus();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: BottomBarDashboard(),
      // Define your app's pages with GetX navigation
      getPages: [
        GetPage(name: '/home', page: () => BottomBarDashboard()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/register', page: () => Register()),
      ],
    );
  }
}
