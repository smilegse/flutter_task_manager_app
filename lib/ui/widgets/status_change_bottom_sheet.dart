import 'package:flutter/material.dart';
import 'package:task_manager_app/main.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snack_bar_message.dart';
import 'app_elevated_button.dart';

showChangeTaskStatusModal(String currentStatus, String taskId, VoidCallback onTaskChangeCompleted) {
  String statusValue = currentStatus;

  showModalBottomSheet(
      context: TaskManagerApp.globalNavigatorKey.currentContext!,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, changeState) {
            return Column(
                children: [
                  RadioListTile(
                      value: 'New',
                      title: const Text(
                        'New',
                      ),
                      groupValue: statusValue,
                      onChanged: (state) {
                        statusValue = state!;
                        changeState(() {});
                      }),
                  RadioListTile(
                      value: 'Completed',
                      title: const Text(
                        'Completed',
                      ),
                      groupValue: statusValue,
                      onChanged: (state) {
                        statusValue = state!;
                        changeState(() {});
                      }),
                  RadioListTile(
                      value: 'Progress',
                      title: const Text(
                        'Progress',
                      ),
                      groupValue: statusValue,
                      onChanged: (state) {
                        statusValue = state!;
                        changeState(() {});
                      }),
                  RadioListTile(
                      value: 'Cancelled',
                      title: const Text(
                        'Cancelled',
                      ),
                      groupValue: statusValue,
                      onChanged: (state) {
                        statusValue = state!;
                        changeState(() {});
                      }),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: AppElevatedButton(
                          child: const Text('Change Status'), onTap: () async {
                        final response = await NetworkUtils().getMethod(Urls.changeTaskStatusUrl(taskId, statusValue));
                        if(response != null){
                          onTaskChangeCompleted();
                          Navigator.pop(context);
                        }else {
                            showSnackBarMessage(context, 'Status change failed! Try again', true);
                        }
                      })
                  ),
                ]
            );
          },
        );
      });
}