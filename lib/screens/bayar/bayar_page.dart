import 'dart:typed_data';

import 'package:appair/common/entities/setting.dart';
import 'package:appair/screens//bayar/bayar_controller.dart';
import 'package:appair/common/util/number_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BayarPage extends GetView<BayarController> {
  const BayarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Air'),
        leading: const BackButton(),
        actions: [
          IconButton(
            onPressed: controller.submit,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox.fromSize(
            size: const Size.fromHeight(300),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Harga',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                              const Divider(),
                              const Spacer(),
                              ObxValue<Rx<Setting>>(
                                (data) => Text(
                                  '${data.value.price?.perKubik.numberFormat ?? '-'} / Kubik',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                                controller.setting,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Harga Abudemen',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                              const Spacer(),
                              ObxValue<Rx<Setting>>(
                                (data) => Text(
                                  data.value.price?.abudemen.numberFormat ??
                                      '-',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                                controller.setting,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ObxValue<RxInt>(
                            (data) => Text(
                              "Meteran Awal : ${data.value}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            controller.meteranAwal,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: controller.meteranAkhirController,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Masukkan Meteran Akhir',
                            ),
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ObxValue<RxInt>(
                            (data) => Text(
                              'Total Kubik Penggunaan : ${data.value}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            controller.meteranDigunakan,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ObxValue<RxInt>(
                            (data) => Text(
                              'Total Harga : ${data.value.numberFormat}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            controller.totalHarga,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: const Size.fromHeight(200),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "Silahkan Melakukan Pembayaran",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Rekening",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ObxValue<Rx<Setting>>(
                                  (value) => Text(
                                    value.value.general?.mobileRekeningInfo ??
                                        '',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  ),
                                  controller.setting,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Bukti Pembayaran',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          controller.obx(
                            (state) => FutureBuilder<Uint8List?>(
                              future: state?.fileBytes,
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return GestureDetector(
                                    onTap: controller.openBuktiBayar,
                                    child: Center(
                                      child: Image.memory(
                                        snapshot.data!,
                                        height: 300,
                                        width: 400,
                                        alignment: Alignment.center,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  );
                                }

                                return _buildImagePlaceholder();
                              },
                            ),
                            onEmpty: _buildImagePlaceholder(),
                            onLoading: _buildImagePlaceholder(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              minimumSize: MaterialStateProperty.all(
                                  const Size.fromHeight(50)),
                            ),
                            onPressed: controller.openBuktiBayar,
                            child: const Text(
                              "Atur Bukti Pembayaran",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Ubuntu',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return GestureDetector(
      onTap: controller.openBuktiBayar,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          height: 400,
          child: const Center(
            child: Text(
              'Tap untuk memilih gambar',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ),
    );
  }
}
