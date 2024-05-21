import 'package:flutter/material.dart';
import 'package:to_do_list/colors/colors.dart';
import 'package:to_do_list/models/toDo.dart';

class ToDoItems extends StatelessWidget {
  final ToDo todo;
  final ontodochanged;
  final ondeleteitem;

  const ToDoItems({super.key, required this.todo, required this.ontodochanged, required this.ondeleteitem});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTap: () {
          ontodochanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(todo.isDone? Icons.check_box: Icons.check_box_outline_blank, color: blue,),
        title: Text(todo.todoText!,
        style: TextStyle(fontSize: 16,color: black, decoration: todo.isDone? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: red,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            onPressed: () {
              ondeleteitem(todo.id);
            },
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
          ),
        ),
      )
    );
  }
}