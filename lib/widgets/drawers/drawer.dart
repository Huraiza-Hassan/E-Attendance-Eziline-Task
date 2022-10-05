import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer(
      {Key? key,
      required this.userName,
      required this.userEmail,
      required this.userDeignation,
      required this.onTap})
      : super(key: key);

  final String userName;
  final String userEmail;
  final String userDeignation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: CustomColor.primaryColor),
              currentAccountPicture: const CircleAvatar(
                backgroundImage:
                    AssetImage("assets/images/user_images/user_profile.png"),
              ),
              accountName: Text(userName),
              accountEmail: Text(userEmail)),
          //drawer body
          userTile(userName, CustomStrings.userNameSubtitle, Icons.person),
          userTile(userDeignation, CustomStrings.userDesigSubtitle, Icons.work),
          userTile(userEmail, CustomStrings.userEmailSubtitle, Icons.email),
          //logout button
          userLogoutTile(onTap: onTap)
        ],
      ),
    );
  }
}

//drawer body tile
Widget userTile(String userName, String userSubtitle, IconData iconName) {
  return ListTile(
    title: Text(userSubtitle),
    subtitle: Text(userName),
    leading: Icon(
      iconName,
      color: CustomColor.primaryColor,
    ),
  );
}

//drawer logout tile
Widget userLogoutTile({required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: const ListTile(
      title: Text(CustomStrings.logoutTileText),
      subtitle: Text(CustomStrings.logoutSubtitle),
      leading: Icon(
        Icons.exit_to_app,
        color: CustomColor.primaryColor,
      ),
    ),
  );
}
