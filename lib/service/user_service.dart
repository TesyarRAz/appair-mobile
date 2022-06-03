import 'package:appair/entities/user.dart';
import 'package:appair/repository/user_repository.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  final UserRepository repository;

  UserService({required this.repository});

  Future<User?> user() async {
    var data = await repository.user().catchError((error) => throw error);

    if (data.isNotEmpty) {
      return User.fromJson(data);
    }

    return null;
  }
}