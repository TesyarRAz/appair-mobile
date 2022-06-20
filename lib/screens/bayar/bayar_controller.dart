import 'package:appair/common/entities/setting.dart';
import 'package:appair/screens//bayar/data/bayar_data.dart';
import 'package:appair/common/service/setting_service.dart';
import 'package:appair/common/service/transaksi_service.dart';
import 'package:appair/common/widgets/loading_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_info/platform_info.dart';

class BayarController extends GetxController with StateMixin<BayarData> {
  final settingService = Get.find<SettingService>();
  final transaksiService = Get.find<TransaksiService>();

  final kuantitas = 0.obs;
  final totalHarga = 0.obs;

  final jumlahKubikController = TextEditingController();

  final setting = Setting().obs;

  @override
  void onReady() {
    jumlahKubikController.addListener(() {
      kuantitas.value = int.tryParse(jumlahKubikController.text) ?? 0;
      totalHarga.value = kuantitas.value *
          (setting.value.price?.perKubik ?? 0);
    });

    settingService.settings().then((value) {
      setting.value = value;
    });
  }

  void openBuktiBayar() async {
    if (platform.isMobile || platform.isWeb) {
      var result = await Get.dialog(
        SimpleDialog(
          title: const Text('Ambil Gambar'),
          children: [
            TextButton(
              onPressed: () => Get.back(result: ImageSource.gallery),
              child: const Text('Galery'),
            ),
            TextButton(
              onPressed: () => Get.back(result: ImageSource.camera),
              child: const Text('Camera'),
            )
          ],
        ),
      );

      if (result != null) {
        var imagePicker = ImagePicker();
        var image = await imagePicker.pickImage(
          source: result,
        );

        if (image != null) {
          change(
            BayarData(
              imagePicker: image,
            ),
            status: RxStatus.success(),
          );
        }
      }
    } else if (platform.isDesktop) {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result != null) {
        var file = result.files.first;

        change(
          BayarData(
            filePicker: file,
          ),
          status: RxStatus.success(),
        );
      }
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: "Perangkat anda tidak mendukung file picker",
        duration: Duration(seconds: 3),
      ));
    }
  }

  void submit() async {
    if (state != null) {
      var response = await Get.showOverlay(
        asyncFunction: () async {
          var fileBytes =
              await state!.fileBytes.catchError((error) => throw error);

          if (fileBytes != null) {
            return await transaksiService
                .bayar(
                    fileBytes, kuantitas.value, state!.fileName ?? 'image.jpg')
                .catchError((error) => throw error);
          }

          return null;
        },
        loadingWidget: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: LoadingWidget(),
            ),
          ),
        ),
      ).catchError((error) {
        debugPrint(error.toString());
        Get.showSnackbar(
          const GetSnackBar(
            message: "Terjadi kesalahan, silahkan coba lagi",
            duration: Duration(seconds: 3),
          ),
        );
      });

      if (response?.success ?? false) {
        Get.back(result: true);
        Get.showSnackbar(const GetSnackBar(
          message: "Pengiriman Berhasil, menunggu untuk dikonfirmasi",
          duration: Duration(seconds: 3),
        ));
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: "Gagal mengirim data",
          duration: Duration(seconds: 3),
        ));
      }
    }
  }
}
