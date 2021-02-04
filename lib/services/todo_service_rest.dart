import 'package:schoolah_mobile_app/models/task.dart';
import 'package:schoolah_mobile_app/models/todo.dart';
import 'package:schoolah_mobile_app/services/todo_service.dart';

import '../dependencies.dart';
import './rest_service.dart';

class TodoServiceRest implements TodoService {
  //------- Here is how we implement 'Singleton pattern' in Dart --------

  static final TodoServiceRest _instance = TodoServiceRest._constructor();
  factory TodoServiceRest() {
    return _instance;
  }

  TodoServiceRest._constructor();
  final rest = service<RestService>();

  Future<List<Todo>> getAllTodos() async {
    final listJson = await rest.get('todos');

    return (listJson as List)
        .map((itemJson) => Todo.fromJson(itemJson))
        .toList();
  }

  Todo currTodo;
  int _nextId = 12;

  Future createTodo({Todo todo, String task}) async {
    Task newTask = Task(id: _nextId++, title: task, completed: false);
    todo.items.add(newTask);
  }

  Future updateCurrentTodo({Todo todo, String id}) async {
    currTodo = todo;

    final json = await rest.patch('todos/$id', data: todo);
    return Todo.fromJson(json);
  }

  Future<Todo> getCurrentTodo() async {
    return currTodo;
  }

  Future setCurrentTodo({Todo currtodo}) async {
    currTodo = currtodo;
  }
}
