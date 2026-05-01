import 'package:flutter/material.dart';

// HALAMAN TAMBAH TASK (pakai Stateful karena ada input & state berubah)
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  // CONTROLLER buat ambil isi dari TextField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  // FUNCTION SIMPAN DATA
  void _saveTask() {
    if (_nameController.text.isEmpty) return; // validasi sederhana (ga boleh kosong)

    // KIRIM DATA KE HALAMAN SEBELUMNYA
    Navigator.pop(context, {
      "title": _nameController.text,
      "dueDate": _dateController.text.isEmpty ? "-" : _dateController.text,
      "detail": _detailController.text.isEmpty ? "-" : _detailController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // BACKGROUND GRADIENT
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

              /// ===== HEADER =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [

                    // BUTTON BACK
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

                    // JUDUL HALAMAN
                    const Text(
                      "Add Task",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),
                    const SizedBox(width: 30), // biar balance kanan kiri
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ===== FORM INPUT =====
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

                      // INPUT NAMA TUGAS
                      _input(
                        controller: _nameController,
                        label: "Nama Tugas",
                        icon: Icons.edit,
                      ),

                      const SizedBox(height: 15),

                      // INPUT DEADLINE
                      _input(
                        controller: _dateController,
                        label: "Deadline",
                        icon: Icons.calendar_today,
                      ),

                      const SizedBox(height: 15),

                      // INPUT DETAIL (bisa multi line)
                      _input(
                        controller: _detailController,
                        label: "Detail",
                        icon: Icons.description,
                        maxLines: 3,
                      ),

                      const Spacer(),

                      // BUTTON SIMPAN
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _saveTask, // panggil function simpan
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5B8DEF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            "Simpan",
                            style: TextStyle(
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

  // WIDGET REUSABLE INPUT (biar ga nulis TextField berulang)
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
          prefixIcon: Icon(icon), // icon di kiri
          labelText: label, // label input
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }
}