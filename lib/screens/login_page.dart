import 'package:appair/repository/auth_repository.dart';
import 'package:appair/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final _txtUsername = TextEditingController();
  final _txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginFormKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              TextFormField(
                controller: _txtPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_loginFormKey.currentState?.validate() ?? false) {
      var username = _txtUsername.text;
      var password = _txtPassword.text;

      var auth = Get.find<AuthRepository>();

      Get.showOverlay(
        asyncFunction: () => auth.login(username, password),
        loadingWidget: const SimpleDialog(
          children: [
            LoadingWidget(),
          ],
        ),
      ).then((value) {
        if (value.isLoggedIn) {
          var prefs = Get.find<SharedPreferences>();

          prefs.setString("userToken", value.userToken!.token!);

          Get.offAllNamed('/home');
        } else {
          Get.snackbar(
            'Login',
            "Username atau password salah",
            icon: const Icon(Icons.error),
            backgroundColor: Colors.red,
          );
        }
      });
    }
  }
}
