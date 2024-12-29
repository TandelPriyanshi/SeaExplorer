import 'package:flutter/material.dart';
import 'package:sea/Componenet/my_card.dart';
import 'package:sea/Pages/diselpage.dart';

class MoneySpent extends StatefulWidget {
  const MoneySpent({super.key});

  @override
  State<MoneySpent> createState() => _MoneySpentState();
}

class _MoneySpentState extends State<MoneySpent> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Spent Money'
        ),
      ),
      body: ListView(
        children: [
          MyCard(
            name: 'Disel', 
            onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const DisplayDiselForm()),
                );
              },
          ),
        ], 
      )
    );
  }
}