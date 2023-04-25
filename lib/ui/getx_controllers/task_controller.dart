import 'package:get/get.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';

class TaskController extends GetxController{
  bool getNewTaskInProgress = false;
  TaskModel newTaskModel = TaskModel();

  Future<bool> getAllNewTasks() async {
  getNewTaskInProgress = true;
  update();
  final response = await NetworkUtils().getMethod(Urls.newTaskUrl);
  getNewTaskInProgress = false;
  if (response != null && response['status'] == 'success') {
    newTaskModel = TaskModel.fromJson(response);
    update();
    return true;
  } else {
    update();
    return false;
    }
  }

}