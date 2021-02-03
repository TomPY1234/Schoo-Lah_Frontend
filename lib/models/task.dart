// This class is given. Do nothing on it.

class Task {
  int id;
  String title;
  bool completed;

  Task({this.id, this.title, this.completed = false});
  Task.copy(Task from)
      : this(id: from.id, title: from.title, completed: from.completed);
  Task.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'], title: json['title'], completed: json['completed']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'completed': completed};
}
