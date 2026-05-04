import 'package:flutter/material.dart';
import 'task_detail.dart';
import 'add_subject.dart';

class TaskPage extends StatefulWidget {
  final String? selectedSubject;

  const TaskPage({super.key, this.selectedSubject});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  // MENYIMPAN STATUS FILTER
  String currentFilter = "all";

  // DATA SUBJECT UTAMA
  List<Map<String, dynamic>> subjects = [
    {
      "name": "Matematika",
      "icon": Icons.calculate,
      "color": Colors.orange,
      "tasks": []
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

    // AUTO OPEN SUBJECT DARI DASHBOARD
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
              builder: (_) => TaskDetailPage(subject: subject),
            ),
          ).then((value) {
            if (value == true) setState(() {});
          });
        });
      }
    }
  }

  // FUNGSI HAPUS SUBJECT
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
                subjects.remove(list[index]);
              });
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // FILTER DATA SESUAI PILIHAN MENU
    final filteredSubjects = currentFilter == "hasTask"
        ? subjects.where((s) => s["tasks"].isNotEmpty).toList()
        : subjects;

    return Scaffold(

      // BUTTON TAMBAH SUBJECT
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.blue),
        onPressed: () async {
          final newSubject = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddSubjectPage()),
          );

          if (newSubject != null && newSubject is Map<String, dynamic>) {
            setState(() {
              subjects.add(newSubject);
            });
          }
        },
      ),

      body: Container(
        // BACKGROUND GRADIENT (UI ASLI)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5B8DEF), Color(0xFF4A6FD6)],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              const SizedBox(height: 15),

              /// ===== HEADER =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // BUTTON BACK
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    ),

                    // TITLE
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
                          "${subjects.length} Subjects",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),

                    /// ===== FIX UTAMA DI SINI =====
                    /// SEBELUMNYA: hanya Icon → tidak bisa diklik
                    /// SEKARANG: PopupMenuButton → bisa sorting & filter
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.grid_view, color: Colors.white),

                      // AKSI SAAT MENU DIPILIH
                      onSelected: (value) {
                        setState(() {

                          // SORT A-Z
                          if (value == "az") {
                            subjects.sort((a, b) =>
                                a["name"].compareTo(b["name"]));
                          }

                          // TASK TERBANYAK
                          else if (value == "task_desc") {
                            subjects.sort((a, b) =>
                                b["tasks"].length.compareTo(a["tasks"].length));
                          }

                          // TASK TERSEDIKIT
                          else if (value == "task_asc") {
                            subjects.sort((a, b) =>
                                a["tasks"].length.compareTo(b["tasks"].length));
                          }

                          // TAMPILKAN SEMUA
                          else if (value == "filter_all") {
                            currentFilter = "all";
                          }
                        });
                      },

                      // ISI MENU
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

              /// ===== GRID SUBJECT =====
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

                      // HITUNG PROGRESS
                      int doneCount = subject["tasks"]
                          .where((t) => t["done"] == true)
                          .length;

                      double progress = subject["tasks"].isEmpty
                          ? 0
                          : doneCount / subject["tasks"].length;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskDetailPage(subject: subject),
                            ),
                          ).then((value) {
                            if (value == true) setState(() {});
                          });
                        },

                        // HAPUS DENGAN LONG PRESS
                        onLongPress: () =>
                            deleteSubject(index, filteredSubjects),

                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              // ICON SUBJECT
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

                              // NAMA SUBJECT
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

                              // JUMLAH TASK
                              Text(
                                "${subject["tasks"].length} Tasks",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 5),

                              // PROGRESS BAR
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.white30,
                                color: Colors.white,
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