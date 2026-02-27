import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getData() async {
  try{
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/todos"),
      headers: {
        "Accept": "application/json",
        "User-Agent": "Mozilla/5.0",
      },
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data;
    }
    else {
      print("Body:${response.body}");
      throw Exception("Failed to load data");
    }
  }
  catch (e) {
    throw Exception("Error occurred: $e");
  }
}