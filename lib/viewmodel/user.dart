import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:testme/model/user.dart';
import 'package:testme/repository/db/db.helper.dart';

class UserViewModel extends ChangeNotifier {
  // get db helper
  final db = GetIt.I.get<DatabaseHelper>();
  List<User> users = [];
  int pageNumber = 0;
  bool isLastPage = false;

  // get users
  Future<List> getUsers({int limit = 15, int offset = 0}) async {
    if (!isLastPage) {
      pageNumber++;
      final usersList = await db.getUsers(
        limit: limit,
        offset: offset,
      );
      if (usersList.length < limit) {
        isLastPage = true;
      }
      users.addAll(usersList);
      // incrementPageNumber();
      notifyListeners();
      return users;
    } else {
      return users;
    }
  }

  // increment page number
  void incrementPageNumber() {
    pageNumber++;
    notifyListeners();
  }

  // get user by uuid
  Future getUser(String uuid) async {
    return await db.getUser(uuid);
  }

  // get number of users in table
  Future<int> countUsers() async {
    return await db.countUsers();
  }

  // insert user into table
  Future<int> insertUser(User user) async {
    int res = await db.insertUser(user);
    users.add(user);
    return res;
  }

  // insert users into table
  Future<int> insertUsers(List<User> users) async {
    int res = await db.insertUsers(users);
    this.users.addAll(users);
    return res;
  }

  // update user
  Future<int> updateUser(User user) async {
    await db.updateUser(user);
    notifyListeners();
    return 1;
  }

  // delete user
  Future<int> deleteUser(User user) async {
    await db.deleteUser(user);
    users.remove(user);
    notifyListeners();
    return 1;
  }

  // not
}
