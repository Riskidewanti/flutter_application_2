import 'package:flutter/material.dart';
import 'add_task.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key, required this.subject});

  final Map<String, dynamic> subject;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {

  @override
  Widget build(BuildContext context) {

    List tasks = widget.subject["tasks"];

    // HITUNG PROGRESS
    int done = tasks.where((t) => t["done"] == true).length;
    double progress = tasks.isEmpty ? 0 : done / tasks.length;

    return Scaffold(

      // TAMBAH TASK
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.blue),
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskPage()),
          );

          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
      ),

      body: Container(
        // UI ASLI
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5B8DEF), Color(0xFF4A6FD6)],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              const SizedBox(height: 15),

              // HEADER
              Row(
                children: [

                  IconButton(
                    onPressed: () => Navigator.pop(context, true),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),

                  const Spacer(),

                  Text(
                    widget.subject["name"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),
                ],
              ),

              const SizedBox(height: 20),

              // PROGRESS BAR 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white30,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // LIST TASK
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),

                  child: tasks.isEmpty
                      ? const Center(child: Text("Belum ada tugas"))

                      : ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {

                            final task = tasks[index];

                            return Card(
                              child: ListTile(

                                // CHECKBOX
                                leading: Checkbox(
                                  value: task["done"],
                                  onChanged: (value) {
                                    setState(() {
                                      task["done"] = value;
                                    });
                                  },
                                ),

                                // TITLE
                                title: Text(
                                  task["title"],
                                  style: TextStyle(
                                    decoration: task["done"]
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),

                                subtitle: Text("Deadline: ${task["dueDate"]}"),

                                // MENU EDIT + DELETE
                                trailing: PopupMenuButton<String>(
                                  onSelected: (value) async {

                                    if (value == "edit") {
                                      final updatedTask =
                                          await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              AddTaskPage(existingTask: task),
                                        ),
                                      );

                                      if (updatedTask != null) {
                                        setState(() {
                                          tasks[index] = updatedTask;
                                        });
                                      }
                                    }

                                    if (value == "delete") {
                                      setState(() {
                                        tasks.removeAt(index);
                                      });
                                    }
                                  },
                                  itemBuilder: (_) => const [
                                    PopupMenuItem(
                                      value: "edit",
                                      child: Text("Edit"),
                                    ),
                                    PopupMenuItem(
                                      value: "delete",
                                      child: Text("Delete"),
                                    ),
                                  ],
                                ),

                                // DETAIL TASK
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text(task["title"]),
                                      content: Text(task["detail"]),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}