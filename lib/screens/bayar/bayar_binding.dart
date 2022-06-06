import 'package:appair/screens/bayar/bayar_controller.dart';
import 'package:get/get.dart';

class BayarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BayarController());
  }
}