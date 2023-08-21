import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingOnly(),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            slidableDelete(),
          ],
        ),
        child: Container(
          padding: paddingAll(),
          child: Row(
            children: [
              //checkbox
              checkbox(),
              //Task name
              checkboxText(),
            ],
          ),
          decoration: BoxDecoration(color: checkboxColor, borderRadius: borderCircular()),
        ),
      ),
    );
  }

  Color get checkboxColor => Colors.white;

  EdgeInsets paddingOnly() => EdgeInsets.only(left: 25, right: 25, top: 25);

  SlidableAction slidableDelete() {
    return SlidableAction(
      onPressed: deleteFunction,
      icon: Icons.delete,
      backgroundColor: Colors.black,
      borderRadius: radiusCircular(),
    );
  }

  BorderRadius borderCircular() => BorderRadius.circular(13);

  Text checkboxText() {
    return Text(
      taskName,
      style: TextStyle(decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none),
    );
  }

  Checkbox checkbox() {
    return Checkbox(
      value: taskCompleted,
      onChanged: onChanged,
      activeColor: Colors.black,
    );
  }

  EdgeInsets paddingAll() => EdgeInsets.all(25);

  BorderRadius radiusCircular() => BorderRadius.circular(12);
}
