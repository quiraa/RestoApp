import 'package:floor/floor.dart';
import 'package:restaurant_app/features/data/model/favorite/favorite_restaurant.dart';
import 'package:restaurant_app/features/data/source/local/favorite_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'favorite_database.g.dart';

@Database(version: 1, entities: [FavoriteRestaurant])
abstract class FavoriteDatabase extends FloorDatabase {
  FavoriteDao get dao;
}
