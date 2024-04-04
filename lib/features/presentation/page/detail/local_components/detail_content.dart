part of '../detail_page.dart';

class DetailContent extends StatelessWidget {
  final Widget imageView;
  final Widget headerView;
  final Widget descriptionView;
  final Widget menuView;
  final Widget reviewView;
  final Widget formView;

  const DetailContent({
    Key? key,
    required this.imageView,
    required this.headerView,
    required this.descriptionView,
    required this.menuView,
    required this.reviewView,
    required this.formView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          imageView,
          headerView,
          const Divider(),
          const SizedBox(height: 16),
          descriptionView,
          const SizedBox(height: 16),
          const Divider(),
          menuView,
          const SizedBox(height: 16),
          const Divider(),
          reviewView,
          formView,
        ],
      ),
    );
  }
}
