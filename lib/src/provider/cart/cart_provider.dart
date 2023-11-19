import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/provider/api_provider.dart';

class CartProvider extends ApiProvider {
  /// home product
  Future<HttpResult> cartUser() {
    String url = "${baseUrl}carts?userId=1";
    return getRequest(url);
  }

  /// all user
  Future<HttpResult> allUser() {
    String url = "${baseUrl}users";
    return getRequest(url);
  }

  /// user
  Future<HttpResult> user(int id) {
    String url = "${baseUrl}users/$id";
    return getRequest(url);
  }
}
