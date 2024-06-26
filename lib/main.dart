import 'package:flutter/material.dart';
import 'package:to_do_list_app/ToDoItem.dart';
import 'package:to_do_list_app/model/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'MyApp'),

      
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todosList = todo.todoList();
  var todoController = TextEditingController();
  List<todo> foundToDo = [];

  @override
  void initState() {
    foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile logo.webp'),
              )
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SearchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          child: const Text(
                            'All ToDos',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        ...foundToDo.reversed
                            .map((ToDoo) => ToDoItem(
                                  ToDo: ToDoo,
                                  onToDoChanged: handleToDoChange,
                                  onDeleteItem: deleteToDoItem,
                                ))
                            .toList(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0)
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: todoController,
                        decoration: const InputDecoration(
                            hintText: 'Add a new ToDo item',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        addToDoItem(todoController.text.toString());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(60, 60),
                          elevation: 10),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void handleToDoChange(todo ToDo) {
    setState(() {
      ToDo.isDone = !ToDo.isDone;
    });
  }

  void deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void addToDoItem(String ToDo) {
    setState(() {
      todosList.add(todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: ToDo));
    });
    todoController.clear();
  }

  Widget SearchBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            onChanged: (value) => runFilter(value),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
                size: 20,
              ),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, minWidth: 25),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )),
    );
  }

  void runFilter(String enteredKeyword) {
    List<todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundToDo = results;
    });
  }
}
