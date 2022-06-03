import 'package:appair/screens/profile/profile_page.dart';
import 'package:appair/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

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
              child: Column(
                children: [
                  Text(transaksi.kode),
                  Spacer(),
                  Text(transaksi.tanggalBayar ?? '-'),
                ],
              )
            );
          },
        );
      },
      onLoading: const Center(
        child: LoadingWidget(),
      ),
      onEmpty: Column(
        children: const [
          SizedBox(height: 10,),
          Text('Tidak ada riwayat pembayaran'),
        ],
      ),
    );
  }
}