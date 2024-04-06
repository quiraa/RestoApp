abstract class SearchEvent {
  final String? query;

  const SearchEvent({this.query});
}

class SearchRestaurantEvent extends SearchEvent {
  const SearchRestaurantEvent(String query) : super(query: query);
}
