import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.title,
    this.isSelected = false,
  });

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      margin: const EdgeInsets.only(
        right: 8,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.amber : Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title.toString(),
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
