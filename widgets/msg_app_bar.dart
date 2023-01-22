import 'package:dev_mobile_tp/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:messio/config/Assets.dart';
// import 'package:messio/config/Palette.dart';

class MessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 100;
  final int userId;
  final String avatarUrl;
  final String username;
  final String phone;
  const MessageAppBar(
      {Key? key,
      required this.avatarUrl,
      required this.username,
      required this.phone,
      required this.userId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      titleSpacing: 0,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Avatar(
              url: avatarUrl,
              userId: userId,
            ),
          ),
          Text(username),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () async {
              await FlutterPhoneDirectCaller.callNumber(phone);
            },
            icon: const Icon(
              Icons.phone_enabled,
              size: 30,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
