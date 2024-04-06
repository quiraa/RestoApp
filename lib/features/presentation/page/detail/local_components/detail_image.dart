part of '../detail_page.dart';

class DetailImage extends StatelessWidget {
  final String imageId;
  const DetailImage({Key? key, required this.imageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "https://restaurant-api.dicoding.dev/images/large/$imageId",
      height: 240,
      width: double.maxFinite,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(Icons.image_not_supported_rounded),
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}
