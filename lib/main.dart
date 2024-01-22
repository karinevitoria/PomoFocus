import 'package:flutter/material.dart';
import 'screens/start_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: StartPage(),
  ));
}
