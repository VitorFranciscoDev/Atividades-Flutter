import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  
                  Stack(
                    children: [
                      Container(width: 100, height: 100, color: Colors.grey),
                      Positioned(
                        left: 8,
                        top: 8,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.red,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.green,
                        ),
                      ),
                      Positioned(
                        left: 24,
                        top: 24,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  Stack(
                    children: [
                      Container(width: 100, height: 100, color: Colors.black),
                      Positioned(
                        left: 8,
                        top: 8,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.cyan,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.purple,
                        ),
                      ),
                      Positioned(
                        left: 24,
                        top: 24,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),

                  Stack(
                    children: [
                      Container(width: 100, height: 100),
                      Positioned(
                        left: 8,
                        top: 8,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.red,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.yellow,
                        ),
                      ),
                      Positioned(
                        left: 24,
                        top: 24,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  Stack(
                    children: [
                      Container(width: 100, height: 100, color: Colors.white),
                      Positioned(
                        left: 8,
                        top: 8,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Positioned(
                        left: 24,
                        top: 24,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.yellow,
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 32,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.lightGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}