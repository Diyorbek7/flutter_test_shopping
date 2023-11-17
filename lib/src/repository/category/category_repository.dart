import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/provider/category/category_provider.dart';

abstract class RepositoryCategory {
  /// category
  Future<HttpResult> allCategory();
}

class CategoryRepository implements RepositoryCategory {
  CategoryProvider categoryProvider = CategoryProvider();

  @override
  Future<HttpResult> allCategory() {
    return categoryProvider.category();
  }
}
