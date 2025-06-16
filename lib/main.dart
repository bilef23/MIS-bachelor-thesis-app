import 'package:flutter/material.dart';
import 'screens/thesis_process_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thesis Process',
      theme: ThemeData(
        fontFamily: 'SFProRounded',
      ),
      debugShowCheckedModeBanner: false,
      home: ThesisProcessScreen(),
    );
  }
}
