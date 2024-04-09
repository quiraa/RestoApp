part of '../search_page.dart';

class SearchScaffold extends StatelessWidget {
  final Widget headerView;
  final Widget searchFieldView;
  final Widget searchListView;

  const SearchScaffold({
    Key? key,
    required this.headerView,
    required this.searchFieldView,
    required this.searchListView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerView,
            searchFieldView,
            Expanded(child: searchListView),
          ],
        ),
      ),
    );
  }
}
