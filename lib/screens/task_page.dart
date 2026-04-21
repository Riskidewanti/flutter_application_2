import 'package:flutter/material.dart';
import 'dashboard.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> tasks = [
      {"name": "Matematika", "icon": Icons.calculate, "color": Colors.orange},
      {"name": "Fisika", "icon": Icons.science, "color": Colors.purple},
      {"name": "Pemrograman", "icon": Icons.code, "color": Colors.cyan},
      {"name": "Jaringan", "icon": Icons.wifi, "color": Colors.green},
      {"name": "Basis Data", "icon": Icons.storage, "color": Colors.indigo},
      {"name": "Sistem Operasi", "icon": Icons.computer, "color": Colors.teal},
      {"name": "AI", "icon": Icons.smart_toy, "color": Colors.redAccent},
      {"name": "Keamanan", "icon": Icons.security, "color": Colors.amber},
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.blue),
        onPressed: () {},
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5B8DEF),
              Color(0xFF4A6FD6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              SizedBox(height: 15),

              /// HEADER
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// BACK BUTTON 
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),

                        onTap: () {

                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  Duration(milliseconds: 500),

                              pageBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                              ) =>
                                  Dashboard(),

                              transitionsBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                                child,
                              ) {

                                final slideAnimation = Tween(
                                  begin: Offset(-1, 0),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOut,
                                  ),
                                );

                                return SlideTransition(
                                  position: slideAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );

                        },

                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.20),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    /// TITLE
                    Column(
                      children: [

                        Text(
                          "My Tasks",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 8),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.20),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "8 Subjects Active",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// MENU BUTTON
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.grid_view_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

              /// SEARCH
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: "Search subject...",
                      hintStyle: TextStyle(
                        color: Colors.white70,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25),

              /// GRID
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    itemCount: tasks.length,

                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),

                    itemBuilder: (context, index) {

                      final task = tasks[index];

                      return Container(
                        padding: EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(25),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            /// ICON
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: task["color"].withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                task["icon"],
                                size: 30,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(height: 12),

                            /// TITLE
                            Text(
                              task["name"],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 6),

                            /// SUBTITLE
                            Text(
                              "4 Tasks",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
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