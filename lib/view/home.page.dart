import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:testme/common/theme/app_color.dart';
import 'package:testme/model/user.dart';
import 'package:testme/view/components/general_app_bar.dart';
import 'package:testme/view/components/simple_app_bar.dart';
import 'package:testme/view/user/user_resume.view.dart';
import 'package:testme/viewmodel/user.dart';

import '../repository/db/db.helper.dart';
import 'components/search_bar_component.dart';
import 'user/user_form.view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = GetIt.I.get<DatabaseHelper>();
  late bool _error;
  late bool _loading;
  late Map<String, String> _errorData;

  @override
  void initState() {
    super.initState();
    // dbHelper.ensureDb();
    _error = false;
    _loading = false;
    _errorData = {};
    _getUsers(offset: 0);
  }

  @override
  void dispose() {
    dbHelper.close();
    super.dispose();
  }

  Future<void> _getUsers({
    int limit = 15,
    required int offset,
  }) async {
    setState(() {
      _loading = true;
    });

    try {
      // Charger les utilisateurs depuis le ViewModel
      await Provider.of<UserViewModel>(context, listen: false).getUsers(
        limit: limit,
        offset: offset,
      );

      setState(() {
        _loading = false;
      });
    } catch (error, stackTrace) {
      setState(() {
        _loading = false;
        _error = true;
        _errorData = {
          'error': error.toString(),
          'stackTrace': stackTrace.toString()
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        title: widget.title,
      ),
      body: Center(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            _seatchBarSection(context),
            Expanded(
              child: Consumer<UserViewModel>(
                builder: (context, uservm, child) {
                  if (uservm.users.isEmpty) {
                    if (kDebugMode) {
                      print("empty");
                    }
                    if (!_loading) {
                      // Charger les utilisateurs ici plutôt que d'utiliser setState()
                      uservm.getUsers();
                    }
                  }
                  if (_loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.iconPrimaryColor,
                        value: 2,
                      ),
                    );
                  } else {
                    if (_error) {
                      if (kDebugMode) {
                        print(_errorData['stackTrace']);
                      }
                      return Center(
                        child: Text("Error: ${_errorData['error']}"),
                      );
                    } else {
                      List usersList = uservm.users;

                      if (kDebugMode) {
                        print("page : ${uservm.pageNumber + 1}");
                        print("Number of users: ${usersList.length}");
                      }

                      if (usersList.isEmpty) {
                        return const Center(
                          child: Text('No users found'),
                        );
                      }

                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: ListView.builder(
                          itemCount: usersList.length,
                          itemBuilder: (context, index) {
                            if (kDebugMode) {
                              print(index);
                            }
                            if (index == usersList.length - 3) {
                              uservm.getUsers(
                                  offset: 15 * (uservm.pageNumber + 1));
                            }
                            if (index == usersList.length) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return UserResumeView(user: usersList[index]);
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserForm(
                isCreatePage: true,
              ),
            ),
          );
        },
        tooltip: 'Add user',
        child: const Icon(Icons.person_add_alt_1_rounded),
      ),
    );
  }

  Widget _seatchBarSection(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: const SearchBarComponent(
        hintText: "Le nom de l'utilisateur",
      ),
    );
  }
}
