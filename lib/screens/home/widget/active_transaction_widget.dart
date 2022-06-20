import 'package:appair/screens/home/home_controller.dart';
import 'package:appair/service/transaksi_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appair/util/number_util.dart';
import 'package:appair/util/date_util.dart';

class ActiveTransactionWidget extends GetView<HomeController> {
  const ActiveTransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<TransaksiActiveResponse>>(
      (data) {
        return InkWell(
          onTap: () async {
            if (!(data.value.data?.status == "lunas" ||
                data.value.data?.status == "lewati")) {
              await Get.toNamed("/bayar");

              controller.load();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox.fromSize(
              size: const Size.fromHeight(200),
              child: Card(
                color: Colors.white,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            backgroundColor: data.value.data?.status == "lunas"
                                ? Colors.green
                                : Colors.red,
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                            ),
                            label: Text(
                              data.value.data?.statusText ?? "Belum Bayar",
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        endIndent: 200,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Harga: ${data.value.data?.totalHarga?.numberFormat ?? '-'}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          Text(
                            data.value.data?.tanggalTempo?.toDateTime().toDateFormat('MMMM') ?? "-",
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: data.value.data?.totalHarga != null,
                        child: Text(
                          "Total Bayar: ${data.value.data?.totalBayar?.numberFormat ?? '-'}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            "Tanggal Tempo: ${data.value.data?.tanggalTempo?.toDateTime().toDateFormat('dd-MMMM-yyyy') ?? "-"}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Tanggal Bayar: ${data.value.data?.tanggalBayar?.toDateTime().toDateFormat('dd-MMMM-yyyy') ?? "-"}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      controller.transaksiActiveResponse,
    );
  }
}
