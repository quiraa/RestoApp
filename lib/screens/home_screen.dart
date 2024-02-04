import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/style/styles.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: FutureBuilder<String>(
        future:
            DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantsItem(context, restaurants[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildRestaurantsItem(BuildContext context, Restaurant restaurant) {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: restaurant);
      },
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Hero(
          tag: restaurant.pictureId,
          child: Image.network(restaurant.pictureId,
              width: 144, height: 108, fit: BoxFit.cover),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(restaurant.name, style: listTitle),
              const SizedBox(height: 8),
              Text.rich(TextSpan(children: [
                const WidgetSpan(
                    child:
                        Icon(Icons.location_city, color: Colors.red, size: 18)),
                TextSpan(text: restaurant.city, style: listSubtitle)
              ])),
              Text.rich(TextSpan(children: [
                const WidgetSpan(
                    child: Icon(
                  Icons.star_rate,
                  color: Colors.orangeAccent,
                  size: 18,
                )),
                TextSpan(
                    text: restaurant.rating.toString(), style: listSubtitle)
              ]))
            ],
          ),
        ),
      ]),
    ),
  );
}
