import 'package:appair/common/entities/info.dart';
import 'package:appair/common/entities/pagination.dart';
import 'package:appair/common/service/info_service.dart';
import 'package:appair/common/service/transaksi_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _infoService = Get.find<InfoService>();
  final _transaksiService = Get.find<TransaksiService>();

  final listInfoResponse = Pagination<Info>().obs;
  final transaksiActiveResponse = TransaksiActiveResponse().obs;

  @override
  void onInit() {
    super.onInit();

    load();
  }

  Future<void> load() {
    return Future.wait([
      _transaksiService.transaksiActive().then((value) {
        transaksiActiveResponse.value = value;
      }),
      _infoService.list().then((value) {
        listInfoResponse.value = value;
      }),
    ]);
  }
}
