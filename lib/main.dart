import 'package:flutter/material.dart';
import 'dart:io'; 
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; 
import 'screens/login_screen.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  
  
  runApp(const AgendaApp());
}

class AgendaApp extends StatelessWidget {
  const AgendaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(), 
      debugShowCheckedModeBanner: false, 
    );
  }
}