// Create some mock data of a list of todos, as well as mock data of task list for each todo item.
// Create your own mock data.

import 'dart:async';

import 'package:schoolah_mobile_app/models/task.dart';
import 'package:schoolah_mobile_app/models/todo.dart';
import 'package:schoolah_mobile_app/services/todo_data_service.dart';

List<Todo> mockData = [
  Todo(title: 'Mathematic', items: [
    Task(id: 1, title: "Quiz 1: Addition & Substraction", completed: true),
    Task(id: 2, title: "Exercise multiplication", completed: false),
    Task(id: 3, title: "Homework: Let's learn about money", completed: true),
    Task(id: 4, title: "Test 1: Calculation of money", completed: false),
    Task(id: 5, title: "Quiz 2: Fraction", completed: false),
  ]),
  Todo(title: 'Science', items: [
    Task(id: 6, title: "Exercise 1: Human Body", completed: true),
    Task(id: 7, title: "Basic needs of human and plants", completed: false),
    Task(id: 8, title: "Homework: Food Chain", completed: true),
  ]),
  Todo(title: 'Bahasa Malaysia', items: [
    Task(id: 9, title: "Mari Membaca", completed: true),
    Task(id: 10, title: "Karangan: Aku Sebatang Pensel", completed: false),
    Task(id: 11, title: "Pemahaman tatabahasa", completed: true),
    Task(id: 12, title: "Karangan: Keluarga saya", completed: false),
  ]),
];

//int _nextId = 3;

class TodoDataServiceMock implements TodoDataService {
  Future<List<Todo>> getTodoList() async {
    return [...mockData];
  }
}
