import 'package:flutter/material.dart';
import 'package:tyba_test_daniel/src/repositories/usuarios_repository.dart';
import 'package:tyba_test_daniel/src/search/search_delegate.dart';
import 'package:tyba_test_daniel/src/views/login_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final userRepository = new UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurantes'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: DataSearch()),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => _logout(context),
        ),
      ),
      body: Text('el home'),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.location_on),
      onPressed: () => {},
    );
  }

  void _logout(BuildContext context) {
    userRepository.logout();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginView(),
        ),
        (route) => false);
  }
}
