part of '../detail_page.dart';

class DetailImage extends StatelessWidget {
  final String imageId;
  const DetailImage({Key? key, required this.imageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "https://restaurant-api.dicoding.dev/images/large/$imageId",
      progressIndicatorBuilder: (context, url, progress) {
        return _buildImagePlaceholder(
            context, const CupertinoActivityIndicator());
      },
      errorWidget: (context, url, error) {
        return _buildImagePlaceholder(
          context,
          const Icon(Icons.image_not_supported_rounded),
        );
      },
      imageBuilder: (context, imageProvider) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            height: 128,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImagePlaceholder(BuildContext context, Widget child) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        height: 128,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        ),
        child: child,
      ),
    );
  }
}
