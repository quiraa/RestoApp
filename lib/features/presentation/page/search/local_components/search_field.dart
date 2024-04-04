part of '../search_page.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String value) onSearch;

  const SearchField({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onSubmitted: onSearch,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          hintText: 'Search Restaurant',
          prefixIcon: IconButton(
            onPressed: () {
              onSearch(controller.text);
            },
            icon: const Icon(Icons.search),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
