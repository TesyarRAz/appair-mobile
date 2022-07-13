import 'package:appair/common/entities/info.dart';
import 'package:appair/screens//home/home_controller.dart';
import 'package:appair/screens//webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_info/platform_info.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoList extends GetView<HomeInfoController> {
  const InfoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (data) {
        if (data == null) {
          return const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Terjadi masalah saat meload data',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 14,
              ),
            ),
          );
        }

        if (data.data.isEmpty) {
          return const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Tidak Ada Data',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 14,
              ),
            ),
          );
        }

        var dataList = data.data;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            var info = dataList[index];

            return Padding(
              key: ObjectKey(info),
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: SizedBox.fromSize(
                size: const Size.fromHeight(260),
                child: Card(
                  elevation: 10,
                  child: InkWell(
                    onTap: () => openBrowser(info),
                    child: Column(
                      children: [
                        Expanded(
                          child: info.image != null
                              ? CachedNetworkImage(
                                  imageUrl: info.image!,
                                  fit: BoxFit.cover,
                                  imageBuilder: (_, imageProvider) =>
                                      imageBuilder(imageProvider),
                                )
                              : Image.asset(
                                  "images/empty-image.png",
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            info.title,
                            style: const TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      onLoading: SizedBox.fromSize(
        size: const Size.fromHeight(260),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(),
        ),
      ),
      onEmpty: SizedBox.fromSize(
        size: const Size.fromHeight(260),
        child: const Center(
          child: Text("Tidak ada data"),
        ),
      ),
      onError: (error) => SizedBox.fromSize(
        size: const Size.fromHeight(260),
        child: Center(
          child: Text("Terjadi masalah saat meload data : ${error.toString()}"),
        ),
      ),
    );
  }

  Widget imageBuilder(ImageProvider<Object> imageProvider) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void openBrowser(Info info) async {
    if (info.url == null) return;

    if (platform.isMobile) {
      Get.to(WebViewPage(url: info.url!), transition: Transition.rightToLeft);
    } else {
      Get.dialog(AlertDialog(
        content: const Text('Ini akan membuka browser secara langsung'),
        actions: [
          TextButton(
            onPressed: () async {
              if (await canLaunchUrlString(info.url!)) {
                await launchUrlString(info.url!);
              }
            },
            child: const Text('Oke'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Batal'),
          ),
        ],
      ));
    }
  }
}
