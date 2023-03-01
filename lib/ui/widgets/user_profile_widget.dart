import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      leading: const CircleAvatar(child: Icon(Icons.person)),
      trailing: IconButton(onPressed: (){

      }, icon: const Icon(Icons.logout, color: Colors.white)) ,
      tileColor: Colors.green,
      title: const Text('Md. Abu Bakar Siddique',style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600
      ),),
      subtitle: const Text('siddique@gmail.com',style: TextStyle(
          color: Colors.white,
      ),),
    );
  }
}