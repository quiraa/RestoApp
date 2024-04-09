import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/config/route/app_router.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';
import 'package:restaurant_app/di/injection.dart';
import 'package:restaurant_app/features/presentation/bloc/local/favorite_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/local/favorite_event.dart';
import 'package:restaurant_app/features/presentation/bloc/local/favorite_state.dart';
import 'package:restaurant_app/features/presentation/widget/content_state.dart';
import 'package:restaurant_app/features/presentation/widget/favorite_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoriteBloc>()..add(const GetAllFavoriteEvent()),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case FavoriteEmptyState:
                  return const EmptyState(
                    message: 'Empty Favorites',
                  );

                case FavoriteLoadingState:
                  return const LoadingState();

                case FavoriteSucccessState:
                  return ListView.separated(
                    itemCount: state.favorites!.length,
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (context, _) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final favorite = state.favorites![index];
                      return FavoriteCard(
                        onRemoveFavorite: (favoriteId) {
                          BlocProvider.of<FavoriteBloc>(context).add(
                            DeleteSingleFavoriteEvent(favoriteId),
                          );
                        },
                        onRestaurantClicked: (id) {
                          AppRouter.push(context, ScreenRoutes.detail,
                              arguments: id);
                        },
                        favorite: favorite,
                      );
                    },
                  );

                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
