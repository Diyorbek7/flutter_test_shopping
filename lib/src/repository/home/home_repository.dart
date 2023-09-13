import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/provider/home/home_provider.dart';

abstract class RepositoryHome {
  /// home product

  Future<HttpResult> homeProduct();
}

class HomeRepository implements RepositoryHome {
  HomeProvider homeProvider = HomeProvider();

  /// home product
  @override
  Future<HttpResult> homeProduct() {
    return homeProvider.homeProduct();
  }
}
