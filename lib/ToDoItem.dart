import 'package:flutter/material.dart';
import 'package:to_do_list_app/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final todo ToDo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem(
      {super.key,
      required this.ToDo,
      required this.onToDoChanged,
      required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(ToDo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: ToDo.isDone
            ? const Icon(
                Icons.check_box,
                color: Colors.blue,
              )
            : const Icon(
                Icons.check_box_outline_blank,
                color: Colors.blue,
              ),
        title: Text(
          ToDo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: ToDo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: IconButton(
          onPressed: () {
            onDeleteItem(ToDo.id);
          },
          icon: const Icon(Icons.delete),
          color: Colors.red,
        ),
      ),
    );
  }
}
