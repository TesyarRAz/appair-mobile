import 'package:appair/screens//home/home_controller.dart';
import 'package:appair/common/service/transaksi_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appair/common/util/number_util.dart';
import 'package:appair/common/util/date_util.dart';
import 'package:shimmer/shimmer.dart';

class ActiveTransactionWidget extends GetView<HomeTransaksiController> {
  const ActiveTransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox.fromSize(
        size: const Size.fromHeight(200),
        child: controller.obx(
          (data) {
            return InkWell(
              onTap: () async {
                if (!(data?.data?.status == "lunas" ||
                    data?.data?.status == "lewati")) {
                  await Get.toNamed("/bayar");

                  controller.load();
                }
              },
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
                            backgroundColor: data?.data?.status == "lunas"
                                ? Colors.green
                                : Colors.red,
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                            ),
                            label: Text(
                              data?.data?.statusText ?? "Belum Bayar",
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
                            "Total Harga: ${data?.data?.totalHarga?.numberFormat ?? '-'}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          Text(
                            data?.data?.tanggalTempo
                                    ?.toDateTime()
                                    .toDateFormat('MMMM') ??
                                "-",
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
                        visible: data?.data?.totalHarga != null,
                        child: Text(
                          "Total Bayar: ${data?.data?.totalBayar?.numberFormat ?? '-'}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Tanggal Tempo: ${data?.data?.tanggalTempo?.toDateTime().toDateFormat('dd-MMMM-yyyy') ?? "-"}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Tanggal Bayar: ${data?.data?.tanggalBayar?.toDateTime().toDateFormat('dd-MMMM-yyyy') ?? "-"}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          onEmpty: const Card(
            child: Center(
              child: Text("Data tidak ada"),
            ),
          ),
          onLoading: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(),
          ),
          onError: (error) => Card(
            child: Center(
              child: Text("Data gagal dimuat : ${error.toString()}"),
            ),
          ),
        ),
      ),
    );
  }
}
