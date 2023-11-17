import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/bloc/category/category_bloc.dart';
import 'package:flutter_test_shopping/src/dialog/bottom/ui/category_dialog.dart';
import 'package:flutter_test_shopping/src/repository/category/category_repository.dart';

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
        return RepositoryProvider(
          create: (context) => CategoryRepository(),
          child: BlocProvider(
            create: (context) => CategoryBloc(
              repositoryCategory:
                  RepositoryProvider.of<CategoryRepository>(context),
            ),
            child: CategoryDialog(
              selected: selected,
              onTap: onTap,
            ),
          ),
        );
      },
    );
  }
}
