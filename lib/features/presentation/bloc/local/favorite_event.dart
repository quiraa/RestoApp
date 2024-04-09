import 'package:restaurant_app/features/data/model/favorite/favorite_restaurant.dart';

abstract class FavoriteEvent {
  final String? id;
  final FavoriteRestaurant? favorite;

  const FavoriteEvent({this.id, this.favorite});
}

class DeleteSingleFavoriteEvent extends FavoriteEvent {
  const DeleteSingleFavoriteEvent(String id) : super(id: id);
}

class CheckFavoriteEvent extends FavoriteEvent {
  const CheckFavoriteEvent(String id) : super(id: id);
}

class InsertFavoriteEvent extends FavoriteEvent {
  const InsertFavoriteEvent(FavoriteRestaurant favorite)
      : super(favorite: favorite);
}

class GetAllFavoriteEvent extends FavoriteEvent {
  const GetAllFavoriteEvent();
}
