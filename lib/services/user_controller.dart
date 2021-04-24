import 'package:flutter_app_1/models/users.dart';
import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:flutter_app_1/services/locator.dart';

class UserController {
  CurrentUser _authRepo = locator.get<CurrentUser>();
  OurUser _currentUser;
  Future init;
  UserController();

  Future<OurUser> initUser() async {
    _currentUser = await _authRepo.getCurrntUser;
    return _currentUser;
  }

  Future<bool> validateCurrentPassword(String password) async {
    return await _authRepo.validatePassword(password);
  }
}
