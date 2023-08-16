import 'package:flutter/material.dart';
import 'package:via_cep_app/app.dart';
import 'package:via_cep_app/database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteDatabase.getDatabase();
  runApp(const App());
}
