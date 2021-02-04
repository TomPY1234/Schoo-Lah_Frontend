// Define the class Todo here. The attributes are given. Complete the rest.

import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/models/task.dart';

class Todo {
  String id;
  String title;
  List<Task> items;

  Todo({this.id, this.title, this.items});
  Todo.copy(Todo from)
      : this(id: from.id, title: from.title, items: [...from.items]);

  double get percent {
    int sum = 0;
    for (int i = 0; i < items.length; i++) {
      items[i].completed ? sum++ : DoNothingAction();
    }
    return (sum / items.length) * 100;
  }

  Todo.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            items: (json['items'] as List)
                .map((itemJson) => Task.fromJson(itemJson))
                .toList());

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'items': items};

  //double get percent => (items.reduce((sum, item) => sum + item) / 20.0) * 100;
}
