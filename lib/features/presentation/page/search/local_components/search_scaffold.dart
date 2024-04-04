part of '../search_page.dart';

class SearchScaffold extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget headerView;
  final Widget searchFieldView;
  final Widget searchListView;

  const SearchScaffold({
    Key? key,
    required this.appBar,
    required this.headerView,
    required this.searchFieldView,
    required this.searchListView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          headerView,
          searchFieldView,
          searchListView,
        ],
      ),
    );
  }
}