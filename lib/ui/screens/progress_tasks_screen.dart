import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/dashboard_badge_item_widget.dart';
import '../widgets/screen_background_widget.dart';
import '../widgets/status_change_bottom_sheet.dart';
import '../widgets/task_list_item_widget.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({Key? key}) : super(key: key);

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  TaskModel progressTaskModel = TaskModel();
  bool inProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllProgressTasks();
  }

  Future<void> getAllProgressTasks() async {
    setState(() {
      inProgress = true;
    });

    final response = await NetworkUtils().getMethod(Urls.progressTaskUrl);
    setState(() {
      inProgress = false;
    });

    if (response != null) {
      progressTaskModel = TaskModel.fromJson(response);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBarMessage(context, 'Unable to fetch new tasks! try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: inProgress ? const Center(
          child: CircularProgressIndicator(),
        ) : RefreshIndicator(
          onRefresh: () async{
            await getAllProgressTasks();
          },
          child: ListView.builder(
              itemCount: progressTaskModel.data?.length ?? 0,
              reverse: false,
              itemBuilder: (context, index){
                return TaskListItemWidget(
                  chipBackgroundColor: Colors.deepPurple,
                  type: 'Progress',
                  subject: progressTaskModel.data?[index].title ?? 'Unknown',
                  description: progressTaskModel.data?[index].description ?? 'Unknown',
                  date: progressTaskModel.data?[index].createdDate ?? 'Unknown',
                  onEditPress: (){
                    showChangeTaskStatusModal(
                        'Progress', progressTaskModel.data?[index].sId ?? '', (){
                      getAllProgressTasks();
                    });
                  },
                  onDeletePress: (){},
                );
              }),
        )
    );
  }
}
