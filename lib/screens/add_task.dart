import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {

  // OPTIONAL → kalau ada berarti mode EDIT
  final Map<String, dynamic>? existingTask;

  const AddTaskPage({super.key, this.existingTask});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  /// AUTO ISI DATA SAAT EDIT
  @override
  void initState() {
    super.initState();

    if (widget.existingTask != null) {
      _nameController.text = widget.existingTask!["title"];
      _dateController.text = widget.existingTask!["dueDate"];
      _detailController.text = widget.existingTask!["detail"];
    }
  }

  /// ===== SIMPAN / UPDATE =====
  void _saveTask() {
    if (_nameController.text.isEmpty) return;

    Navigator.pop(context, {
      "title": _nameController.text,
      "dueDate": _dateController.text.isEmpty ? "-" : _dateController.text,
      "detail": _detailController.text.isEmpty ? "-" : _detailController.text,

      /// NOTE:
      /// - kalau edit → ambil status lama
      /// - kalau tambah baru → default false
      "done": widget.existingTask?["done"] ?? false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  children: [

                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),

                    const Spacer(),

                    const Text(
                      "Add Task",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),
                    const SizedBox(width: 30),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ===== FORM =====
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),

                  child: Column(
                    children: [

                      _input(
                        controller: _nameController,
                        label: "Nama Tugas",
                        icon: Icons.edit,
                      ),

                      const SizedBox(height: 15),

                      _input(
                        controller: _dateController,
                        label: "Deadline",
                        icon: Icons.calendar_today,
                      ),

                      const SizedBox(height: 15),

                      _input(
                        controller: _detailController,
                        label: "Detail",
                        icon: Icons.description,
                        maxLines: 3,
                      ),

                      const Spacer(),

                      /// BUTTON DINAMIS (ADD / EDIT)
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _saveTask,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5B8DEF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            widget.existingTask == null
                                ? "Simpan"
                                : "Update",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// ===== INPUT REUSABLE =====
  Widget _input({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FB),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }
}