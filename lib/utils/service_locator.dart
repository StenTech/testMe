import 'package:get_it/get_it.dart';
import 'package:testme/repository/api/user.repository.dart';
import 'package:testme/repository/db/db.helper.dart';

// The sercvice Locator of the application
// This class is used to register and resolve dependencies
class ServiceLocator {
  static void setup() {
    // Register dependencies
    //GetIt.I.registerSingleton<AuthService>(AuthService());

    // database helper
    GetIt.I.registerSingleton<DatabaseHelper>(DatabaseHelper());

    // repositories
    GetIt.I.registerLazySingleton<UserRepository>(() => UserRepository());
  }
}
