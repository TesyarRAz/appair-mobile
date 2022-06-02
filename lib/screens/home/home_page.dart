import 'dart:async';

import 'package:appair/repository/info_repository.dart';
import 'package:appair/repository/transaksi_repository.dart';
import 'package:appair/screens/home/widget/active_transaction_widget.dart';
import 'package:appair/screens/home/widget/info_list.dart';
import 'package:appair/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeData {
  ListInfoResponse listInfoResponse;
  TransaksiNowResponse transaksiNowResponse;

  HomeData(
      {required this.listInfoResponse, required this.transaksiNowResponse});
}

class HomeController extends GetxController with StateMixin<HomeData> {
  final _infoRepository = Get.find<InfoRepository>();
  final _transaksiRepository = Get.find<TransaksiRepository>();

  @override
  void onReady() {
    change(null, status: RxStatus.loading());

    Future.wait([
      _infoRepository.getList(),
      _transaksiRepository.transaksiNow(),
    ]).then((value) {
      var listInfoResponse = value[0];
      var transaksiNowResponse = value[1];

      if (listInfoResponse != null) {
        change(
            HomeData(
              listInfoResponse: listInfoResponse as ListInfoResponse,
              transaksiNowResponse:
                  transaksiNowResponse as TransaksiNowResponse,
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
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onPressed: () {
              Get.toNamed("/profile");
            },
            icon: const Icon(Icons.supervised_user_circle_sharp, size: 30),
          )
        ],
      ),
      body: RefreshIndicator(
        child: controller.obx(
          (state) => ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              if (index == 0) return const ActiveTransactionWidget();
              if (index == 1) {
                return const SizedBox(
                  height: 20,
                );
              }
              if (index == 2) return _buildInfoList();

              return Container();
            },
          ),
          onLoading: const Center(
            child: LoadingWidget(),
          ),
        ),
        onRefresh: () async {},
      ),
    );
  }

  Widget _buildInfoList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "News & Info",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            endIndent: 100,
          ),
          InfoList(),
        ],
      ),
    );
  }
}
