import 'package:flutter/material.dart';
import 'task_page.dart'; // import halaman tujuan (TaskPage)

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {

    // DATA SUBJECT (isi kartu yang bakal ditampilkan)
    final List<Map<String, dynamic>> subjects = [
      {
        "name": "Matematika",
        "image": "images/math.png",
        "color": Colors.orange,
      },
      {
        "name": "Fisika",
        "image": "images/physics.png",
        "color": Colors.red,
      },
      {
        "name": "Pemrograman",
        "image": "images/code.png",
        "color": Colors.blue,
      },
      {
        "name": "Jaringan",
        "image": "images/network.png",
        "color": Colors.green,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF), // warna background utama
      body: SafeArea( // biar ga ketabrak notch / status bar
        child: Column(
          children: [

            // ===== HEADER =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // TEXT WELCOME
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            "Find Your Course",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),

                  SizedBox(height: 25),

                  // ===== CARD PROMO =====
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient( // background gradasi
                        colors: [
                          Color(0xFF4A90E2),
                          Color(0xFF6A5AE0),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.3),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 28,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Upgrade Your Skills 🚀",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  // ===== TITLE + SEE ALL =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        "Subjects",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      // BUTTON KE HALAMAN TASK
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TaskPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
                ],
              ),
            ),

            /// ===== GRID SUBJECT =====
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: subjects.length, // jumlah item
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 kolom
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {

                    final subject = subjects[index]; // ambil data per item

                    return GestureDetector(
                      // KETIKA DI KLIK → PINDAH KE TASK PAGE
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskPage(
                              selectedSubject: subject["name"], // kirim data subject
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            // ICON / GAMBAR SUBJECT
                            Container(
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: subject["color"].withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                subject["image"],
                                height: 35,
                              ),
                            ),

                            SizedBox(height: 15),

                            // NAMA SUBJECT
                            Text(
                              subject["name"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
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
    );
  }
}