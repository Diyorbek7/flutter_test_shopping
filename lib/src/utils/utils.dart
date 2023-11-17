import 'package:flutter/cupertino.dart';
import 'package:flutter_test_shopping/src/model/http_result.dart';

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
      String msg = response.result["message"] ?? "Error";
      return msg;
    } catch (_) {
      return "Server error";
    }
  }

  static String getDateHourFormat(DateTime dateTime) {
    return "${numberFormat(dateTime.day)}.${numberFormat(dateTime.month)}.${dateTime.year} ${numberFormat(dateTime.hour)}:${numberFormat(dateTime.minute)}";
  }
}
