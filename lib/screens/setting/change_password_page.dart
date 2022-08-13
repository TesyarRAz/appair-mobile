import 'package:appair/common/entities/setting.dart';
import 'package:appair/screens/setting/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  final _txtOldPassword = TextEditingController();
  final _txtNewPassword = TextEditingController();
  final _txtNewPasswordConfirmation = TextEditingController();

  ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ObxValue<Rx<Setting>>(
          (val) => Text(val.value.general?.appName ?? 'App Air'),
          controller.setting,
        ),
        leading: const BackButton(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Ganti Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ObxValue<RxBool>(
                      (hide) {
                        return TextField(
                          controller: _txtOldPassword,
                          obscureText: hide.value,
                          decoration: InputDecoration(
                            labelText: "Password Lama",
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
                      height: 10,
                    ),
                    ObxValue<RxBool>(
                      (hide) {
                        return TextField(
                          controller: _txtNewPassword,
                          obscureText: hide.value,
                          decoration: InputDecoration(
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
                      height: 10,
                    ),
                    ObxValue<RxBool>(
                      (hide) {
                        return TextField(
                          controller: _txtNewPasswordConfirmation,
                          obscureText: hide.value,
                          decoration: InputDecoration(
                            labelText: "Konfirmasi Password Baru",
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
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        String oldPassword = _txtOldPassword.text;
                        String newPassword = _txtNewPassword.text;
                        String newPasswordConfirmation =
                            _txtNewPasswordConfirmation.text;

                        controller.changePassword(oldPassword, newPassword, newPasswordConfirmation);
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text("Ganti Password"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
