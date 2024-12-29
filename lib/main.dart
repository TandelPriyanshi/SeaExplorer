import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sea/Pages/moneyspent.dart';
import 'package:sea/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const MoneySpent(),
    )
  );  
}