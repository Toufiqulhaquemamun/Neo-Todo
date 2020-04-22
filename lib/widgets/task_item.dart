import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todo.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        child: ListTile(
          leading: Checkbox(
            value: task.completed,
            onChanged: (bool checked) {
              Provider.of<TodoModel>(context, listen: false).toggleTodo(task);
            },
          ),
          title: Text(task.title),
        ),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 10.0),
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        background: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10.0),
          color: Colors.green,
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            /// edit
            return false;
          } else {
            /// delete
            return true;
          }
        },
        onDismissed: (direction){
          if (direction == DismissDirection.endToStart) {
              Provider.of<TodoModel>(context, listen: false).deleteTodo(task);
          }        
        },
        );
  }
}
