import 'package:appair/common/widgets/loading_widget.dart';
import 'package:appair/screens/setting/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        title: const Text("App Air"),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Ganti Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
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
                  SizedBox(
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
                  SizedBox(
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
        ],
      ),
    );
  }
}
