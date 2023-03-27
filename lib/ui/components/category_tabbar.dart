import 'package:flutter/material.dart';

class CategoryTabbar extends StatelessWidget {
  const CategoryTabbar({
    super.key,
    required this.categories,
    this.onTap,
    this.selectedItem,
  });

  final List<String> categories;
  final ValueChanged<String>? onTap;
  final String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          final isSelected = selectedItem == category;

          return TextButton(
            onPressed: () {
              onTap?.call(category);
            },
            child: Text(
              category,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.black87),
            ),
          );
        },
      ),
    );
  }
}
