part of '../detail_page.dart';

class DetailMenu extends StatelessWidget {
  final Widget drinkMenu;
  final Widget foodMenu;

  const DetailMenu({
    Key? key,
    required this.drinkMenu,
    required this.foodMenu,
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
              'Menus',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8),
            child: Text(
              'Drinks',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(height: 8),
          drinkMenu,
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'Foods',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(height: 8),
          foodMenu,
        ],
      ),
    );
  }
}
