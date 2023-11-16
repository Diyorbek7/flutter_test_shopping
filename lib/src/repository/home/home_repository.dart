import 'package:flutter_test_shopping/src/database/database_helper.dart';
import 'package:flutter_test_shopping/src/model/home/home_product_model.dart';
import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/provider/home/home_provider.dart';

abstract class RepositoryHome {
  /// home product

  Future<HttpResult> homeProduct();

  /// cart database
  Future<List<HomeProductModel>> product();
}

class HomeRepository implements RepositoryHome {
  HomeProvider homeProvider = HomeProvider();
  DatabaseHelper databaseHelper = DatabaseHelper();

  /// home product
  @override
  Future<HttpResult> homeProduct() {
    return homeProvider.homeProduct();
  }

  /// cart database
  @override
  Future<List<HomeProductModel>> product() {
    return databaseHelper.getAllCart();
  }
}
