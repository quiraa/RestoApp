part of '../search_page.dart';

PreferredSizeWidget searchAppBar(BuildContext context) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    leading: IconButton(
      onPressed: () => AppRouter.pop(context),
      icon: const Icon(Icons.arrow_back_rounded),
    ),
  );
}
