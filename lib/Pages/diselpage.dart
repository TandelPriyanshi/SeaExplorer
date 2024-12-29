import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sea/Pages/add_diesel_record.dart';

class DisplayDiselForm extends StatefulWidget {
  const DisplayDiselForm({Key? key}) : super(key: key);

  @override
  State<DisplayDiselForm> createState() => _DisplayDiselFormState();
}

class _DisplayDiselFormState extends State<DisplayDiselForm> {
  final _database = FirebaseDatabase.instance.ref("diesel_records");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diesel Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddDieselRecord(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: _database.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            final records = Map<String, dynamic>.from(
                snapshot.data!.snapshot.value as Map);

            final dieselRecords = records.entries
                .map((entry) => Map<String, dynamic>.from(entry.value))
                .toList();

            return ListView.builder(
              itemCount: dieselRecords.length,
              itemBuilder: (context, index) {
                final record = dieselRecords[index];
                final t_price = record['liters'] * record['price'];
                return ListTile(
                  title: Text('Date: ${record['date']}'),
                  subtitle: Text(
                    'Liters: ${record['liters']} | Price: ${record['price']} | Total Price: ${t_price}'
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No records found.'));
        },
      ),
    );
  }
}
