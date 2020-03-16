import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Models/Tasks.dart';
import 'dart:convert';
import 'package:todo_app/Models/Users.dart';

//here we make the post requests to the API

class RegisterApi {
  Client client = Client();
  final _apiProvider = 'http://10.0.2.2:5000/v1/register';

  Future<User> registerUser(String username, String firstname, String lastname,
      String email, String password) async {
    print('you are in ');
    final response = await client.post(_apiProvider,
        body: jsonEncode({
          "username": username,
          "first_name": firstname,
          "last_name": lastname,
          "email": email,
          "password": password
        }));
    print(response.body.toString());
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      saveApiKey(result['data']['api_key']);
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to register');
    }
  }

  Future<User> signInUser(
      String username, String password, String apiKey) async {
    final response = await client.post('http://10.0.2.2:5000/v1/signin',
        headers: {"Authorization": apiKey},
        body: jsonEncode({"username": username, "password": password}));
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      saveApiKey(result['data']['api_key']);
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to sign in');
    }
  }

  Future addTask(String apiKey, String taskName, String note) async {
    final response = await client.post('http://10.0.2.2:5000/v1/tasks',
        headers: {"Authorization": apiKey, "Content-Type": "application/json"},
        body: jsonEncode({
          "title": taskName,
          "deadline": "",
          "done": false,
          "reminder": "",
          "note": note,
          "repeats": ""
        }));
    if (response.statusCode == 201) {
      
      print('task added');
    } else {
      throw Exception('failed to add task');
    }
  }

  Future editTask(
      String apiKey, int taskId, String taskName, String note) async {
    final response = await client.put('http://10.0.2.2:5000/v1/tasks/$taskId',
        headers: {"Authorization": apiKey, 'Content-Type': 'application/json'},
        body: jsonEncode({
          "title": taskName,
          "deadline": "",
          "done": true,
          "reminder": "",
          "note": note,
          "repeats": ""
        }));
    print('response code : ${response.statusCode}');
    if (response.statusCode == 204) {
      print('the task has been updated');
    } else {
      throw Exception('failed to update the task:');
    }
  }

  Future deleteTask(String apiKey, int taskid) async {
    final response = await client.delete(
      'http://10.0.2.2:5000/v1/tasks/$taskid',
      headers: {"Authorization": apiKey, 'Content-Type': 'application/json'},
    );
    print('status code is: ${response.statusCode}');
    if (response.statusCode == 204) {
      print('the task '+taskid.toString()+' has been deleted succesfully');
    } else {
      throw Exception('failed to delete the task: ' + taskid.toString());
    }
  }

  Future<List<Task>> getTask(String apiKey) async {
    final response = await client.get(
      'http://10.0.2.2:5000/v1/tasks',
      headers: {"Authorization": apiKey, 'Content-Type': 'application/json'},
    );
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      List<Task> tasks = [];
      for (Map json_ in result['data']) {
        try {
          tasks.add(Task.fromJson(json_));
        } catch (Exception) {
          print(Exception);
        }
      }
      return tasks;
    } else {
      throw Exception('failed to load tasks');
    }
  }

  saveApiKey(String apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('API_Token', apiKey);
  }
}
