import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restaurant_app/features/data/model/add_review/review_body.dart';
import 'package:restaurant_app/features/data/model/detail/restaurant_response.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_event.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_state.dart';
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
    BlocProvider.of<DetailBloc>(context).add(
      GetDetailRestaurantEvent(widget.restaurantId ?? ''),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Detail Restaurant'),
      ),
      body: BlocConsumer<DetailBloc, DetailState>(
        listener: (context, state) {
          if (state is PostReviewSuccessState) {
            // Lakukan fetch ulang detail restoran untuk mendapatkan review terbaru
            BlocProvider.of<DetailBloc>(context).add(
              GetDetailRestaurantEvent(widget.restaurantId ?? ''),
            );
            // Bersihkan controllers setelah review berhasil diposting
            nameController.clear();
            reviewController.clear();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case DetailLoadingState:
              return const LoadingState();

            case DetailErrorState:
              return ErrorState(
                error: state.error?.message ?? '',
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
                // Tampilkan loading state jika detailRestaurant masih null
                return const LoadingState();
              }
            // final detail = state.detailRestaurant?.restaurant;
            // return DetailContent(
            //   imageView: DetailImage(imageId: detail?.pictureId ?? ''),
            //   headerView: DetailHeader(
            //     name: detail?.name ?? '',
            //     location: detail?.city ?? '',
            //     rating: detail?.rating.toString() ?? '',
            //   ),
            //   descriptionView: DetailDescription(
            //     description: detail?.description ?? '',
            //   ),
            //   menuView: DetailMenu(
            //     drinkMenu: DrinkListView(
            //       drinkName: detail?.menus?.drinks ?? [],
            //     ),
            //     foodMenu: FoodListView(
            //       foodName: detail?.menus?.foods ?? [],
            //     ),
            //   ),
            //   reviewView: DetailReviews(
            //     reviewList:
            //         ReviewsListView(reviews: detail?.customerReviews ?? []),
            //   ),
            //   formView: DetailForm(
            //     nameController: nameController,
            //     reviewController: reviewController,
            //     onSubmitForm: () {
            //       final id = detail?.id ?? '';
            //       final name = nameController.text;
            //       final review = reviewController.text;

            //       if (name.isNotEmpty && review.isNotEmpty) {
            //         final body =
            //             ReviewBody(id: id, name: name, review: review);
            //         BlocProvider.of<DetailBloc>(context).add(
            //           AddCustomerReviewEvent(body),
            //         );
            //         // Menampilkan snackbar untuk notifikasi review berhasil diposting
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           const SnackBar(
            //             content: Text('Review Posted'),
            //           ),
            //         );
            //       } else {
            //         // Menampilkan snackbar untuk notifikasi field belum diisi
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           const SnackBar(
            //             content: Text('Please fill in the field'),
            //           ),
            //         );
            //       }
            //     },
            //   ),
            // );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
