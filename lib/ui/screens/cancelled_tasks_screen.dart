import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/dashboard_badge_item_widget.dart';
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
                  onEditPress: (){
                    showChangeTaskStatusModal(
                        'Cancelled', cancelledTaskModel.data?[index].sId ?? '', (){
                      getAllCancelledTasks();
                    });
                  },
                  onDeletePress: (){},
                );
              }),
        )
    );
  }
}
