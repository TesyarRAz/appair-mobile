import 'dart:async';

import 'package:appair/entities/info.dart';
import 'package:appair/entities/pagination.dart';
import 'package:appair/repository/info_repository.dart';
import 'package:appair/repository/transaksi_repository.dart';
import 'package:appair/screens/home/widget/active_transaction_widget.dart';
import 'package:appair/screens/home/widget/info_list.dart';
import 'package:appair/service/info_service.dart';
import 'package:appair/service/transaksi_service.dart';
import 'package:appair/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeData {
  Pagination<Info> listInfoResponse;
  TransaksiActiveResponse transaksiActiveResponse;

  HomeData(
      {required this.listInfoResponse, required this.transaksiActiveResponse});
}

class HomeController extends GetxController with StateMixin<HomeData> {
  final _infoService = Get.find<InfoService>();
  final _transaksiService = Get.find<TransaksiService>();

  @override
  void onInit() {
    super.onInit();

    _load();
  }

  Future<void> _load() {
    change(null, status: RxStatus.loading());

    return Future.wait([
      _infoService.list(),
      _transaksiService.transaksiActive(),
    ]).then((value) {
      var listInfoResponse = value[0] as Pagination<Info>;
      var transaksiActiveResponse = value[1] as TransaksiActiveResponse;

      if (listInfoResponse.isNotEmpty) {
        change(
          HomeData(
            listInfoResponse: listInfoResponse,
            transaksiActiveResponse: transaksiActiveResponse,
          ),
          status: RxStatus.success(),
        );
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
        onRefresh: controller._load,
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
      ),
    );
  }

  Widget _buildInfoList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
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
        ),
      ),
    );
  }
}
