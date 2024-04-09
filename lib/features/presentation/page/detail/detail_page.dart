import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/di/injection.dart';
import 'package:restaurant_app/features/data/model/favorite/favorite_restaurant.dart';

import 'package:restaurant_app/features/data/model/response/add_review/review_body.dart';
import 'package:restaurant_app/features/data/model/response/detail/restaurant_response.dart';
import 'package:restaurant_app/features/presentation/bloc/local/favorite_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/local/favorite_event.dart';
import 'package:restaurant_app/features/presentation/bloc/local/favorite_state.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_event.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_state.dart';
import 'package:restaurant_app/features/presentation/widget/content_state.dart';
import 'package:restaurant_app/features/presentation/widget/favorite_button.dart';

import '../../../data/model/response/add_review/customer_review_response.dart';

part 'local_components/detail_header.dart';
part 'local_components/detail_image.dart';
part 'local_components/detail_content.dart';
part 'local_components/drink_list_view.dart';
part 'local_components/food_list_view.dart';
part 'local_components/detail_description.dart';
part 'local_components/detail_menu.dart';
part 'local_components/detail_form.dart';
part 'local_components/detail_reviews.dart';
part 'local_components/reviews_list_view.dart';

class DetailPage extends StatefulWidget {
  final String? restaurantId;
  const DetailPage({Key? key, this.restaurantId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailBloc>(
          create: (_) =>
              sl()..add(GetDetailRestaurantEvent(widget.restaurantId ?? '')),
        ),
        BlocProvider<FavoriteBloc>(
          create: (_) =>
              sl()..add(CheckFavoriteEvent(widget.restaurantId ?? '')),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: const Text('Detail Restaurant'),
        ),
        body: BlocConsumer<DetailBloc, DetailState>(
          listener: (context, state) {
            if (state is PostReviewSuccessState) {
              BlocProvider.of<DetailBloc>(context).add(
                GetDetailRestaurantEvent(widget.restaurantId ?? ''),
              );

              _nameController.clear();
              _reviewController.clear();
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case DetailLoadingState:
                return const LoadingState();

              case DetailErrorState:
                return ErrorState(
                  error: 'No Internet Connection',
                  onRefresh: () {
                    BlocProvider.of<DetailBloc>(context).add(
                      GetDetailRestaurantEvent(widget.restaurantId ?? ''),
                    );
                  },
                );

              case DetailSuccessState:
                if (state.detailRestaurant != null) {
                  final detail = state.detailRestaurant!.restaurant;
                  return DetailContent(
                    imageView: DetailImage(imageId: detail?.pictureId ?? ''),
                    headerView: DetailHeader(
                      name: detail?.name ?? '',
                      location: detail?.city ?? '',
                      rating: detail?.rating.toString() ?? '',
                      favoriteButton: BlocBuilder<FavoriteBloc, FavoriteState>(
                        builder: (context, favoriteState) {
                          return _buildFavoriteButton(detail!, favoriteState);
                        },
                      ),
                    ),
                    descriptionView: DetailDescription(
                      description: detail?.description ?? '',
                    ),
                    menuView: DetailMenu(
                      drinkMenu: DrinkListView(
                        drinkName: detail?.menus?.drinks ?? [],
                      ),
                      foodMenu: FoodListView(
                        foodName: detail?.menus?.foods ?? [],
                      ),
                    ),
                    reviewView: DetailReviews(
                      reviewList: ReviewsListView(
                        reviews: detail?.customerReviews ?? [],
                      ),
                    ),
                    formView: DetailForm(
                      nameController: _nameController,
                      reviewController: _reviewController,
                      onSubmitForm: () {
                        final id = detail?.id ?? '';
                        final name = _nameController.text;
                        final review = _reviewController.text;

                        if (name.isNotEmpty && review.isNotEmpty) {
                          final body =
                              ReviewBody(id: id, name: name, review: review);
                          BlocProvider.of<DetailBloc>(context)
                              .add(AddCustomerReviewEvent(body));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Review Posted'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in the field'),
                            ),
                          );
                        }
                      },
                    ),
                  );
                } else {
                  return const LoadingState();
                }
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(
    RestaurantResponse restaurant,
    FavoriteState state,
  ) {
    if (state is IsFavoriteState) {
      return FavoriteButton(
        isFavorite: true,
        onFavoriteClick: () {
          BlocProvider.of<FavoriteBloc>(context).add(
            DeleteSingleFavoriteEvent(restaurant.id ?? ''),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Removed from Favorite'),
            ),
          );
        },
      );
    } else if (state is IsNotFavoriteState) {
      return FavoriteButton(
        isFavorite: false,
        onFavoriteClick: () {
          BlocProvider.of<FavoriteBloc>(context).add(
            InsertFavoriteEvent(
              FavoriteRestaurant(
                id: restaurant.id,
                name: restaurant.name,
                imageUrl: restaurant.pictureId,
                city: restaurant.city,
                rating: restaurant.rating.toString(),
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to Favorite'),
            ),
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }
}
