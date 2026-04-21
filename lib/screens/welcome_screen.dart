import 'package:flutter/material.dart';
import 'dashboard.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> { 

  bool isPressed = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [

              SizedBox(height: 40),

              Text(
                "Task Mate",
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 4,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Spacer(),

              // GAMBAR
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF3A86FF).withOpacity(0.25),
                      blurRadius: 40,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Image.asset(
                  'images/list.png',
                  height: 220,
                ),
              ),

              SizedBox(height: 40),

              // JUDUL
              Text(
                "Organize Your Tasks",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),

              SizedBox(height: 10),

              // SUBTITLE
              Text(
                "A simple way to manage your tasks\nand stay productive",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 20),

              // GARIS
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3A86FF),
                      Color(0xFF00C6FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Spacer(),

              // BUTTON DENGAN EFEK PRESS
              AnimatedScale(
                scale: isPressed ? 0.95 : 1,
                duration: Duration(milliseconds: 150),

                child: SizedBox(
                  width: double.infinity,

                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),

                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3A86FF),
                            Color(0xFF00C6FF),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(30),

                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF3A86FF)
                                .withOpacity(0.4),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),

                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(30),

                        splashColor: Colors.white24,

                        onTapDown: (_) {
                          setState(() {
                            isPressed = true;
                          });
                        },

                        onTapUp: (_) {
                          setState(() {
                            isPressed = false;
                          });
                        },

                        onTapCancel: () {
                          setState(() {
                            isPressed = false;
                          });
                        },

                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Dashboard(),
                            ),
                          );

                        },

                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                          ),

                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [

                              Text(
                                "GET STARTED",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                  letterSpacing: 1,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(width: 10),

                              Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color: Colors.white,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}