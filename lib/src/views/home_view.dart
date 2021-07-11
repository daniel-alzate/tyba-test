import 'package:flutter/material.dart';
import 'package:tyba_test_daniel/src/models/restaurant_model.dart';
import 'package:tyba_test_daniel/src/repositories/restaurant_repository.dart';
import 'package:tyba_test_daniel/src/repositories/usuarios_repository.dart';
import 'package:tyba_test_daniel/src/search/search_delegate.dart';
import 'package:tyba_test_daniel/src/views/login_view.dart';
import 'package:tyba_test_daniel/src/widgets/restaurant_card.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final userRepository = new UserRepository();
  final restaurantRepository = new RestaurantRepository();

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
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

    Widget _crearListado() {
    return FutureBuilder(
      future: restaurantRepository.getTransaccions(),
      builder: (BuildContext context,
          AsyncSnapshot<List<RestaurantModel>> snapshot) {
        if (snapshot.hasData) {
          final restaurants = snapshot.data;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, i) =>
                RestaurantCard(restaurant: restaurants[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      child: Icon(Icons.location_on),
      onPressed: () => Navigator.pushNamed(context, 'locationRestaurant'),
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
