import 'package:appair/common/entities/user.dart';
import 'package:appair/common/repository/user_repository.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  final UserRepository repository;

  UserService({required this.repository});

  Future<User?> user({bool register = true}) async {
    var data = await repository.user().catchError((error) => throw error);

    if (data.isNotEmpty) {
      var user = User.fromJson(data);
      
      if (register) {
        Get.put(user);
      }

      return user;
    }

    return null;
  }

  Future<bool> changePassword(
    String oldPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    var data = await repository.changePassword(
      oldPassword,
      newPassword,
      newPasswordConfirmation,
    ).catchError((error) => throw error);

    if (data.isNotEmpty) {
      return true;
    }

    return false;
  }
}