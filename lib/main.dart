import 'package:flutter/material.dart';
import 'bookstore_app.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentsDir.path);

  runApp(const BookStoreApp());
}
