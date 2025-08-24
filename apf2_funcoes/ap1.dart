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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 50, height:50, color: Colors.red),
                  Padding(padding: EdgeInsets.all(8)),
                  Container(width: 50, height: 50, color: Colors.green),
                  Padding(padding: EdgeInsets.all(8)),
                  Container(width: 50, height: 50, color: Colors.blue),
                ],
              ),

              Padding(padding: EdgeInsets.all(4)),

              Stack(
                children: [
                  Container(width: 200, height: 124, color: Colors.yellow),
                  Positioned(
                    left: 8,
                    top: 12,
                    child: Container(
                      width: 50,
                      height: 100,
                      color: Colors.purple,
                    ),
                  ),
                  Positioned(
                    left: 75,
                    top: 12,
                    child: Container(
                      width: 50,
                      height: 100,
                      color: Colors.cyan,
                    ),
                  ),
                  Positioned(
                    left: 142,
                    top: 8,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.purple,
                    ),
                  ),
                  Positioned(
                    left: 142,
                    top: 68,
                    child: Container(
                      width: 50,
                      height: 50, 
                      color: Colors.cyan
                    ),
                  ),
                ],
              ),

              Padding(padding: EdgeInsets.all(4)),

              Stack(
                children: [
                  Container(width: 120, height: 70, color: Colors.grey),
                  Positioned(
                    left: 34,
                    top: 10,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.black,
                    ),
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
