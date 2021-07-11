import 'package:flutter/material.dart';
import 'package:tyba_test_daniel/src/models/restaurant_model.dart';
import 'package:tyba_test_daniel/src/repositories/restaurant_repository.dart';
import 'package:tyba_test_daniel/src/search/widgets/restaurant_suggestion_item.dart';

class DataSearch extends SearchDelegate {
    final restaurantProvider = RestaurantRepository();

  @override
  String get searchFieldLabel => 'Buscar restaurantes';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(
          context,
          null,
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  Widget _buildLoadingSearch() => Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  Widget _buildEmptySearch() => Container(
        child: Center(
          child: Icon(
            Icons.no_food_outlined,
            color: Colors.black38,
            size: 130,
          ),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _buildEmptySearch();
    }
    return FutureBuilder(
      future: restaurantProvider.getRestauransByQuery(query),
      builder: (BuildContext context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
        if (snapshot.hasData) {
          final restaurant = snapshot.data;
          return ListView(
            children: restaurant.map(
              (_restaurant) {
                return RestaurantSuggestionItem(restaurant: _restaurant)
                ;
              },
            ).toList(),
          );
        } else {
          return _buildLoadingSearch();
        }
      },
    );
  }
}
