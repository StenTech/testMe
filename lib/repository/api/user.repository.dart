import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:testme/model/user.dart';

///
/// get users from : ramdomuser.me/api
///

class UserRepository {
  static const String _baseUrl = 'https://randomuser.me/api';

  final Dio _dio = Dio();

  /// get [nbUser] from the api
  Future<List<User>> getUsers({int nbUser=100}) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'results': nbUser,
      'nat': 'us,dk,fr,br,gb'
    });
    if (kDebugMode) {
      print(response.data);
    }
    final List<User> users = [];
    final List<dynamic> results = response.data['results'];
    for (final json in results) {
      users.add(User.fromJson(json));
    }

    return users;
  }

}
