import 'package:equatable/equatable.dart';
import 'package:restaurant_app/features/data/model/favorite/favorite_restaurant.dart';

abstract class FavoriteState extends Equatable {
  final List<FavoriteRestaurant>? favorites;

  const FavoriteState({this.favorites});

  @override
  List<Object?> get props => [favorites!];
}

class FavoriteEmptyState extends FavoriteState {
  const FavoriteEmptyState();
}

class FavoriteLoadingState extends FavoriteState {
  const FavoriteLoadingState();
}

class FavoriteSucccessState extends FavoriteState {
  const FavoriteSucccessState(List<FavoriteRestaurant> favorites)
      : super(favorites: favorites);
}

class IsFavoriteState extends FavoriteState {
  const IsFavoriteState();
}

class IsNotFavoriteState extends FavoriteState {
  const IsNotFavoriteState();
}
