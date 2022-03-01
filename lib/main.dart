import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'models/word.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //?? hive??
  await Hive.initFlutter();
  Hive.registerAdapter(wordtestAdapter());
  await Hive.openBox<wordtest>('words');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); //세로방향 변경 방지
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '다너다너',
      theme: ThemeData(
          //primaryColor: Colors.brown,
          ),
      home: const HomeScreen(),
    );
  }
}
