import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tyba_test_daniel/src/models/restaurant_model.dart';
import 'package:tyba_test_daniel/src/config/endpoints.dart';

class RestaurantRepository {

  Future<List<RestaurantModel>> getRestauransByQuery(String query) async {
    final String _url = '$baseMapUrl/textsearch/json?key=$mapsApiKey&query=$query&radius=10000';
    final res = await http.get(_url);

    final Map<String, dynamic> decodedData = json.decode(res.body);

    final List<RestaurantModel> restaurants = List();
    if (decodedData == null) return [];

    decodedData['results'].forEach((restaurant) {
      final restTemp = RestaurantModel.fromJson(restaurant);

      restaurants.add(restTemp);
    });

    return restaurants;
  }

  Future<List<RestaurantModel>> getRestauransByLocation(
      double latitud, double longitude) async {
    final String _url =  '$baseMapUrl/nearbysearch/json?location=$latitud,$longitude&rankby=distance&type=restaurant&key=$mapsApiKey';
    final res = await http.get(_url);

    final Map<String, dynamic> decodedData = json.decode(res.body);

    final List<RestaurantModel> restaurants = List();
    if (decodedData == null) return [];

    decodedData['results'].forEach((restaurant) {
      final restTemp = RestaurantModel.fromJson(restaurant);

      restaurants.add(restTemp);
    });

    return restaurants;
  }

  Future<void> saveTransaccions(RestaurantModel restauran) async {
    final String _url = '$baseFireUrl/restaurants.json';

    await http.post(
      _url,
      body: restaurantModelToJson(restauran),
    );
  }

    Future<List<RestaurantModel>> getTransaccions() async {

    final String _url = '$baseFireUrl/restaurants.json';

    final response = await http.get(_url);
    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    final List<RestaurantModel> _restaurants = new List();
    if (decodeResponse == null) {
      return [];
    }
    decodeResponse.forEach((id, _product) {
      final _tempProduct = RestaurantModel.fromJson(_product);
      _restaurants.add(_tempProduct);
    });
    return _restaurants;
  }
}
