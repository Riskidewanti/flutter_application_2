import 'package:flutter/material.dart';

// HALAMAN TAMBAH SUBJECT (pakai stateful karena ada input user)
class AddSubjectPage extends StatefulWidget {
  const AddSubjectPage({super.key});

  @override
  State<AddSubjectPage> createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {

  // CONTROLLER buat ambil input nama subject
  final TextEditingController _nameController = TextEditingController();

  /// TEMPLATE SUBJECT 
  final Map<String, Map<String, dynamic>> subjectTemplates = {
    "Matematika": {
      "icon": Icons.calculate,
      "color": Colors.orange,
    },
    "Fisika": {
      "icon": Icons.science,
      "color": Colors.purple,
    },
    "Pemrograman": {
      "icon": Icons.code,
      "color": Colors.blue,
    },
    "Jaringan": {
      "icon": Icons.network_check,
      "color": Colors.green,
    },
    "AI": {
      "icon": Icons.smart_toy,
      "color": Colors.deepOrange,
    },
    "Basis Data": {
      "icon": Icons.storage,
      "color": Colors.teal,
    },
  };

  // FUNCTION SIMPAN SUBJECT
  void _saveSubject() {
    String name = _nameController.text.trim();

    if (name.isEmpty) return; // validasi sederhana

    /// CEK APAKAH ADA DI TEMPLATE
    final template = subjectTemplates.entries.firstWhere(
      (e) => e.key.toLowerCase() == name.toLowerCase(),
      orElse: () => const MapEntry("", {}), // kalau ga ada → kosong
    ).value;

    // KIRIM DATA KE HALAMAN SEBELUMNYA
    Navigator.pop(context, {
      "name": name,
      "icon": template["icon"] ?? Icons.book, // default kalau ga ada template
      "color": template["color"] ?? Colors.grey,
      "tasks": [] // subject baru langsung punya list task kosong
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // BACKGROUND GRADIENT (biar konsisten sama halaman lain)
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
                      "Add Subject",
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

                      // INPUT NAMA MATA KULIAH
                      _input(
                        controller: _nameController,
                        label: "Nama Mata Kuliah",
                        icon: Icons.menu_book,
                      ),

                      const Spacer(),

                      // BUTTON SIMPAN
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _saveSubject, // simpan data
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

  // WIDGET INPUT BIAR REUSABLE
  Widget _input({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FB),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon), // icon kiri
          labelText: label, // label input
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }
}