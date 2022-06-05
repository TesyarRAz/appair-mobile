import 'package:appair/entities/info.dart';
import 'package:appair/entities/pagination.dart';
import 'package:appair/screens/home/home_controller.dart';
import 'package:appair/screens/webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_info/platform_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoList extends GetView<HomeController> {
  const InfoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<Pagination<Info>>>(
      (data) {
        if (data.value.data.isEmpty) {
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

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.value.data.length,
          itemBuilder: (context, index) {
            var info = data.value.data[index];

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
      controller.listInfoResponse,
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
