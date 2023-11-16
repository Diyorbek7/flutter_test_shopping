import 'package:flutter/material.dart';
import 'package:flutter_test_shopping/src/dialog/bottom/ui/category_dialog.dart';

class BottomDialog {
  static void showCategoryDialog(
    BuildContext context,
    String selected,
    Function(String type) onTap,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CategoryDialog(
          selected: selected,
          onTap: onTap,
        );
      },
    );
  }
}
