import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/alert_dialog_yes_no.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/screen_background_widget.dart';
import '../widgets/status_change_bottom_sheet.dart';
import '../widgets/task_list_item_widget.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {
  TaskModel cancelledTaskModel = TaskModel();
  bool inProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllCancelledTasks();
  }

  Future<void> getAllCancelledTasks() async {
    setState(() {
      inProgress = true;
    });

    final response = await NetworkUtils().getMethod(Urls.cancelledTaskUrl);
    setState(() {
      inProgress = false;
    });

    if (response != null) {
      cancelledTaskModel = TaskModel.fromJson(response);
    } else {
      if(mounted) {
        showSnackBarMessage(context, 'Unable to fetch new tasks! try again', true);
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
      await getAllCancelledTasks();
      if(mounted) {
        showSnackBarMessage(context, 'Task has been deleted');
      }
    } else {
      if(mounted){
        showSnackBarMessage(context, 'Delete failed! Try again',true);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: inProgress ? const Center(
          child: CircularProgressIndicator(),
        ) : RefreshIndicator(
          onRefresh: () async{
            await getAllCancelledTasks();
          },
          child: ListView.builder(
              itemCount: cancelledTaskModel.data?.length ?? 0,
              reverse: false,
              itemBuilder: (context, index){
                return TaskListItemWidget(
                  chipBackgroundColor: Colors.red,
                  type: 'Cancelled',
                  subject: cancelledTaskModel.data?[index].title ?? 'Unknown',
                  description: cancelledTaskModel.data?[index].description ?? 'Unknown',
                  date: cancelledTaskModel.data?[index].createdDate ?? 'Unknown',
                  onEditPress: () {
                    showChangeTaskStatusModal('Cancelled',
                          cancelledTaskModel.data?[index].sId ?? '',
                          () async {
                        await getAllCancelledTasks();
                      });
                    },
                  onDeletePress: () {
                    alertDialogYesNo(context, () async{
                       await deleteTask(cancelledTaskModel.data?[index].sId ?? '');
                    });
                  },
                );
              }),
        )
    );
  }
}
