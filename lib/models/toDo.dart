class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todolist(){
    return[
      ToDo(id: '1', todoText: 'reviser flutter'),
      ToDo(id: '2', todoText: 'manger', isDone: true),
      ToDo(id: '3', todoText: 'boire'),
      ToDo(id: '4', todoText: 'dormir'),
    ];
  }
}