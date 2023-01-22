import 'package:dev_mobile_tp/views/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String url;
  final int userId;
  Avatar({Key? key, required this.url, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(url),
        backgroundColor: Colors.transparent,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(
                    profileId: userId,
                  )),
        );
      },
    );
  }
}
