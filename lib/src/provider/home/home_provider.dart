import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/provider/api_provider.dart';

class HomeProvider extends ApiProvider {
  /// home product
  Future<HttpResult> homeProduct() {
    String url = "${baseUrl}products";
    return getRequest(url);
  }
}
