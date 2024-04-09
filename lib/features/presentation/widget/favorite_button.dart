import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final void Function() onFavoriteClick;

  const FavoriteButton({
    Key? key,
    required this.isFavorite,
    required this.onFavoriteClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onFavoriteClick,
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_outline,
        color: isFavorite ? Colors.redAccent : Colors.grey.shade400,
      ),
    );
  }
}
