import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_list/colors/colors.dart';
import 'package:to_do_list/widgets/to_do.dart';
import '../models/toDo.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoslist = ToDo.todolist();
  final todoController = TextEditingController();
  List <ToDo> foundtodo = [];


  @override
  void initState() {
    foundtodo = todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgc,
      appBar: appbar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(children: [
              search(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: Text(
                        'Taches à faire',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                    ),
                    for(ToDo todoo in foundtodo.reversed)
                    ToDoItems(todo: todoo, ontodochanged: handletodochange, ondeleteitem: deleteitem,),
                  ],
                ),
              )
            ],)
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(child: Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0
                    )
                  ],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: todoController,
                  decoration: InputDecoration(
                    hintText: 'Ajouter nouvelle tache',
                    border: InputBorder.none,
                  ),
                ),
              )),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(child: Text('+', style: TextStyle(
                  fontSize: 40,
                ),),
                onPressed: () {
                  addtodoitem(todoController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  // minimumSize: Size(60, 60),
                  elevation: 10
                ),
                ),
              )
            ],),
          )
        ],
      ),
    );
  }

  void handletodochange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteitem(id){
    setState(() {
      todoslist.removeWhere((item) => item.id == id);
    });
  }

  void addtodoitem(String todo){
    setState(() {
    todoslist.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo));
    });
    todoController.clear();
  }

  void filter(String s){
    List<ToDo> result = [];
    if (s.isEmpty) {
      result = todoslist;
    }else result = todoslist.where((item) => item.todoText!.toLowerCase().contains(s.toLowerCase())).toList();

    setState(() {
      foundtodo = result;
    });
  }

//searchbar pour recherche des taches
  Widget search() {
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: TextField(
              onChanged: (value) => filter(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: black,
                  size: 20,
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 25,
                  minHeight: 20,
                ),
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(color: grey)
              ),
            ),
          );
  }

//navbar de l'application
  AppBar appbar() {
    return AppBar(
      backgroundColor: bgc,
      title: Row(children: [
        Icon(Icons.menu,
        color: black,
        size: 30,
        )
      ],),
    );
  }
}