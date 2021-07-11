import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:tyba_test_daniel/src/repositories/restaurant_repository.dart';
import 'package:tyba_test_daniel/src/widgets/restaurant_card.dart';


class RestaurantByLocationView extends StatefulWidget {
  @override
  _RestaurantByLocationViewState createState() => _RestaurantByLocationViewState();
}

class _RestaurantByLocationViewState extends State<RestaurantByLocationView> {
  final location = new Location();
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  final RestaurantRepository restaurantRepository = RestaurantRepository();

  bool _isLocationEnabled = false;
  bool _isPermissionLocationGranted = false;

  void initState() {
    super.initState();
    _getPermission();
  }

  void _getPermission() async {
    _isLocationEnabled = await location.serviceEnabled();
    _isPermissionLocationGranted =
        _permissionGranted == PermissionStatus.granted;
    setState(() {
      _isLocationEnabled = _isLocationEnabled;
      _isPermissionLocationGranted = _isPermissionLocationGranted;
    });
  }

  getDeviceLocation() async {
    _locationData = await location.getLocation();
    setState(() {
      _locationData = _locationData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurantes cercanos'),
        actions: [
          IconButton(
              icon: Icon(Icons.gps_fixed),
              onPressed: () async {
                await getDeviceLocation();
                setState(() {});
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: _buidLocation(),
      ),
    );
  }

  Widget _buidLocation() {
    bool isLocationOk = (_locationData != null);

    return isLocationOk
        ? FutureBuilder(
            future: restaurantRepository.getRestauransByLocation(
                _locationData.latitude, _locationData.longitude),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
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
          )
        : Text('no gps data');
  }
}
