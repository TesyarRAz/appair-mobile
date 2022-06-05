import 'package:appair/entities/user.dart';
import 'package:appair/repository/auth_repository.dart';
import 'package:appair/service/auth_service.dart';
import 'package:appair/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
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

  final _authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox.fromSize(
            size: Size.fromHeight(MediaQuery.of(context).size.height / 2.3),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Column(
              children: const [
                Icon(
                  Icons.water,
                  size: 100,
                  color: Colors.white,
                ),
                Text(
                  "AppAir",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'Ubuntu',
                  ),
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
                          TextFormField(
                            controller: _txtPassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
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

  void _login() async {
    if (_loginFormKey.currentState?.validate() ?? false) {
      var username = _txtUsername.text;
      var password = _txtPassword.text;

      var loginResponse = await Get.showOverlay(
        asyncFunction: () => _authService.login(username, password),
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
      );

      if (loginResponse.isLoggedIn) {
          await _authService.setLoginToken(loginResponse.authToken!);

          debugPrint(Get.isRegistered<AuthToken>().toString());

          Get.offAllNamed('/home');
        } else {
          Get.showSnackbar(const GetSnackBar(
            message: "Username atau password salah",
            duration: Duration(seconds: 2),
          ));
        }
    }
  }
}
