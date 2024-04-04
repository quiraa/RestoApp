part of '../home_page.dart';

class HomeScaffold extends StatelessWidget {
  final Widget header;
  final PreferredSizeWidget appBar;
  final Widget restaurantList;

  const HomeScaffold({
    Key? key,
    required this.header,
    required this.appBar,
    required this.restaurantList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          const SizedBox(height: 16),
          restaurantList,
        ],
      ),
    );
  }
}
