import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dateW = DateTime.now().weekday.toString();

  String weekdayName(dateW) {
    String weekN = '';
    switch(dateW){
      case '1':
        weekN = "Monday";
        break;
      case '2':
        weekN = "Tuesday";
        break;
      case '3':
        weekN = "Wednesday";
        break;
      case '4': 
        weekN = "Thursday";
        break;
      case '5':
        weekN = "Friday";
        break;
      case '6':
        weekN = "Saturday";
        break;
      case '7':
        weekN = "Sunday";
        break;
      }
    return weekN;
  }
  List dateM = [DateTime.now().day, DateTime.now().month,DateTime.now().year];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(107, 157, 193,44),
      appBar: AppBar(

        backgroundColor:  const Color.fromRGBO(107, 157, 193,44),

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                color: const Color.fromRGBO(107, 157, 193,44)),
              borderRadius: BorderRadius.circular(20),),
              child: 
              Row(
                children: [
                Text(
                weekdayName(dateW),
                style:
                TextStyle(
                  color:Color.fromARGB(255, 255, 255, 255),
                  fontSize: 40,),
            ),

            SizedBox(width: 90,),

              Text(
                dateM[0].toString()+'.'+dateM[1].toString()+'.'+dateM[2].toString(),
                style:TextStyle(
                  color:Color.fromARGB(255, 255, 255, 255),
                  fontSize: 30),
              ),
              ],
            ),
            ),
            SizedBox(height: 60),

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                color: const Color.fromRGBO(107, 157, 193,44)),
              borderRadius: BorderRadius.circular(20),),
              child:  
            Row(
              children: [
              SizedBox(width: 20,),
              Text(
              'TIME',
              style:TextStyle(
                color:Color.fromARGB(255, 255, 255, 255),
                fontSize: 30),
            ),

            SizedBox(width: 40),

              Text(
                'LESSEN',
                style:TextStyle(
                  color:Color.fromARGB(255, 255, 255, 255),
                  fontSize: 30),
              ),

              SizedBox(width: 40),

              Text(
                'AU',
                style:TextStyle(
                  color:Color.fromARGB(255, 255, 255, 255),
                  fontSize: 30),
              ),
              ],
            ),)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
