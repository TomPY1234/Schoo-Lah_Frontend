import '../models/todo.dart';

abstract class TodoService {
  Future<List<Todo>> getAllTodos();
  //Future<Todo> updateStatus({String id, bool status});
  Future createTodo({Todo todo, String task});
  //Future<Todo> getTodos(String id);

  //Future<Todo> updateStatus({String id, items, completed});

  Future updateCurrentTodo({Todo todo, String id});
  Future<Todo> getCurrentTodo();
  Future setCurrentTodo({Todo currtodo});

  //Future deleteTodo({int id});
}
