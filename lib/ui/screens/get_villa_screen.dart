import 'dart:developer';

import 'package:flutter/material.dart';
import '../../data/models/villa_model.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/screen_background_widget.dart';
import '../widgets/task_list_item_widget.dart';

class GetVillaScreen extends StatefulWidget {
  const GetVillaScreen({Key? key}) : super(key: key);

  @override
  State<GetVillaScreen> createState() => _GetVillaScreenState();
}

class _GetVillaScreenState extends State<GetVillaScreen> {
  VillaModel villaModel = VillaModel();
  bool inProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllVilla();
  }

  Future<void> getAllVilla() async {
    setState(() {
      inProgress = true;
    });

    final response = await NetworkUtils().getMethod(Urls.getAllVillas);
    log(response.toString());
    setState(() {
      inProgress = false;
    });

    if (response != null) {
      log(response.toString());
      villaModel = VillaModel.fromJson(response);
    } else {
      if(mounted) {
        showSnackBarMessage(context, 'Unable to fetch new tasks! try again', true);
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
            await getAllVilla();
          },
          child: ListView.builder(
              itemCount: villaModel.result?.length ?? 0,
              reverse: false,
              itemBuilder: (context, index){
                return TaskListItemWidget(
                  chipBackgroundColor: Colors.red,
                  type: 'Cancelled',
                  subject: villaModel.result?[index].name ?? 'Unknown',
                  description: villaModel.result?[index].details ?? 'Unknown',
                  date: villaModel.result?[index].createdDate ?? 'Unknown',
                  onEditPress: () {
                  },
                  onDeletePress: () {
                  },
                );
              }),
        )
    );
  }
}