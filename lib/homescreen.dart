import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List todolist = [];
  final task = TextEditingController();
  final String API_URL = 'https://jsonplaceholder.typicode.com/todos';
  Future<List> fetodolist() async {
    final response = await http.get(Uri.parse(API_URL));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  void addTodo() {
    setState(() {
      todolist.add(task.value.text);
      task.clear();
    });
  }

  void editTodo() {}

  void deleteTodo(index) {
    setState(() {
      todolist.removeAt(index);
      task.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(' To Do List'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'สิ่งที่ต้องทำ'),
                        keyboardType: TextInputType.text,
                        controller: task,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () => addTodo(),
                        child: Text("Add"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: todolist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(todolist[index]['title']),
                        trailing: IconButton(
                          onPressed: () => deleteTodo(index),
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
