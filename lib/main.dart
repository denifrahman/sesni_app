import 'package:sesnic_app/Utils/ThemeChanger.dart';
import 'package:sesnic_app/screen/ActivityScreen.dart';
import 'package:sesnic_app/screen/DasboardScreen.dart';
import 'package:sesnic_app/screen/HistoryScreen.dart';
import 'package:sesnic_app/screen/LoginScreen.dart';
import 'package:sesnic_app/screen/ProfileScreen.dart';
import 'package:sesnic_app/screen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Theme Provider',
            theme:  light,
            home: SplaceScreen(),
            initialRoute: '/',
            routes: {
              '/splace-screen': (context) => SplaceScreen(),
              '/login': (context) => LoginScreen(),
              '/dashboard': (context) => DashboardScreen(),
              '/activity': (context) => ActivityScreen(),
              '/history': (context) => HistoryScreen(),
              '/profile': (context) => ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}

//class MaterialAppWithTheme extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final theme = Provider.of<ThemeCanger>(context);
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme:  theme.getTheme(),
////      ThemeData(
////        scaffoldBackgroundColor: Colors.white,
////        fontFamily: 'OpenSans-Semibold',
////        primaryColor: Colors.cyan[900],
////        canvasColor: Colors.cyan[900],
////      ),
////      darkTheme: ThemeData(
////        brightness: Brightness.dark,
////        scaffoldBackgroundColor: Colors.black,
////        fontFamily: 'OpenSans-Semibold',
////      ),
//      home: SplaceScreen(),
//      initialRoute: '/',
//      routes: {
//        '/splace-screen': (context) => SplaceScreen(),
//        '/portal': (context) => page_portal(),
//        '/login': (context) => LoginPage(),
//        '/dashboard': (context) => BottomMenu(),
//      },
//    );
//  }
//}
