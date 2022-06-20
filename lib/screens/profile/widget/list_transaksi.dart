import 'package:appair/screens/profile/profile_controller.dart';
import 'package:appair/screens/profile/profile_page.dart';
import 'package:appair/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:appair/util/date_util.dart';

class ListTransaksi extends GetView<ProfileController> {
  const ListTransaksi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        var listTransaksiResponse = state?.listTransaksiResponse;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: listTransaksiResponse?.data.length,
          itemBuilder: (context, index) {
            var transaksi = listTransaksiResponse!.data[index];
            return Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          transaksi.kode,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Ubuntu",
                          ),
                        ),
                        Spacer(),
                        Text(
                          transaksi.tanggalBayar?.toDateTime().toDateFormat('dd-MMMM-yyyy') ?? '-',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Ubuntu",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: transaksi.status == "lunas"
                              ? Colors.green
                              : Colors.red,
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                          ),
                          label: Text(
                            transaksi.statusText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      // onLoading: const Center(
      //   child: LoadingWidget(),
      // ),
      onEmpty: Column(
        children: const [
          SizedBox(
            height: 10,
          ),
          Text('Tidak ada riwayat pembayaran'),
        ],
      ),
    );
  }
}
