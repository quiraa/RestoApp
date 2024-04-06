import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/config/route/app_router.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/home/home_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/home/home_state.dart';

import 'package:restaurant_app/features/presentation/widget/content_state.dart';
import 'package:restaurant_app/features/presentation/widget/restaurant_list_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => AppRouter.push(context, ScreenRoutes.search),
              icon: const Icon(Icons.search_rounded),
            ),
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return const LoadingState();

            case HomeErrorState:
              return ErrorState(
                error: state.error?.message ?? '',
              );

            case HomeSuccessState:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Popular Restaurants',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'We recommend these restaurants for you to try',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, _) =>
                          const SizedBox(height: 16),
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      itemCount: state.restaurants!.length,
                      itemBuilder: (context, index) {
                        return RestaurantListCard(
                          restaurant: state.restaurants![index],
                          onRestaurantClicked: (id) {
                            AppRouter.push(context, ScreenRoutes.detail,
                                arguments: id);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
