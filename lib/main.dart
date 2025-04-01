//import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

// part 'example.g.dart';

// @RestApi(baseUrl: 'https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/')
// abstract class RestClient {
//   factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

//   @GET('/tasks')
//   Future<List<Task>> getTasks();
// }

// @JsonSerializable()
// class Task {
//   const Task({this.id, this.name, this.avatar, this.createdAt});

//   factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

//   final String? id;
//   final String? name;
//   final String? avatar;
//   final String? createdAt;

//   Map<String, dynamic> toJson() => _$TaskToJson(this);
// }

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
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/////CLASS FOR TO GET COFFEE IMAGE
class CoffeeImage {
  String? file;

  CoffeeImage({this.file});

  CoffeeImage.fromJson(Map<String, dynamic> json) {
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['file'] = file;
    return data;
  }
}

/////CLASS FOR TO SAY HELLO
class Root {
  String? code;
  String? hello;

  Root({this.code, this.hello});

  Root.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    hello = json['hello'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['hello'] = hello;
    return data;
  }
}

////CLASS FOR TO DND
class ResultDND {
  String? index;
  String? name;
  String? url;

  ResultDND({this.index, this.name, this.url});

  ResultDND.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['index'] = index;
    data['name'] = name;
    data['url'] = url;
    return data;
  }

  @override
  String toString() {
    return '$index  $name $url \n';
  }
}

////+
///
class RootDND {
  int? count;
  List<ResultDND?>? results;

  RootDND({this.count, this.results});

  RootDND.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = <ResultDND>[];
      json['results'].forEach((v) {
        results!.add(ResultDND.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    data['results'] =
        results != null ? results!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> postCoffee() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    try {
      final response =
          await dio.get('https://coffee.alexflipnote.dev/random.json');
      if (response.statusCode == 200) {
        return Future.value(CoffeeImage.fromJson(response.data).file);
      } else {}
    } catch (e) {
      print('$e');
      rethrow;
    }
    return "";
  }

  Future<String> sayHello() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    try {
      final response = await dio
          .get('https://hellosalut.stefanbohacek.dev/?ip=89.120.120.120');
      if (response.statusCode == 200) {
        return Future.value(Root.fromJson(response.data).hello);
      } else {
        print('error');
        return 'error';
      }
    } catch (e) {
      print('$e');
      rethrow;
    }
  }

  Future<RootDND?> getDND() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    try {
      final response = await dio.get('https://www.dnd5eapi.co/api/classes/');
      if (response.statusCode == 200) {
        return Future.value(RootDND.fromJson(response.data));
      } else {
        print('error');
        return null;
      }
    } catch (e) {
      print('$e');
      rethrow;
    }
  }

  Future<RootDND?> getDNDmonsters() async {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    try {
      final response = await dio.get('https://www.dnd5eapi.co/api/monsters/');
      if (response.statusCode == 200) {
        return Future.value(RootDND.fromJson(response.data));
      } else {
        print('error');
        return null;
      }
    } catch (e) {
      print('$e');
      rethrow;
    }
  }

  void showImage() async {
    final imageCoffee = await postCoffee();
    showDialog(
      context: context,
      barrierColor: Color.fromARGB(167, 48, 47, 47),
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
        return Image.network(imageCoffee, height: 50, width: 50);
      },
    );
  }

  void showHello() async {
    final textHello = await sayHello();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          return Text(textHello);
        });
  }

  void showDND() async {
    final objtDND = await getDND();
    final str = objtDND?.results?.fold("", (p, e) => p + e.toString());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 10), () {
            Navigator.of(context).pop();
          });
          return CupertinoApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  body: Text(str!, style: const TextStyle(fontSize: 20))));
        });
  }

  void showDNDmonsters() async {
    final objtDND = await getDNDmonsters();
    final str = objtDND?.results?.fold("", (p, e) => p + e.toString());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 10), () {
            Navigator.of(context).pop();
          });
          return CupertinoApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  body: Text(str!, style: const TextStyle(fontSize: 20))));
        });
  }

  late String weekN = '';
  late String dateW = DateTime.now().weekday.toString();
  late List dateM = [
    DateTime.now().day,
    DateTime.now().month,
    DateTime.now().year
  ];

  // @override
  // void initState(){
  //   String dateW = DateTime.now().weekday.toString();
  //   String weekN = '';
  //   List dateM = [DateTime.now().day, DateTime.now().month,DateTime.now().year];
  // }

  String weekdayName(dateW) {
    switch (dateW) {
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

  @override
  Widget build(BuildContext context) {
    //_flutterWearOsConnectivity.configureWearableAPI();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(107, 157, 193, 44),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(107, 157, 193, 44),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromRGBO(107, 157, 193, 44)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    weekdayName(dateW),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  Text(
                    dateM[0].toString() +
                        '.' +
                        dateM[1].toString() +
                        '.' +
                        dateM[2].toString(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromRGBO(107, 157, 193, 44)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(width: 50),
                  Text(
                    'MY API TESTER',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(children: [
              TextButton(
                  onPressed: showImage,
                  child: const Text('Coffee for you',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 255, 255, 255)))),
              const SizedBox(width: 10),
              TextButton(
                  onPressed: showHello,
                  child: const Text('Say hello',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 255, 255, 255)))),
            ]),
            const SizedBox(height: 20),
            const Text(
              'show DND info:\none tap - class | long tap - monster',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: showDND,
                onLongPress: showDNDmonsters,
                child: SingleChildScrollView(
                  child: const Text('click!',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255))),
                )),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
