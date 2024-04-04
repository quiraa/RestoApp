import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:restaurant_app/features/data/model/add_review/review_body.dart';
import 'package:restaurant_app/features/data/model/detail/restaurant_response.dart';
import 'package:restaurant_app/features/presentation/provider/restaurant_provider.dart';
import 'package:restaurant_app/features/presentation/widget/content_state.dart';

import '../../../data/model/add_review/customer_review_response.dart';

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
  final nameController = TextEditingController();
  final reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchSingleRestaurant(widget.restaurantId ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Detail Restaurant'),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, _) {
          switch (provider.state) {
            case ResultState.loading:
              return const LoadingState();

            case ResultState.noData:
              return EmptyState(
                message: provider.message,
              );

            case ResultState.error:
              return ErrorState(
                error: provider.message,
                onRefresh: () {
                  provider.fetchSingleRestaurant(widget.restaurantId ?? '');
                },
              );
            case ResultState.hasData:
              final detail = provider.detailResponse.restaurant;
              return DetailContent(
                imageView: DetailImage(imageId: detail?.pictureId ?? ''),
                headerView: DetailHeader(
                  name: detail?.name ?? '',
                  location: detail?.city ?? '',
                  rating: detail?.rating.toString() ?? '',
                ),
                descriptionView:
                    DetailDescription(description: detail?.description ?? ''),
                menuView: DetailMenu(
                  drinkMenu: DrinkListView(
                    drinkName: detail?.menus?.drinks ?? [],
                  ),
                  foodMenu: FoodListView(
                    foodName: detail?.menus?.foods ?? [],
                  ),
                ),
                reviewView: DetailReviews(
                  reviewList:
                      ReviewsListView(reviews: detail?.customerReviews ?? []),
                ),
                formView: DetailForm(
                  nameController: nameController,
                  reviewController: reviewController,
                  onSubmitForm: () {
                    final id = detail?.id ?? '';
                    final name = nameController.text;
                    final review = reviewController.text;

                    if (name.isNotEmpty && review.isNotEmpty) {
                      provider.postRestaurantReview(
                        ReviewBody(id: id, name: name, review: review),
                      );
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

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
