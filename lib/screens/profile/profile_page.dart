import 'package:appair/entities/pagination.dart';
import 'package:appair/entities/transaksi.dart';
import 'package:appair/entities/user.dart';
import 'package:appair/screens/profile/profile_controller.dart';
import 'package:appair/screens/profile/widget/list_transaksi.dart';
import 'package:appair/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  final user = Get.find<User>();

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Air"),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
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
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox.fromSize(
                size: const Size.fromHeight(200),
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
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
          SizedBox(height: 80),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTransaksi(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
