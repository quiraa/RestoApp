part of '../detail_page.dart';

class DetailReviews extends StatelessWidget {
  final Widget reviewList;

  const DetailReviews({
    Key? key,
    required this.reviewList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Customer Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 16),
          reviewList,
        ],
      ),
    );
  }
}
