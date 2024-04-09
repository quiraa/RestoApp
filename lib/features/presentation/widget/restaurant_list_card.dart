import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/features/data/model/response/list/restaurant_item_response.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (restaurant != null) {
            onRestaurantClicked!(restaurant!.id!);
          }
        },
        child: Row(
          children: [
            _buildImage(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildTitleAndDescription(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final imageUrl =
        "https://restaurant-api.dicoding.dev/images/medium/${restaurant?.pictureId ?? ''}";

    if (imageUrl.isEmpty) {
      return const Center(
        child: Icon(Icons.image_not_supported_outlined),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 128,
      height: 156,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, progress) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(Icons.image_not_supported_rounded),
        );
      },
    );
  }

  Widget _buildTitleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          restaurant?.name ?? '',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.clip,
          maxLines: null,
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
              maxLines: null,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.star_rate_rounded,
              color: Colors.orangeAccent,
            ),
            const SizedBox(width: 8),
            Text(
              restaurant?.rating.toString() ?? '',
              maxLines: null,
              overflow: TextOverflow.clip,
            )
          ],
        )
      ],
    );
  }
}
