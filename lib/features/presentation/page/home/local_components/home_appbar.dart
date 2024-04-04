part of '../home_page.dart';

PreferredSizeWidget homeAppBar({
  required final void Function() onSearchClicked,
}) {
  return AppBar(
    elevation: 0,
    automaticallyImplyLeading: false,
    surfaceTintColor: Colors.transparent,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: IconButton(
          onPressed: onSearchClicked,
          icon: const Icon(Icons.search_rounded),
        ),
      )
    ],
  );
}
