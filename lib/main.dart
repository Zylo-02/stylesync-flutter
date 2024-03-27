import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stylesync/app.dart';

Future<void> main() async {
  // Ensure that Flutter's widgets binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load the .env file
  await dotenv.load(fileName: ".env");

  // TODO: Initialize Local Storage
  // TODO: Await Native Splash
  // TODO: Initialize Firebase
  // TODO: Initialize Authentication

  // Run your Flutter application
  runApp(const App());
}
