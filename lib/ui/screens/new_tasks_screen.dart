import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_utils.dart';
import 'package:task_manager_app/data/urls.dart';
import 'package:task_manager_app/ui/utils/snack_bar_message.dart';
import '../../data/models/task_model.dart';
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
  bool inProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllNewTasks();
  }

  Future<void> getAllNewTasks() async {
    setState(() {
      inProgress = true;
    });

    final response = await NetworkUtils().getMethod(Urls.newTaskUrl);
    setState(() {
      inProgress = false;
    });

    if (response != null) {
      newTaskModel = TaskModel.fromJson(response);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBarMessage(context, 'Unable to fetch new tasks! try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: DashboardBadgeItemWidget(
                typeOfTask: 'New',
                numberOfTasks: 23,
              ),
            ),
            Expanded(
              child: DashboardBadgeItemWidget(
                typeOfTask: 'Completed',
                numberOfTasks: 30,
              ),
            ),
            Expanded(
              child: DashboardBadgeItemWidget(
                typeOfTask: 'Cancelled',
                numberOfTasks: 11,
              ),
            ),
            Expanded(
              child: DashboardBadgeItemWidget(
                typeOfTask: 'In Progress',
                numberOfTasks: 05,
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
                          onDeletePress: () {},
                        );
                      }),
                ),
        )
      ],
    ));
  }



}
