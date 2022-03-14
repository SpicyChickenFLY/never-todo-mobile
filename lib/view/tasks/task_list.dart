import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nevertodo/view/tasks/task.dart';

class TodoListWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: Consumer<TodoListModel>(builder: (context, tasks, child) {
        return ListView(
          children: tasks.tasks.map((TaskModel task) {
            return ChangeNotifierProvider.value(
                value: task, child: TaskWidget());
          }).toList(),
        );
      })),
      Consumer<TodoListModel>(
        builder: (context, tasks, child) {
          return TextField(
            controller: _controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'new task'),
            onSubmitted: (newTask) {
              tasks.addTaks(TaskModel(
                  text:
                      newTask)); // create new instance of task changeNotifier model
              _controller.clear(); // clear the text input after adding taks
              tasks.saveTasksToSharedPrefs();
            },
          );
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.view_list, color: Colors.blue),
              Text('Tasks')
            ],
          ),
          Column(
            children: [Icon(Icons.label, color: Colors.blue), Text('Tags')],
          ),
          Column(
            children: [Icon(Icons.done_all, color: Colors.blue), Text('Done')],
          )
        ],
      )
    ]);
  }
}
