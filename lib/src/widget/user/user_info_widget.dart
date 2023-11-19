import 'package:flutter/material.dart';
import 'package:flutter_test_shopping/src/color/app_color.dart';
import 'package:flutter_test_shopping/src/model/user/user_model.dart';
import 'package:flutter_test_shopping/src/utils/utils.dart';
import 'package:flutter_test_shopping/src/widget/app/button_widget.dart';
import 'package:flutter_test_shopping/src/widget/app/text_widget.dart';
import 'package:flutter_test_shopping/src/widget/cart/cart_info_widget.dart';

class UserInfoWidget extends StatelessWidget {
  final UserModel data;

  const UserInfoWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    return Padding(
      padding: EdgeInsets.all(24 * h),
      child: Column(
        children: [
          CartInfoWidget(
            title: "Firstname:",
            text: data.name.firstname,
          ),
          CartInfoWidget(
            title: "Lastname:",
            text: data.name.lastname,
          ),
          CartInfoWidget(
            title: "Username:",
            text: data.username,
          ),
          CartInfoWidget(
            title: "Email:",
            text: data.email,
          ),
          CartInfoWidget(
            title: "City:",
            text: data.address.city,
          ),
          CartInfoWidget(
            title: "Street:",
            text: data.address.street,
          ),
          CartInfoWidget(
            title: "Zipcode:",
            text: data.address.zipcode,
          ),
          CartInfoWidget(
            title: "Number:",
            text: data.address.number.toString(),
          ),
          ButtonWidget(
            height: 48 * h,
            onTap: () {
              Utils.navigateTo(
                latitude: double.parse(data.address.geolocation.lat),
                longitude: double.parse(data.address.geolocation.long),
                label: data.address.street,
              );
            },
            widget: const Center(
              child: TextWidget(
                text: "Go to location",
                color: AppColor.white,
              ),
            ),
            margin: EdgeInsets.only(top: 24 * h),
            color: AppColor.blue,
          ),
        ],
      ),
    );
  }
}
