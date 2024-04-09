import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/features/data/model/favorite/favorite_restaurant.dart';

class FavoriteCard extends StatelessWidget {
  final FavoriteRestaurant? favorite;
  final void Function(String restaurantId)? onRestaurantClicked;
  final void Function(String favoriteId)? onRemoveFavorite;

  const FavoriteCard({
    Key? key,
    this.favorite,
    this.onRestaurantClicked,
    this.onRemoveFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (favorite != null) {
            onRestaurantClicked!(favorite!.id!);
          }
        },
        child: Row(
          children: [
            _buildImage(context),
            const SizedBox(width: 16),
            Expanded(child: _buildTitleAndDescription()),
            _buildRemoveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRemoveButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () {
          onRemoveFavorite!(favorite?.id ?? '');
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final imageUrl =
        "https://restaurant-api.dicoding.dev/images/medium/${favorite?.imageUrl ?? ''}";

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
        return const Center(child: Icon(Icons.image_not_supported_rounded));
      },
    );
  }

  Widget _buildTitleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          favorite?.name ?? '',
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
              favorite?.city ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
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
            Text(favorite?.rating ?? '')
          ],
        )
      ],
    );
  }
}
