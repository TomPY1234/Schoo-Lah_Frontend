// Define the class Todo here. The attributes are given. Complete the rest.

import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/models/task.dart';

class Todo {
  String title;
  List<Task> items;

  Todo({this.title, this.items});
  Todo.copy(Todo from) : this(title: from.title, items: [...from.items]);

  double get percent {
    int sum = 0;
    for (int i = 0; i < items.length; i++) {
      items[i].completed ? sum++ : DoNothingAction();
    }
    return (sum / items.length) * 100;
  }

  //double get percent => (items.reduce((sum, item) => sum + item) / 20.0) * 100;
}
