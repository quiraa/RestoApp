import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/config/route/app_router.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/search/search_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/search/search_event.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/search/search_state.dart';
import 'package:restaurant_app/features/presentation/widget/content_state.dart';
import 'package:restaurant_app/features/presentation/widget/restaurant_list_card.dart';

part 'local_components/search_appbar.dart';
part 'local_components/search_field.dart';
part 'local_components/search_header.dart';
part 'local_components/search_scaffold.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);


  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchScaffold(
      headerView: const SearchHeader(),
      searchFieldView: SearchField(
        controller: searchController,
        onSearch: (value) {
          BlocProvider.of<SearchBloc>(context).add(
            SearchRestaurantEvent(value),
          );
        },
      ),
      searchListView: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case SearchInitialState:
              return const Center(
                child: Text('Search Restaurants'),
              );

            case SearchLoadingState:
              return const LoadingState();

            case SearchErrorState:
              return ErrorState(
                error: state.error?.message ?? '',
              );

            case SearchEmptyState:
              return const EmptyState(
                message: 'No Restaurants Found',
              );

            case SearchSuccessState:
              return ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                separatorBuilder: (context, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return RestaurantListCard(
                    restaurant: state.restaurants![index],
                    onRestaurantClicked: (id) {
                      AppRouter.push(context, ScreenRoutes.detail,
                          arguments: id);
                    },
                  );
                },
                itemCount: state.restaurants!.length,
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
