import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/config/route/app_router.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';

import 'package:restaurant_app/features/presentation/provider/restaurant_provider.dart';
import 'package:restaurant_app/features/presentation/widget/content_state.dart';
import 'package:restaurant_app/features/presentation/widget/restaurant_list_card.dart';

part 'local_components/home_header.dart';
part 'local_components/home_scaffold.dart';
part 'local_components/home_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      appBar: homeAppBar(
        onSearchClicked: () => AppRouter.push(context, ScreenRoutes.search),
      ),
      header: const HomeHeader(),
      restaurantList: Expanded(
        child: Consumer<RestaurantProvider>(
          builder: (context, provider, _) {
            switch (provider.state) {
              case ResultState.loading:
                return const LoadingState();

              case ResultState.error:
                return ErrorState(
                  error: provider.message,
                  onRefresh: () {
                    provider.fetchAllRestaurants();
                  },
                );

              case ResultState.noData:
                return EmptyState(
                  message: provider.message,
                );

              case ResultState.hasData:
                return RestaurantList(
                  restaurants: provider.restaurantResponse.restaurants,
                  onRestaurantClicked: (id) {
                    AppRouter.push(context, ScreenRoutes.detail, arguments: id);
                  },
                );

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
