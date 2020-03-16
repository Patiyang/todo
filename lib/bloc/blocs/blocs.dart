import 'dart:async';

import 'package:todo_app/Models/Tasks.dart';
import 'package:todo_app/bloc/resources/repository.dart';
import 'package:todo_app/Models/Users.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:observable/observable.dart';

enum TaskView { Busy, Retrieved, NoData }

class RegisterBloc {
  final _repository = Repository();
  final _userSaver = PublishSubject<User>();
  

  Observable<User> get allFields => _userSaver.stream;

  registerUser(String username, String firstname, String lastname, String email,
      String password) async {
    User user = await _repository.enterAllFields(
        username, firstname, lastname, email, password);
    _userSaver.sink.add(user);
  }

  signInUser(String username, String password, String apiKey) async {
    User user = await _repository.signIn(username, password, apiKey);
    _userSaver.sink.add(user);
  }

  dispose() {
    _userSaver.close();
  }
}

class TaskBloc {
  final _repository = Repository();
  final _taskSubject = BehaviorSubject<List<Task>>();
  String apiKey;
  var _tasks = <Task>[];

  final StreamController<TaskView> stateController = StreamController<TaskView>();

  TaskBloc(String apikey) {
    this.apiKey = apikey;
    updateTasks(apikey).then((_) {
      print('got you maafaka '+apiKey);
      _taskSubject.add(_tasks);
    });
  }
  Stream<List<Task>> get tasks => _taskSubject.stream;

  Future updateTasks(String apiKey,{bool hasError = false, bool hasData = true}) async {
    stateController.add(TaskView.Busy);
    await Future.delayed(Duration(seconds: 1));

    if (hasError) {
      return stateController.addError('an error was encountered');
    }
    if (!hasData) {
      return stateController.add(TaskView.NoData);
    }
    _tasks = await _repository.getUserTasks(apiKey);
    stateController.add(TaskView.Retrieved);
  }
  
}

final userBloc = RegisterBloc();
