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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                          const Spacer(),
                          ObxValue<Rx<Setting>>(
                              (data) => Text(
                                    '${data.value.price?.perKubik.numberFormat ?? '-'} / Kubik',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Ubuntu',
                                    ),
                                  ),
                              controller.setting),
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
                          border: OutlineInputBorder(),
                          labelText: 'Masukkan Meteran Akhir',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(),
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
                        const Text(
                          "Silahkan Melakukan Pembayaran",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Rekening",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "BCA : 08123912321",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            Text(
                              "Mandiri : 1232193123",
                              style: TextStyle(
                                fontSize: 20,
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
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bukti Pembayaran',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Ubuntu',
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
                              return Image.memory(
                                snapshot.data!,
                                width: 400,
                                height: 300,
                                fit: BoxFit.contain,
                              );
                            }

                            return const Placeholder(
                              fallbackHeight: 400,
                              fallbackWidth: 400,
                            );
                          },
                        ),
                        onEmpty: const Placeholder(
                          fallbackWidth: 400,
                          fallbackHeight: 400,
                        ),
                        onLoading: const Placeholder(),
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
    );
  }
}
