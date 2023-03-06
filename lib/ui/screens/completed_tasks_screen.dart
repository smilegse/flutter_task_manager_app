import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/status_change_bottom_sheet.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/dashboard_badge_item_widget.dart';
import '../widgets/screen_background_widget.dart';
import '../widgets/task_list_item_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {

  TaskModel  completedTaskModel = TaskModel();

  bool inProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllCompletedTasks();
  }

  Future<void> getAllCompletedTasks() async {
    setState(() {
      inProgress = true;
    });

    final response = await NetworkUtils().getMethod(Urls.completedTaskUrl);
    setState(() {
      inProgress = false;
    });

    if(response != null){
      completedTaskModel = TaskModel.fromJson(response);
    }else {
      // ignore: use_build_context_synchronously
      showSnackBarMessage(context, 'Unable to fetch completed tasks! try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: inProgress ? const Center(
          child: CircularProgressIndicator(),
        ) : RefreshIndicator(
          onRefresh: () async{
            await getAllCompletedTasks();
          },
          child: ListView.builder(
              itemCount: completedTaskModel.data?.length ?? 0,
              reverse: false,
              itemBuilder: (context, index){
                return TaskListItemWidget(
                  chipBackgroundColor: Colors.green,
                  type: 'Completed',
                  subject: completedTaskModel.data?[index].title ?? 'Unknown',
                  description: completedTaskModel.data?[index].description ?? 'Unknown',
                  date: completedTaskModel.data?[index].createdDate ?? 'Unknown',
                  onEditPress: (){
                    showChangeTaskStatusModal(
                    'Completed', completedTaskModel.data?[index].sId ?? '', (){
                      getAllCompletedTasks();
                    });
                  },
                  onDeletePress: (){},
                );
              }),
        )
    );
  }
}
