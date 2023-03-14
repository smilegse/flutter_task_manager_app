import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/cancelled_tasks_screen.dart';
import 'package:task_manager_app/ui/screens/completed_tasks_screen.dart';
import 'package:task_manager_app/ui/screens/new_tasks_screen.dart';
import 'package:task_manager_app/ui/screens/progress_tasks_screen.dart';
import '../widgets/user_profile_widget.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';

class MainBottomNavbar extends StatefulWidget {
  const MainBottomNavbar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavbar> createState() => _MainBottomNavbarState();
}

class _MainBottomNavbarState extends State<MainBottomNavbar> {

  int _selectedScreen=0;
  final List<Widget> _screens = const [
    NewTasksScreen(),
    CompletedTasksScreen(),
    ProgressTasksScreen(),
    CancelledTasksScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserProfileWidget(),
            Expanded(child: _screens[_selectedScreen]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black38,
        backgroundColor: Colors.green,
        showUnselectedLabels: true,
        onTap: (index){
          _selectedScreen = index;
          setState(() {

          });
        },
        elevation: 5,
        currentIndex: _selectedScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.new_label_outlined), label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.done_outline),label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit_sharp),label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.close_outlined),label: 'Cancelled')
        ],
      ),
    );
  }
}

