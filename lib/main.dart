import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:missions/add_mission.dart';
import 'package:missions/home.dart';
import 'package:missions/mission_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MissionDb.initDatabase();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Civil Defense Missions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.green[900],
        fontFamily: 'Araboto',
      ),
      initialRoute: ScreenRoutes.homeRoute,
      routes: {
        ScreenRoutes.homeRoute: (context) => const HomeScreen(),
        ScreenRoutes.addRoute: (context) => const AddScreen(),
      },
    );
  }
}

class ScreenRoutes {
  static String homeRoute = '/home';
  static String addRoute = '/add';
}
