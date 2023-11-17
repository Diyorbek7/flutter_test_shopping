import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/provider/api_provider.dart';

class HomeProvider extends ApiProvider {
  /// home product
  Future<HttpResult> homeProduct() {
    String url = "${baseUrl}products";
    return getRequest(url);
  }

  /// category
  Future<HttpResult> category() {
    String url = "${baseUrl}products/categories";
    return getRequest(url);
  }

  /// home category
  Future<HttpResult> homeCategory(String category) {
    String url = "${baseUrl}products/category/$category";
    return getRequest(url);
  }
}
