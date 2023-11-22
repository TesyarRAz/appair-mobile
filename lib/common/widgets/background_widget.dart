import 'package:appair/common/entities/setting.dart';
import 'package:appair/common/util/color_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundWidget extends StatelessWidget {
  final Setting setting;

  const BackgroundWidget({required this.setting, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (setting.style?.bgType == "image") {
      return _buildBackgroundImage(setting);
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: setting.style?.bgColor != null
            ? setting.style!.bgColor!.toColor()
            : Colors.blue,
      ),
    );
  }

  Widget _buildBackgroundImage(Setting setting) {
    var image = setting.style?.bgImage;

    if (image != null) {
      return CachedNetworkImage(
        imageUrl: Get.find(tag: "baseUrl") + "/storage/" + image,
        fit: BoxFit.cover,
        placeholder: (_, str) => const DecoratedBox(
          decoration: BoxDecoration(
            // color: Colors.blue,
            image: DecorationImage(
              image: AssetImage("images/default-image.png"),
              fit: BoxFit.contain,
              repeat: ImageRepeat.noRepeat,
            ),
          ),
        ),
      );

      // return NetworkImage(Get.find(tag: "baseUrl") + "/storage/" + image);
    }

    return const DecoratedBox(
      decoration: BoxDecoration(
        // color: Colors.blue,
        image: DecorationImage(
          image: AssetImage("images/default-image.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
