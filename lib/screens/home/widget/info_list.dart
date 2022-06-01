import 'package:appair/screens/home/widget/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InfoList extends StatelessWidget {
  final HomeData homeData;

  const InfoList({Key? key, required this.homeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: homeData.listInfoResponse.data.length,
      itemBuilder: (context, index) {
        var info = homeData.listInfoResponse.data[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 1,
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  CachedNetworkImage(
                          imageUrl: info.image ?? 'http://localhost:8000/empty-image.png',
                          imageBuilder: (_, imageProvider) =>
                              imageBuilder(imageProvider),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      info.title,
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
