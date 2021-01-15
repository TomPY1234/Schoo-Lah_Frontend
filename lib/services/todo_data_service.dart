import '../models/todo.dart';

abstract class TodoDataService {
  Future<List<Todo>> getTodoList();
  //Future<Todo> updateTodoStatus({int id, bool status});
  Future createTodo({Todo todo, String task});
  Future updateCurrentTodo({Todo todo});
  Future<Todo> getTodo();
  //Future deleteTodo({int id});
}
