import 'package:flutter/material.dart';
import "package:animated_icon/animated_button.dart";
//import 'package:example/page.dart';

void main() => 
  runApp(MyApp());


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Animated Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home:  Scaffold(
        body: Center(
          child: AnimatedButton(
            animationDuration: const Duration(milliseconds: 2000),
            initialText: "Submit",
            finalText: "Done",
            iconData: Icons.check,
            iconSize: 32.0,
            buttonStyle: ButtonStyles(
              primaryColor: Colors.blue.shade500,
              secondaryColor: Colors.green.shade500,
              elevation: 20.0,
              initialTextStyle: TextStyle(
                fontSize: 20.0,
                color: Colors.purple,
                
              ),

              finalTextStyle: TextStyle(
                fontSize: 24.0,
                color: Colors.yellow,
            ),
            borderRadius: 10.0,
          ),
            
          ),
        )
      )
    );
  }
}