import 'package:appair/common/entities/setting.dart';
import 'package:appair/common/util/color_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundWidget extends GetWidget {
  final Setting setting;

  const BackgroundWidget({required this.setting, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: setting.style?.bgType == "image"
          ? BoxDecoration(
              // color: Colors.blue,
              image: DecorationImage(
                image: _buildBackgroundImage(setting),
                fit: BoxFit.cover,
              ),
            )
          : BoxDecoration(
              color: setting.style?.bgColor != null
                  ? Color(setting.style!.bgColor!.toColor())
                  : Colors.blue,
            ),
    );
  }

  ImageProvider<Object> _buildBackgroundImage(Setting setting) {
    var image = setting.style?.bgImage;

    if (image != null) {
      return NetworkImage(image);
    }

    return const AssetImage("images/default-image.png");
  }
}
