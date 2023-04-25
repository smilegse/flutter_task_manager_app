import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/getx_controllers/auth_controller.dart';
import 'package:task_manager_app/ui/getx_controllers/task_controller.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> globalNavigatorKey =
      GlobalKey<NavigatorState>();



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskManagerApp.globalNavigatorKey,
      initialBinding: StoreBindings(),
      home: const SplashScreen(),
    );
  }
}

class StoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(TaskController());
  }

}