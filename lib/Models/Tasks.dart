class Task {
  List<Task> tasks;
  String note;
  DateTime timeToComplete;
  bool done;
  String repeats;
  DateTime deadline;
  List<DateTime> reminders;
  int taskid;
  String title;

  Task(this.title, this.taskid, this.done, this.note);

  factory Task.fromJson(Map<String, dynamic>parsedJson) {
    return Task(
      parsedJson['title'],
      parsedJson['id'], 
      parsedJson['done'],
      parsedJson['note']
      // title: json['title'], 
      // taskid: json['id'],
      // done: json['done'],
      // note: json['note']
       );
  }
}
