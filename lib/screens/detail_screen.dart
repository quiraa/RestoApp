import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/style/styles.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/restaurant_detail";

  final Restaurant restaurant;
  const DetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              backgroundColor: Colors.blue,
              expandedHeight: 300,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      restaurant.pictureId,
                      fit: BoxFit.fill,
                    )),
                title: Text(restaurant.name),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text.rich(TextSpan(children: [
                          const WidgetSpan(
                              child: Icon(
                            Icons.location_city,
                            color: Colors.redAccent,
                            size: 18,
                          )),
                          TextSpan(
                              text: restaurant.city.toString(),
                              style: listSubtitle)
                        ])),
                        const SizedBox(
                          width: 10,
                        ),
                        Text.rich(TextSpan(children: [
                          const WidgetSpan(
                              child: Icon(
                            Icons.star_rate,
                            color: Colors.orangeAccent,
                            size: 18,
                          )),
                          TextSpan(
                              text: restaurant.rating.toString(),
                              style: listSubtitle)
                        ]))
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Deskripsi',
                      style: listTitle,
                    ),
                    const SizedBox(height: 8),
                    Text(restaurant.description),
                    const SizedBox(height: 16),
                    const Text(
                      'Makanan',
                      style: listTitle,
                    ),
                    const SizedBox(height: 8),
                    Text(restaurant.menus.foods
                        .map((food) => food.name)
                        .join(', ')),
                    const SizedBox(height: 16),
                    const Text(
                      'Minuman',
                      style: listTitle,
                    ),
                    const SizedBox(height: 8),
                    Text(restaurant.menus.drinks
                        .map((drinks) => drinks.name)
                        .join(', ')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
