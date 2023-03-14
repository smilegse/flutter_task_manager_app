import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/auth_utils.dart';
import 'package:task_manager_app/data/network_utils.dart';
import 'package:task_manager_app/data/urls.dart';
import 'package:task_manager_app/ui/utils/snack_bar_message.dart';
import '../../data/models/task_model.dart';
import '../../data/models/task_status_count_model.dart';
import '../utils/alert_dialog_yes_no.dart';
import '../widgets/dashboard_badge_item_widget.dart';
import '../widgets/screen_background_widget.dart';
import '../widgets/status_change_bottom_sheet.dart';
import '../widgets/task_list_item_widget.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  TaskModel newTaskModel = TaskModel();
  TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel();

  bool inProgress = false;
  bool inProgressStatus = false;

  int newTaskCount = 0;
  int cancelledTaskCount = 0;
  int completedTaskCount = 0;
  int progressTaskCount = 0;

  @override
  void initState() {
    super.initState();

    getTaskStatusCount();
    getAllNewTasks();

  }

  Future<void> getAllNewTasks() async {
    setState(() {
      inProgress = true;
    });

    final response = await NetworkUtils().getMethod(
      Urls.newTaskUrl,
      onUnAuthorize: () {
        log('Api calling Unauthorized!');
        showSnackBarMessage(context,'Unauthorized!', true);
    });

    setState(() {
      inProgress = false;
    });

    //log(response.toString());

    if (response != null && response['status'] == 'success') {
      log('getAllNewTasks success');
      newTaskModel = TaskModel.fromJson(response);
    } else {
      if(mounted){
        log('getAllNewTasks() Unable to fetch new tasks! try again');
        showSnackBarMessage(context, 'Unable to fetch new tasks! try again',true);
      }
    }
  }

  Future<void> deleteTask(String taskId) async {
    setState(() {
      inProgress = true;
    });

    final response = await NetworkUtils().getMethod(Urls.deleteTaskUrl(taskId));

    setState(() {
      inProgress = false;
    });

    if (response != null && response['status'] == 'success') {
      await getAllNewTasks();
      await getTaskStatusCount();
      if(mounted) {
        showSnackBarMessage(context, 'Task has been deleted');
      }
    } else {
      if(mounted){
        showSnackBarMessage(context, 'Delete failed! Try again',true);
      }
    }
  }

  Future<void> getTaskStatusCount() async{
    setState(() {
       inProgressStatus = true;
    });
    final response = await NetworkUtils().getMethod(Urls.taskStatusCountUrl);

     setState(() {
       inProgressStatus = false;
     });

    //log(response.toString());
    //log('Token: ${AuthUtils.token}');

    if (response != null && response['status'] == 'success') {
      log('getTaskStatusCount success');
      taskStatusCountModel = TaskStatusCountModel.fromJson(response);

      for (var taskStatusCount in taskStatusCountModel.data!) {
        if(taskStatusCount.sId == 'New'){
          newTaskCount = taskStatusCount.sum ?? 0;        // New
        }else if(taskStatusCount.sId == 'Completed'){
          completedTaskCount = taskStatusCount.sum ?? 0;  // Cancelled
        }else if (taskStatusCount.sId == 'Progress') {
          progressTaskCount = taskStatusCount.sum ?? 0;   // Completed
        }else {
          cancelledTaskCount = taskStatusCount.sum ?? 0;    // Progress
        }
      }
    } else {
      if(mounted){
        log('getTaskStatusCount() Unable to fetch task status count data! try again');
        showSnackBarMessage(context, 'Unable to fetch task status count data! try again',true);
      }
    }

  }



  @override
  Widget build(BuildContext context) {
    return ScreenBackground(child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DashboardBadgeItemWidget(
                typeOfTask: 'New',
                numberOfTasks: newTaskCount
              ),
            ),
            Expanded(
              child: DashboardBadgeItemWidget(
                typeOfTask: 'Completed',
                numberOfTasks: completedTaskCount
              ),
            ),

            Expanded(
              child: DashboardBadgeItemWidget(
                typeOfTask: 'Progress',
                numberOfTasks: progressTaskCount
              ),
            ),
            Expanded(
              child: DashboardBadgeItemWidget(
                  typeOfTask: 'Cancelled',
                  numberOfTasks: cancelledTaskCount
              ),
            ),
          ],
        ),
        Expanded(
          child: inProgress
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await getAllNewTasks();
                    await getTaskStatusCount();
                  },
                  child: ListView.builder(
                      itemCount: newTaskModel.data?.length ?? 0,
                      reverse: false,
                      itemBuilder: (context, index) {
                        return TaskListItemWidget(
                          chipBackgroundColor: Colors.blueAccent,
                          type: 'New',
                          subject: newTaskModel.data?[index].title ?? 'Unknown',
                          description: newTaskModel.data?[index].description ??
                              'Unknown',
                          date: newTaskModel.data?[index].createdDate ??
                              'Unknown',
                          onEditPress: () {
                            showChangeTaskStatusModal(
                              'New', newTaskModel.data?[index].sId ?? '', (){
                              getAllNewTasks();
                            });
                          },
                          onDeletePress: () async {
                            alertDialogYesNo(context, () async {
                              await deleteTask(newTaskModel.data?[index].sId ?? '');
                            });
                          },
                        );
                      }),
                ),
        )
      ],
    ));
  }



}
