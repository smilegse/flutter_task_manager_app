import 'package:flutter/material.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      leading: CircleAvatar(child: Icon(Icons.person)),
      trailing: Icon(Icons.logout, color: Colors.white),
      tileColor: Colors.green,
      title: Text('Md. Abu Bakar Siddique'),
      subtitle: Text('siddique@gmail.com'),
    );
  }
}