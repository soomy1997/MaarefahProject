import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:flutter_app_1/services/user_controller.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupServices() async {
  locator.registerSingleton<UserController>(UserController());
  locator.registerSingleton<CurrentUser>(CurrentUser());
}
