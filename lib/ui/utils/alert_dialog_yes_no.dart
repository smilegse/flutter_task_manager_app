import 'package:flutter/material.dart';

alertDialogYesNo(BuildContext context, VoidCallback onCallbackYes) {
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return  Expanded(
            child: AlertDialog(
              title: const Text('Delete Confirmation!'),
              content: const Text('Are you sure! Do you want to delete'),
              actions: [
                TextButton(onPressed: () {
                    onCallbackYes();
                    Navigator.of(context).pop();
                }, child: const Text('Yes')),
                TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: const Text('No'),),
              ],
            )
        );
      }
  );
}