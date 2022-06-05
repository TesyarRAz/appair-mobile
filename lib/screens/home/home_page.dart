import 'dart:async';

import 'package:appair/entities/info.dart';
import 'package:appair/entities/pagination.dart';
import 'package:appair/repository/info_repository.dart';
import 'package:appair/repository/transaksi_repository.dart';
import 'package:appair/screens/home/home_controller.dart';
import 'package:appair/screens/home/widget/active_transaction_widget.dart';
import 'package:appair/screens/home/widget/info_list.dart';
import 'package:appair/service/info_service.dart';
import 'package:appair/service/transaksi_service.dart';
import 'package:appair/widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox.fromSize(
            size: const Size.fromHeight(300),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          RefreshIndicator(
            onRefresh: controller.load,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const ActiveTransactionWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildInfoList()
                ],
              ),
            ),
          ),
        ],
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
