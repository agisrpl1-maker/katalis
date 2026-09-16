import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  final String selected;

  final Function(String) onChanged;

  const CategoryFilter({
    super.key,

    required this.selected,

    required this.onChanged,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final List<String> categories = ["All", "Income", "Expense"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,

      children: categories.map((item) {
        return ChoiceChip(
          label: Text(item),

          selected: widget.selected == item,

          onSelected: (value) {
            widget.onChanged(item);
          },
        );
      }).toList(),
    );
  }
}
