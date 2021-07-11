import 'package:flutter/material.dart';
import 'package:tyba_test_daniel/src/models/restaurant_model.dart';

class RestaurantSuggestionItem extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantSuggestionItem({
    @required this.restaurant,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:FadeInImage(
          image: NetworkImage(
            'https://via.placeholder.com/200x300'
          ),
          placeholder: AssetImage(
            'assets/no-image.png',
          ),
          width: 50,
          fit: BoxFit.contain,
        ),
      title: Text(
        restaurant.name,
      ),
      subtitle: Text(
        restaurant.score.toString(),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,

//TODO:

          '/detail',
          arguments: restaurant,
        );
      },
    );
  }
}