import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/config/route/app_router.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';
import 'package:restaurant_app/features/presentation/provider/restaurant_provider.dart';
import 'package:restaurant_app/features/presentation/widget/content_state.dart';
import 'package:restaurant_app/features/presentation/widget/restaurant_list_card.dart';

part 'local_components/search_appbar.dart';
part 'local_components/search_field.dart';
part 'local_components/search_header.dart';
part 'local_components/search_scaffold.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchScaffold(
      appBar: searchAppBar(context),
      headerView: const SearchHeader(),
      searchFieldView: SearchField(
        controller: searchController,
        onSearch: (value) {
          Provider.of<RestaurantProvider>(context, listen: false)
              .searchRestaurants(searchController.text);
        },
      ),
      searchListView: Expanded(
        child: Consumer<RestaurantProvider>(
          builder: (context, provider, _) {
            switch (provider.state) {
              case ResultState.loading:
                return const LoadingState();

              case ResultState.error:
                return ErrorState(
                  error: provider.message,
                );

              case ResultState.noData:
                return const EmptyState(
                  message: 'No restaurants found',
                );

              case ResultState.hasData:
                return RestaurantList(
                  restaurants: provider.searchList,
                  onRestaurantClicked: (id) {
                    AppRouter.push(context, ScreenRoutes.detail, arguments: id);
                  },
                );

              default:
                return const Center(
                  child: Text('Default'),
                );
            }
          },
        ),
      ),
    );
  }
}
