import 'package:flutter/material.dart';
import 'package:tyba_test_daniel/src/views/home_view.dart';

import 'package:tyba_test_daniel/src/views/login_view.dart';
import 'package:tyba_test_daniel/src/views/register_view.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hot Food',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginView(),
          'register': (BuildContext context) => RegisterView(),
          'home': (BuildContext context) => HomeView(),
        },
        theme: ThemeData(
          primaryColor: Colors.orange,
        ),
      );
 
  }
}
