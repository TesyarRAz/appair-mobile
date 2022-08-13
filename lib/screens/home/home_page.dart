import 'dart:async';

import 'package:appair/common/entities/setting.dart';
import 'package:appair/common/entities/user.dart';
import 'package:appair/common/widgets/background_widget.dart';
import 'package:appair/screens//home/home_controller.dart';
import 'package:appair/screens//home/widget/active_transaction_widget.dart';
import 'package:appair/screens//home/widget/info_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class HomePage extends GetView<HomeController> {
  final _homeInfoController = Get.find<HomeInfoController>();
  final _homeTransaksiController = Get.find<HomeTransaksiController>();
  final _user = Get.find<User>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ObxValue<Rx<Setting>>(
          (val) => Text(val.value.general?.appName ?? 'App Air'),
          controller.setting,
        ),
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
            size: const Size.fromHeight(200),
            child: ObxValue<Rx<Setting>>(
              (val) => BackgroundWidget(
                setting: val.value,
              ),
              controller.setting,
            ),
          ),
          RefreshIndicator(
            onRefresh: () => Future.wait(
                [_homeInfoController.load(), _homeTransaksiController.load()]),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(
                          height: 20,
                        ),
                        if (_user.customer?.isAllLunas ?? true)
                          Container()
                        else
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 20,
                                  child: Marquee(
                                    text:
                                        "Ada Pembayaran Yang Belum Terselesaikan",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Ubuntu",
                                      color: Colors.white,
                                    ),
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    blankSpace:
                                        MediaQuery.of(context).size.width,
                                    pauseAfterRound: const Duration(seconds: 5),
                                    accelerationDuration:
                                        const Duration(seconds: 1),
                                    accelerationCurve: Curves.linear,
                                    decelerationDuration:
                                        const Duration(milliseconds: 500),
                                    decelerationCurve: Curves.easeIn,
                                    showFadingOnlyWhenScrolling: true,
                                    startAfter: const Duration(seconds: 3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ActiveTransactionWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildInfoList(),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 40,
                        color: Colors.blue,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Copyright © 2020 MBCorp",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Ubuntu",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
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
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
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
                  fontFamily: "Ubuntu",
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
