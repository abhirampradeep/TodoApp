import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo/Constants/api.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/appbar.dart';
import 'package:todo/widgets/content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  List<Todo> myTodos = [];

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  void initState() {
    // TODO: implement initState
    fetchdata();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    title.dispose();
    desc.dispose();
    super.dispose();
  }

  void fetchdata() async {
    try {
      http.Response response = await http.get(Uri.parse(api));
      var data = json.decode(response.body);
      print(data.runtimeType);
      print(response.body);
      print(response.body.runtimeType);

      print('hi abhi');
      data.forEach((todo) {
        Todo t = Todo(
            id: todo['id'],
            title: todo['title'],
            desc: todo['desc'],
            // isdone: todo['isdone'],
            date: todo['date']);
        setState(() {
          myTodos.add(t);
        });
      });
      print(myTodos.length);
      print('hi goiss');
    } catch (e) {
      print('error is there in fetching');
    }
  }

  delete(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse(api + '/' + id));
      setState(() {
        myTodos = [];
      });
      fetchdata();
    } catch (e) {
      print('error is there in deleting');
    }
  }

  void postdata(String title, String desc) async {
    try {
      http.Response response = await http.post(
        Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'desc': desc,
          "isDone": false,
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          myTodos = [];
        });
        fetchdata();
      } else {
        print('error in posting');
      }
    } catch (e) {
      print('error is there in posting');
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppbar(), // Assuming customAppbar() returns your custom app bar
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: myTodos.map((e) {
                return content(
                  titlecontent: e.title.toString(),
                  desc: e.desc.toString(),
                  // date: e.date.toString(),
                  onPress: () => delete(e.id.toString()),
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Item'),
                actions: <Widget>[
                  TextField(
                    controller: title,
                  ),
                  TextField(
                    controller: desc,
                  ),
                  TextButton(
                    onPressed: () {
                      postdata(title.text, desc.text);
                      title.clear();
                      desc.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text('Add value'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
