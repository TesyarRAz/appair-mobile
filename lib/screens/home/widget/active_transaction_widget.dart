import 'package:appair/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ActiveTransactionWidget extends GetView<HomeController> {
  const ActiveTransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var transaksiNowResponse = controller.state?.transaksiNowResponse;

    return GestureDetector(
      onTap: () {
        Get.toNamed("/list/transaksi");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.fromSize(
          size: const Size.fromHeight(150),
          child: Card(
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Tagihan"),
                      Spacer(),
                      Chip(
                        backgroundColor: Colors.red,
                        label: Text(
                          transaksiNowResponse?.data?.statusText ?? "Belum Bayar",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Rp. ${transaksiNowResponse?.data?.totalHarga ?? 0}")
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}