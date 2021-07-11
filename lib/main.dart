import 'package:flutter/material.dart';

import 'package:tyba_test_daniel/src/bloc/provider.dart';
import 'package:tyba_test_daniel/src/providers/preferences_provider.dart';

import 'package:tyba_test_daniel/src/views/home_view.dart';
import 'package:tyba_test_daniel/src/views/login_view.dart';
import 'package:tyba_test_daniel/src/views/register_view.dart';
import 'package:tyba_test_daniel/src/views/restaurant_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferencesProvider();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferencesProvider();
    final String _token = prefs.token;
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hot Food',
        initialRoute: _token.isEmpty ? 'login' : 'home',
        routes: {
          'login': (BuildContext context) => LoginView(),
          'register': (BuildContext context) => RegisterView(),
          'home': (BuildContext context) => HomeView(),
          'locationRestaurant': (BuildContext context) => RestaurantByLocationView()
        },
        theme: ThemeData(
          primaryColor: Colors.orange,
        ),
      ),
    );
  }
}
