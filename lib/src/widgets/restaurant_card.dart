import 'package:flutter/material.dart';
import 'package:tyba_test_daniel/src/models/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantCard({
    this.restaurant,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.png'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 100,
            ),
          ),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(restaurant.name,
                  overflow: TextOverflow.ellipsis, maxLines: 2),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.yellow[800],
                  ),
                  Text(restaurant.score.toString())
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
