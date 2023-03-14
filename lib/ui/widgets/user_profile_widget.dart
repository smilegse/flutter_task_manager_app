import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';
import '../../data/auth_utils.dart';
import '../screens/login_screen.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      leading: const CircleAvatar(child: Icon(Icons.person)),
      trailing: IconButton(
          onPressed: () async {
            await AuthUtils.clearData();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
          },
          icon: const Icon(Icons.logout, color: Colors.white)),
      tileColor: Colors.green,
      title: Text(
        '${AuthUtils.firstName ?? 'Unknown'} ${AuthUtils.lastName ?? 'Unknown'}',
        style:
            const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        AuthUtils.email ?? 'Unknown',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
