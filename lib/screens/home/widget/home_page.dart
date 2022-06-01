import 'dart:async';

import 'package:appair/repository/info_repository.dart';
import 'package:appair/screens/home/widget/active_transaction_widget.dart';
import 'package:appair/screens/home/widget/info_list.dart';
import 'package:appair/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeData {
  ListInfoResponse listInfoResponse;

  HomeData({required this.listInfoResponse});
}

class HomeController extends GetxController with StateMixin<HomeData> {
  final _infoRepository = Get.find<InfoRepository>();

  @override
  void onReady() {
    change(null, status: RxStatus.loading());

    _infoRepository.getList().then((listInfoResponse) {
      if (listInfoResponse != null) {
        change(
            HomeData(
              listInfoResponse: listInfoResponse,
            ),
            status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error("Empty"));
      }
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Air"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.supervised_user_circle_sharp, size: 30),
          )
        ],
      ),
      body: RefreshIndicator(
        child: controller.obx(
          (state) => ListView(
            children: [
              ActiveTransactionWidget(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "News & Info",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      endIndent: 100,
                    ),
                    InfoList(
                      homeData: state!,
                    ),
                  ],
                ),
              ),
            ],
          ),
          onLoading: const Center(
            child: LoadingWidget(),
          ),
        ),
        onRefresh: () async {},
      ),
    );
  }
}
