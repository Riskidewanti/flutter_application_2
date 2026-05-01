import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/task_detail.dart';
import 'package:flutter_application_2/screens/add_subject.dart';

class TaskPage extends StatefulWidget {
  final String? selectedSubject; // subject dari dashboard (kalau ada)

  const TaskPage({super.key, this.selectedSubject});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  String currentFilter = "all"; // buat filter (semua / ada task)

  // data utama subject
  List<Map<String, dynamic>> subjects = [
    {
      "name": "Matematika",
      "icon": Icons.calculate,
      "color": Colors.orange,
      "tasks": [] // list tugas per subject
    },
    {
      "name": "Fisika",
      "icon": Icons.science,
      "color": Colors.purple,
      "tasks": []
    },
    {
      "name": "Pemrograman", 
      "icon": Icons.code,
      "color": Colors.blue,
      "tasks": []
    },
    {
      "name": "Jaringan", 
      "icon": Icons.network_check,
      "color": Colors.green,
      "tasks": []
    },
  ];

  @override
  void initState() {
    super.initState();

    // kalau masuk dari dashboard → langsung buka subject
    if (widget.selectedSubject != null) {
      final subject = subjects.firstWhere(
        (s) => s["name"] == widget.selectedSubject,
        orElse: () => {},
      );

      if (subject.isNotEmpty) {
        Future.microtask(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailPage(subject: subject),
            ),
          ).then((value) {
            if (value == true) {
              setState(() {}); // refresh kalau ada perubahan
            }
          });
        });
      }
    }
  }

  // fungsi hapus subject
  void deleteSubject(int index, List list) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Subject"),
        content: Text("Yakin mau hapus ${list[index]["name"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                subjects.remove(list[index]); // hapus dari list utama
              });
            },
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // filter data sebelum ditampilkan
    final filteredSubjects = currentFilter == "hasTask"
        ? subjects.where((s) => s["tasks"].isNotEmpty).toList()
        : subjects;

    return Scaffold(

      // tombol tambah subject
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.blue),
        onPressed: () async {

          final newSubject = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSubjectPage(),
            ),
          );

          // kalau ada subject baru → masuk ke list
          if (newSubject != null && newSubject is Map<String, dynamic>) {
            setState(() {
              subjects.add(newSubject);
            });
          }
        },
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5B8DEF),
              Color(0xFF4A6FD6),
            ],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              const SizedBox(height: 15),

              /// HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // tombol back
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),

                    // judul
                    Column(
                      children: [
                        const Text(
                          "My Tasks",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${subjects.length} Subjects", // jumlah subject
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    /// MENU (sorting + filter)
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.grid_view, color: Colors.white),
                      onSelected: (value) {
                        setState(() {
                          // sorting A-Z
                          if (value == "az") {
                            subjects.sort((a, b) => a["name"].compareTo(b["name"]));
                          } 
                          // task terbanyak
                          else if (value == "task_desc") {
                            subjects.sort((a, b) =>
                                b["tasks"].length.compareTo(a["tasks"].length));
                          } 
                          // task tersedikit
                          else if (value == "task_asc") {
                            subjects.sort((a, b) =>
                                a["tasks"].length.compareTo(b["tasks"].length));
                          } 
                          // filter: hanya yang punya task
                          else if (value == "filter_has_task") {
                            currentFilter = "hasTask";
                          } 
                          // tampilkan semua
                          else if (value == "filter_all") {
                            currentFilter = "all";
                          }
                        });
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "az",
                          child: Text("Urut A-Z"),
                        ),
                        const PopupMenuItem(
                          value: "task_desc",
                          child: Text("Task Terbanyak"),
                        ),
                        const PopupMenuItem(
                          value: "task_asc",
                          child: Text("Task Tersedikit"),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: "filter_has_task",
                          child: Text("Ada Task Saja"),
                        ),
                        const PopupMenuItem(
                          value: "filter_all",
                          child: Text("Semua Subject"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// GRID SUBJECT
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: filteredSubjects.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {

                      final subject = filteredSubjects[index];

                      return GestureDetector(
                        // klik → masuk detail
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailPage(
                                subject: subject,
                              ),
                            ),
                          ).then((value) {
                            if (value == true) {
                              setState(() {}); // refresh kalau ada perubahan
                            }
                          });
                        },

                        // tahan → delete
                        onLongPress: () => deleteSubject(index, filteredSubjects),

                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              // icon subject
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: subject["color"].withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  subject["icon"],
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // nama subject
                              Text(
                                subject["name"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),

                              const SizedBox(height: 6),

                              // jumlah task
                              Text(
                                "${subject["tasks"].length} Tasks",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}