import 'package:appair/entities/user.dart';
import 'package:get/get.dart';

class Repository extends GetConnect {
  Repository({
    required String baseUrl,
  }) {
    this.baseUrl = baseUrl;
  }

  @override
  void onInit() {
    httpClient.addRequestModifier<dynamic>((request) async {
      request.headers['Accept'] = 'application/json';

      return request;
    });
  }
}

class AuthorizedRepository extends Repository {
  final UserToken userToken;

  AuthorizedRepository({required super.baseUrl, required this.userToken});

  @override
  void onInit() {
    super.onInit();

    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] = "Bearer ${userToken.token}";

      return request;
    });
  }
}