import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  final String? query;

  const SearchEvent({this.query});

  @override
  List<Object?> get props => [query!];
}

class SearchRestaurantEvent extends SearchEvent {
  const SearchRestaurantEvent(String query) : super(query: query);
}
