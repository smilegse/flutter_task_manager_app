import 'package:flutter/material.dart';

import '../widgets/screen_background_widget.dart';
import '../widgets/task_list_item_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        widget: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index){
                    return TaskListItemWidget(
                      chipBackgroundColor: Colors.green,
                      type: 'Compeleted',
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
