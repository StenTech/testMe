import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:testme/common/theme/app_color.dart';
import 'package:testme/repository/api/user.repository.dart';
import 'package:testme/repository/db/db.helper.dart';
import 'package:testme/viewmodel/user.dart';

import 'general_icon_button.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeneralAppBar({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    getUsers() async {
      await Provider.of<UserViewModel>(context, listen: false).getUsers();
    }

    return AppBar(
      elevation: 0,
      // hide time en battery bar
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),

      // transparent: true,
      shadowColor: Colors.transparent,
      backgroundColor: AppColor.primaryBackgroundColor,
      title: Text(
        title ?? 'Gueze',
        style: const TextStyle(
          color: AppColor.secondaryColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        GeneralIconButton(
          onPressed: () async {
            final dbHelper = GetIt.I.get<DatabaseHelper>();
            final userRepository = GetIt.I.get<UserRepository>();
            final usersData = await userRepository.getUsers();
            await dbHelper.insertUsers(usersData);
            await getUsers();
          },
          icon: Icons.refresh_outlined,
        ),
        const SizedBox(width: 10),
      ],
      //centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
