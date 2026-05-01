import 'package:flutter/material.dart';
import 'add_task.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key, required this.subject});

  final Map<String, dynamic> subject; // data subject dari page sebelumnya

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {

  @override
  Widget build(BuildContext context) {

    List tasks = widget.subject["tasks"]; // ambil list task dari subject

    return Scaffold(

      // tombol tambah task
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.blue),
        onPressed: () async {

          // buka halaman tambah task
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskPage()),
          );

          // kalau ada data baru → masuk ke list
          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5B8DEF), Color(0xFF4A6FD6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              const SizedBox(height: 15),

              /// HEADER
              Row(
                children: [

                  // tombol back (kirim true biar page sebelumnya refresh)
                  IconButton(
                    onPressed: () => Navigator.pop(context, true),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),

                  const Spacer(),

                  // nama subject
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

              /// LIST TASK
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),

                  // kalau belum ada task
                  child: tasks.isEmpty
                      ? const Center(child: Text("Belum ada tugas"))

                      // kalau ada task → tampilkan list
                      : ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {

                            final task = tasks[index];

                            return Card(
                              child: ListTile(

                                // judul task
                                title: Text(task["title"]),

                                // deadline
                                subtitle: Text("Deadline: ${task["dueDate"]}"),

                                // klik → tampil detail
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