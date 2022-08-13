import 'package:appair/screens/webview/webview_controller.dart';
import 'package:get/get.dart';

class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebViewController());
  }
}