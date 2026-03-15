import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class todotile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;

  Function(BuildContext)? deleteFunction;


  todotile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(17.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Color(0xFFFE4A49),
              borderRadius: BorderRadius.circular(10),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff88BDF2),
              borderRadius: BorderRadius.circular(10)
          ),
          height: 100,
          child: Center(
              child: Row(
                  children: [
                    Checkbox(value: taskCompleted, onChanged: onChanged),
                    Text(taskName,style: TextStyle(fontSize: 17),)
                  ]
              )
          ),
        ),
      ),
    );
  }
}
