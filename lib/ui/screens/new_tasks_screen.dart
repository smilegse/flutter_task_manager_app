import 'package:flutter/material.dart';
import '../widgets/dashboard_badge_item_widget.dart';
import '../widgets/screen_background_widget.dart';
import '../widgets/task_list_item_widget.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
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
            child: ListView.builder(
              itemCount: 10,
                itemBuilder: (context, index){
              return TaskListItemWidget(
                chipBackgroundColor: Colors.blueAccent,
                type: 'New',
                subject: 'Lorem Ipsum',
                description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                date: '01-03-2023',
                onEditPress: (){},
                onDeletePress: (){},
              );
          }),
          )
        ],
      )
    );
  }
}
