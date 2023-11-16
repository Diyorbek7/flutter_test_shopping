import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/provider/api_provider.dart';

class CategoryProvider extends ApiProvider {
  /// category
  Future<HttpResult> category() {
    String url = "${baseUrl}products/categories";
    return getRequest(url);
  }
}
