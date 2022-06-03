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
    var transaksiActiveResponse = controller.state?.transaksiActiveResponse;

    return GestureDetector(
      onTap: () {
        Get.toNamed("/bayar");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.fromSize(
          size: const Size.fromHeight(150),
          child: Card(
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Tagihan",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      const Spacer(),
                      Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: Colors.red,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu',
                        ),
                        label: Text(
                          transaksiActiveResponse?.data?.statusText ??
                              "Belum Bayar",
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    endIndent: 200,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "Tempo: ${transaksiActiveResponse?.data?.tanggalTempo ?? "-" }",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Ubuntu',
                        ),
                      )
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
