import 'package:flutter/material.dart';
import 'package:flutter_test_shopping/src/service/cache_service.dart';

class AppColor {
  /// fonts
  static const String fontFamily = "NunitoSans";

  ///color
  Color white = CacheService.getTheme()
      ? const Color(0xFF000000)
      : const Color(0xFFFFFFFF);
  Color black = CacheService.getTheme()
      ? const Color(0xFFFFFFFF)
      : const Color(0xFF000000);
  static const Color blue = Color(0xFF40BFFF);
  Color dark = CacheService.getTheme()
      ? const Color(0xFFBFC7CD)
      : const Color(0xFF223263);
  static const Color gray = Color(0xFFEBF0FF);
  static const Color yellow = Color(0xFFFFC833);
  static const Color red = Color(0xFFFB7181);
  static const Color neutralLight = Color(0xFFEBF0FF);

  initData() {
    black = CacheService.getTheme()
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF000000);
  }

  ///shimmer
  static const Color shimmerBaseColor = Color(0xE0E0E0FF);
  static const Color shimmerHighColor = Color(0xF5F5F5FF);
}

AppColor appColor = AppColor();
