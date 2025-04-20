import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_ce/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // text editing controller
  final textcontroller = TextEditingController();
  // a list
  List todos = [];
  //Call the boxx
  final myboxx = Hive.box("Mybox");
  // check box
  //bool? is_checked = false;
  bool check = false;
  // add a new task
  void addnewtask() {
    showDialog(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            backgroundColor: Colors.grey.shade500,
            title: Column(
              children: [
                Lottie.asset("assets/lottie/ani3.json"),
                Text(
                  "Add new task",
                  style: TextStyle(
                    fontFamily: "myfont",
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            content: TextField(
              controller: textcontroller,

              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Add new task",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),

                hintStyle: TextStyle(
                  fontFamily: "myfont",
                  fontWeight: FontWeight.w300,
                  fontSize: 17,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  addtask();
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontFamily: "myfont",
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  textcontroller.clear();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "X",
                      style: TextStyle(
                        fontFamily: "myfont",
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  // for add the task
  void addtask() {
  String todo = textcontroller.text.trim(); // trim to remove white spaces
  bool statu = false;

  if (todo.isEmpty) return; // Don't add empty todos

  setState(() {
    todos.add({
      'task': todo,
      'status': statu,
    });
    textcontroller.clear();
  });

  savedatabase();
}

  // this is for the hive
  @override
  void initState() {
    // check if some todo in list put him
    todos = (myboxx.get("TODO_List")) ?? [];

    super.initState();
  }

  //save in  data bass
  void savedatabase() {
    myboxx.put('TODO_List', todos);
  }

  @override
  Widget build(BuildContext context) {
    //list
    // remove
    void remove(int index) {
      setState(() {
        todos.removeAt(index);
      });
      savedatabase();
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade900,

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          addnewtask();
        },
        child: Icon(IconlyLight.plus),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Slidable(
              endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      remove(index);
                    },
                    icon: IconlyBroken.delete,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    todos[index]['status'] = !todos[index]['status'];
                      
                  });
                  savedatabase();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: todos[index]["status"] ? Colors.grey.shade700 : Colors.grey.shade400 ,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    trailing: Checkbox(
                      checkColor: Colors.white,
                    activeColor: Colors.green,
      
                      value: todos[index]["status"],
                      onChanged: (newBool) {
                        setState(() {
                          todos[index]["status"] = newBool;

                        });
                        
                      },
                    ),
                    leading: Icon(IconlyBold.arrow_right),
                    title: Text(
                      
                      todos[index]['task'],
                      
                      style: TextStyle(
                        decoration: todos[index]["status"] ? TextDecoration.lineThrough : TextDecoration.none,
                        textBaseline : todos[index]["status"] ? TextBaseline.alphabetic: TextBaseline.ideographic,
                        fontFamily: "myfont",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
