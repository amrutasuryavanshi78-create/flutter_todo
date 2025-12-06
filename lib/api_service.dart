import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8080/api"; // 10.0.2.2 for Android emulator

  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Invalid email or password');
    }
  }

  // Register
  static Future<void> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"name": name, "email": email, "password": password}),
    );
    if (response.statusCode != 200) throw Exception('Failed to register');
  }

  // Fetch tasks
  static Future<List<dynamic>> fetchTasks(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/tasks?category=$category'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch tasks');
    }
  }

  // Add task
  static Future<void> addTask(String title, String category, DateTime dueDate) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "title": title,
        "category": category,
        "dueDate": dueDate.toIso8601String(),
        "done": false
      }),
    );
    if (response.statusCode != 200) throw Exception('Failed to add task');
  }

  // Update task
  static Future<void> updateTask(int id, bool done) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"done": done}),
    );
    if (response.statusCode != 200) throw Exception('Failed to update task');
  }

  // Delete task
  static Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/tasks/$id'));
    if (response.statusCode != 200) throw Exception('Failed to delete task');
  }
}
