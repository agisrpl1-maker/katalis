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
  final List<String> categories = ["Semua", "Pemasukan", "Pengeluaran"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,

      children: categories.map((item) {
        return ChoiceChip(
          label: Text(item),

          selected: widget.selected == item,

          onSelected: (value) {
            if (item == "Semua") {
              widget.onChanged("Semua");
            } else if (item == "Pemasukan") {
              widget.onChanged("Pemasukan");
            } else if (item == "Pengeluaran") {
              widget.onChanged("Pengeluaran");
            } else {
              widget.onChanged("Semua");
            }
          },
        );
      }).toList(),
    );
  }
}
