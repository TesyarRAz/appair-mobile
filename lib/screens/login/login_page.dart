import 'package:appair/common/entities/setting.dart';
import 'package:appair/common/widgets/background_widget.dart';
import 'package:appair/screens//login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  final _loginFormKey = GlobalKey<FormState>();

  final _txtUsername = TextEditingController();
  final _txtPassword = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox.fromSize(
            size: Size.fromHeight(MediaQuery.of(context).size.height / 2.3),
            child: ObxValue<Rx<Setting>>(
              (val) => BackgroundWidget(
                setting: val.value,
              ),
              controller.setting,
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                // Icon(
                //   Icons.water,
                //   size: 100,
                //   color: Colors.white,
                // ),
                ObxValue<Rx<Setting>>(
                  (val) {
                    var child = Text(
                      val.value.general?.appName ?? 'App Air',
                      style: TextStyle(
                        color: val.value.style?.bgType == "image"
                            ? Colors.black
                            : Colors.white,
                        fontSize: 32,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                      ),
                    );

                    return val.value.style?.bgType == "image"
                        ? Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(8),
                            child: child,
                          )
                        : child;
                  },
                  controller.setting,
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Form(
                key: _loginFormKey,
                child: SizedBox(
                  height: 300,
                  width: 400,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _txtUsername,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username or Email',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ObxValue<RxBool>(
                            (hide) {
                              return TextField(
                                controller: _txtPassword,
                                obscureText: hide.value,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: "Password Baru",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      hide.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      hide.value = !hide.value;
                                    },
                                  ),
                                ),
                              );
                            },
                            true.obs,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: _login,
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() {
    if (_loginFormKey.currentState?.validate() ?? false) {
      var username = _txtUsername.text;
      var password = _txtPassword.text;

      controller.login(username, password);
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: "Inputan kurang",
        duration: Duration(seconds: 2),
      ));
    }
  }
}
