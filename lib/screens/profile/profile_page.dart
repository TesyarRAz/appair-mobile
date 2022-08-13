import 'package:appair/common/entities/setting.dart';
import 'package:appair/common/entities/user.dart';
import 'package:appair/common/widgets/background_widget.dart';
import 'package:appair/screens//profile/profile_controller.dart';
import 'package:appair/screens//profile/widget/list_transaksi.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appair/common/util/color_util.dart';

class ProfilePage extends GetView<ProfileController> {
  final user = Get.find<User>();

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ObxValue<Rx<Setting>>(
          (val) => Text(val.value.general?.appName ?? 'App Air'),
          controller.setting,
        ),
        leading: const BackButton(),
        actions: [
          PopupMenuButton(
            // child: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "change-password",
                child: Text("Ganti Password"),
              ),
              const PopupMenuItem(
                value: "logout",
                child: Text("Logout"),
              ),
            ],
            onSelected: (value) {
              if (value == 'change-password') {
                Get.toNamed("/change-password");
              } else if (value == 'logout') {
                Get.dialog(
                  AlertDialog(
                    content: const Text("Yakin ingin logout ?"),
                    actions: [
                      TextButton(
                        child: const Text("Ya"),
                        onPressed: () {
                          controller.logout();

                          Get.back();
                        },
                      ),
                      TextButton(
                        child: const Text("Tidak"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.load();
        },
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
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Stack(
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
                            Positioned(
                              top: 125,
                              left: MediaQuery.of(context).size.width / 2 - 50,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CircleAvatar(
                                    radius: 50,
                                    child: Icon(
                                      Icons.supervised_user_circle,
                                      size: 100,
                                    ),
                                  ),
                                  Text(
                                    user.name ?? '',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Ubuntu",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Expanded(
                                      child: Divider(
                                    endIndent: 20,
                                  )),
                                  Text(
                                    "Riwayat Pembayaran",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Ubuntu",
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      indent: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ListTransaksi(),
                            ),
                          ],
                        )
                      ],
                    ),
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
    );
  }
}
