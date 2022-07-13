import 'package:appair/common/entities/info.dart';
import 'package:appair/common/entities/pagination.dart';
import 'package:appair/common/service/info_service.dart';
import 'package:appair/common/service/transaksi_service.dart';
import 'package:get/get.dart';

class HomeInfoController extends GetxController with StateMixin<Pagination<Info>> {
  final _infoService = Get.find<InfoService>();

  @override
  void onInit() {
    super.onInit();

    load();
  }

  Future<void> load() {
    return _infoService.list().then((value) {
      if (value?.isNotEmpty ?? false) {
        change(value, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    }).catchError((error) {
      change(null, status: RxStatus.error(error));
    });
  }
}

class HomeTransaksiController extends GetxController with StateMixin<TransaksiActiveResponse> {
  final _transaksiService = Get.find<TransaksiService>();

  @override
  void onInit() {
    super.onInit();

    load();
  }

  Future<void> load() {
    return _transaksiService.transaksiActive().then((value) {
      if (value.data != null) {
        change(value, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    }).catchError((error) {
      change(null, status: RxStatus.error(error));
    });
  }
}