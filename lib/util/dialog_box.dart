import 'package:flutter/material.dart';
import 'package:todoapp/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: alertDialogBackColor,
      content: Container(
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: borderRadiusCircular(),
                hintText: textFieldText,
              ),
            ),
            //buttons save + cancel
            Padding(
              padding: paddingTop(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //save button
                  MyButton(
                    text: 'Save',
                    onPressed: onSave,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  //cancel button
                  MyButton(text: 'Cancel', onPressed: onCancel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color get alertDialogBackColor => Colors.white;

  String get textFieldText => 'Add a new task';

  EdgeInsets paddingTop() => EdgeInsets.only(top: 20);

  OutlineInputBorder borderRadiusCircular() => OutlineInputBorder(borderRadius: BorderRadius.circular(5));
}
