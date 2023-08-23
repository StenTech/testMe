import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:testme/common/theme/app_color.dart';
import 'package:testme/model/models.dart';
import 'package:testme/repository/db/db.helper.dart';
import 'package:testme/view/components/general_icon_button.dart';
import 'package:testme/view/user/user_form.view.dart';
import 'package:testme/viewmodel/user.dart';

class UserResumeView extends StatelessWidget {
  final User user;

  const UserResumeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        if (kDebugMode) {
          print(5);
        }
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.picture?.thumbnail ?? ''),
      ),
      title: Text('${user.title} ${user.firstName} ${user.lastName}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text('${user.email}'),
          const SizedBox(height: 5),
          Text(
            '${user.phone}, ${user.location?.country?.toUpperCase()}',
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(
          Icons.more_vert,
          color: AppColor.secondaryColor,
        ),
        onSelected: (String result) {
          if (kDebugMode) {
            print(result);
          }
          if (result == 'edit') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserForm(
                  isCreatePage: false,
                  user: user,
                ),
              ),
            );
          } else if (result == 'delete') {
            Provider.of<UserViewModel>(context, listen: false).deleteUser(user);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'edit',
            child: Text('Editer'),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text("Supprimer"),
          ),
          // PopupMenuItem<String>(
          //   value: 'option3',
          //   child: Text('Option 3'),
          // ),
        ],
      ),
      // IconButton(
      //   highlightColor: Colors.transparent,
      //   splashRadius: 20,
      //   onPressed: () {
      //     if (kDebugMode) {
      //       print(45);
      //     }
      //     _showMenu(context);
      //   },
      //   icon: const Icon(
      //     Icons.more_vert,
      //     color: AppColor.secondaryColor,
      //   ),
      // ),
    );
  }

  // void _showMenu(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         height: 120,
  //         color: Colors.transparent,
  //         child: Column(
  //           children: [
  //             ListTile(
  //               leading: const Icon(Icons.edit),
  //               title: const Text('Edit'),
  //               onTap: () async {
  //                 Navigator.pop(context);

  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => UserForm(
  //                       isCreatePage: false,
  //                       user: user,
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.delete),
  //               title: const Text('Delete'),
  //               onTap: () {
  //                 // get dg helper
  //                 Provider.of<UserViewModel>(context, listen: false)
  //                     .deleteUser(user);
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
