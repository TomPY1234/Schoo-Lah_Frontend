// Create some mock data of a list of todos, as well as mock data of task list for each todo item.
// Create your own mock data.

import 'dart:async';

import 'package:schoolah_mobile_app/models/task.dart';
import 'package:schoolah_mobile_app/models/todo.dart';

List<Todo> mockData = [
  Todo(title: 'Mathematic', items: [
    Task(title: "Quiz 1: Addition & Substraction", completed: true),
    Task(title: "Exercise multiplication", completed: false),
    Task(title: "Homework: Let's learn about money", completed: true),
    Task(title: "Test 1: Calculation of money", completed: false),
    Task(title: "Quiz 2: Fraction", completed: false),
  ]),
  Todo(title: 'Science', items: [
    Task(title: "Exercise 1: Human Body", completed: true),
    Task(title: "Basic needs of human and plants", completed: false),
    Task(title: "Homework: Food Chain", completed: true),
  ]),
  Todo(title: 'Bahasa Malaysia', items: [
    Task(title: "Mari Membaca", completed: true),
    Task(title: "Karangan: Aku Sebatang Pensel", completed: false),
    Task(title: "Pemahaman tatabahasa", completed: true),
    Task(title: "Karangan: Keluarga saya", completed: false),
  ]),
];
