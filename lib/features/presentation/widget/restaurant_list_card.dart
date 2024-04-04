import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/features/data/model/list/restaurant_item_response.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RestaurantList extends StatelessWidget {
  final List<RestaurantItemResponse>? restaurants;
  final void Function(String restaurantId)? onRestaurantClicked;

  const RestaurantList({
    Key? key,
    this.restaurants,
    this.onRestaurantClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: restaurants!.length,
      separatorBuilder: (context, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) => RestaurantListCard(
        restaurant: restaurants![index],
        onRestaurantClicked: onRestaurantClicked,
      ),
    );
  }
}

class RestaurantListCard extends StatelessWidget {
  final RestaurantItemResponse? restaurant;
  final void Function(String restaurantId)? onRestaurantClicked;

  const RestaurantListCard({
    Key? key,
    this.restaurant,
    this.onRestaurantClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (restaurant != null) {
          onRestaurantClicked!(restaurant!.id!);
        }
      },
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        height: MediaQuery.of(context).size.width / 3,
        child: Row(
          children: [
            _buildImage(context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Expanded(child: _buildTitleAndDescription()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          "https://restaurant-api.dicoding.dev/images/medium/${restaurant?.pictureId ?? ''}",
      imageBuilder: (context, imageProvider) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.5),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return _buildImageChild(
          context,
          const CupertinoActivityIndicator(),
        );
      },
      errorWidget: (context, url, error) {
        return _buildImageChild(
          context,
          const Icon(Icons.image_not_supported_rounded),
        );
      },
    );
  }

  Widget _buildImageChild(BuildContext context, Widget imageChild) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          ),
          child: imageChild,
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant?.name ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.clip,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    restaurant?.city ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.star_rate_rounded,
              color: Colors.orangeAccent,
            ),
            const SizedBox(width: 8),
            Text(restaurant?.rating.toString() ?? '')
          ],
        )
      ],
    );
  }
}
