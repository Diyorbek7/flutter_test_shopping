import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_test_shopping/src/provider/cart/cart_provider.dart';

abstract class RepositoryCart {
  /// cart user
  Future<HttpResult> cartUser();
}

class CartRepository implements RepositoryCart {
  CartProvider cartProvider = CartProvider();

  /// cart user
  @override
  Future<HttpResult> cartUser() {
    return cartProvider.cartUser();
  }
}
