import 'package:appair/screens/home/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoList extends GetView<HomeController> {
  const InfoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.state?.listInfoResponse.data.length,
      itemBuilder: (context, index) {
        var info = controller.state?.listInfoResponse.data[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 1,
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  CachedNetworkImage(
                          imageUrl: info?.image ?? 'http://localhost:8000/empty-image.png',
                          imageBuilder: (_, imageProvider) =>
                              imageBuilder(imageProvider),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      info?.title ?? '',
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
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
}
