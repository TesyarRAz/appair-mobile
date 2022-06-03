import 'package:appair/entities/pagination.dart';
import 'package:appair/entities/transaksi.dart';
import 'package:appair/entities/user.dart';
import 'package:appair/screens/profile/widget/list_transaksi.dart';
import 'package:appair/service/auth_service.dart';
import 'package:appair/service/transaksi_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileData {
  final Pagination<Transaksi> listTransaksiResponse;

  ProfileData({required this.listTransaksiResponse});
}

class ProfileController extends GetxController with StateMixin<ProfileData> {
  final _transaksiService = Get.find<TransaksiService>();

  @override
  void onInit() {
    super.onInit();

    _load();
  }

  void _load() {
    _transaksiService.history().then((value) {
      if (value.isNotEmpty) {
        change(
          ProfileData(
            listTransaksiResponse: value,
          ),
          status: RxStatus.success(),
        );
      } else {
        change(null, status: RxStatus.empty());
      }
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}

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
                  content: Text("Yakin ingin logout ?"),
                  actions: [
                    TextButton(
                      child: const Text("Ya"),
                      onPressed: () {
                        Get.back();
                        Get.find<AuthService>().clearLoginToken();

                        Get.offAndToNamed("/login");
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
                      style:
                          const TextStyle(fontSize: 20, fontFamily: "Ubuntu"),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 100),
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Riwayat Pembayaran",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Ubuntu",
                  ),
                ),
              ),
              ListTransaksi(),
            ],
          )
        ],
      ),
    );
  }
}
