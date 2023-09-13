import 'package:flutter/cupertino.dart';
import 'package:flutter_test_shopping/src/model/http_result.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

class Utils {
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height / 844;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width / 390;
  }

  static String numberFormat(int k) {
    if (k > 9) {
      return k.toString();
    } else {
      return "0$k";
    }
  }

  static String errorMessage(HttpResult response) {
    try {
      String msg = response.result["message"] ?? translate("error.error_title");
      return msg;
    } catch (_) {
      return translate("error.server_error_title");
    }
  }

  static String priceFormat(double price) {
    int k = price.toInt();
    if (k.toDouble() == price) {
      return NumberFormat("#,##0", "en").format(price);
    } else {
      return NumberFormat.currency(locale: "en", symbol: '').format(price);
    }
  }
}
