import 'dart:async';
import "package:todo_app/Models/Users.dart";
import 'APIprovider.dart';

//here the user is registered

class Repository {
  final apiProvider = RegisterApi();

  Future<User> enterAllFields(String username, String firstname,
          String lastname, String email, String password) =>
      apiProvider.registerUser(username, firstname, lastname, email, password);

  Future<User> signIn(String username, String password, String apiKey) =>
      apiProvider.signInUser(username, password, apiKey);

  Future getUserTasks(String apiKey) =>
      apiProvider.getTask(apiKey);

  Future addUserTask(String apiKey, String taskName, String note) =>
      apiProvider.addTask(apiKey, taskName, note);
  
  Future editUserTask( String apiKey, int taskId, String taskName, String note) =>
      apiProvider.editTask(apiKey,taskId,taskName,note);
  
  Future deleteUserTask(String apiKey, int taskid)=>
  apiProvider.deleteTask(apiKey, taskid);
}
