import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTasksScreen extends StatefulWidget {
  @override
  _MyTasksScreenState createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  List<Task> _tasks = [];
  final _taskController = TextEditingController();
  final _dateTimeController = TextEditingController();
  bool _isEditing = false;
  late int _editingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.yellowAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Mubashir'),
              accountEmail: Text('mubashir@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/images2.jpg'),
              ),
            ),
            ListTile(
              title: Text('Settings'),
              trailing: Icon(Icons.settings),
              onTap: () {},
            ),
            ListTile(
              title: Text('Help'),
              trailing: Icon(Icons.help),
              onTap: () {
                
              },
            ),
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.logout),
              onTap: () {
                
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
           image: AssetImage('assets/images/images.jpg'),
            fit: BoxFit.cover,
          ),
        ),
         child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'Add Task',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.deepOrange[50],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _dateTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date and Time',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.deepOrange[50],
                ),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null) {
                    final TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (timeOfDay != null) {
                      final DateTime dateTime = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                          timeOfDay.hour,
                          timeOfDay.minute);
                      _dateTimeController.text =
                          DateFormat.yMd().add_Hm().format(dateTime);
                    }
                  }
                },
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 248, 255, 34)),
              ),
              onPressed: _isEditing
                  ? () {
                      setState(() {
                        _tasks[_editingIndex] = Task(
                            _taskController.text, _dateTimeController.text);
                        _taskController.clear();
                        _dateTimeController.clear();
                        _isEditing = false;
                      });
                    }
                  : () {
                      setState(() {
                        _tasks.add(Task(
                            _taskController.text, _dateTimeController.text));
                        _taskController.clear();
                        _dateTimeController.clear();
                      });
                    },
              child: Text(_isEditing ? 'Update Task' : 'Add Task',
                  style: TextStyle(fontSize: 18)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tasks[index].task,
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(_tasks[index].dateTime,
                        style: TextStyle(fontSize: 14)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              _taskController.text = _tasks[index].task;
                              _dateTimeController.text = _tasks[index].dateTime;
                              _isEditing = true;
                              _editingIndex = index;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _tasks.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String task;
  String dateTime;

  Task(this.task, this.dateTime);
}
