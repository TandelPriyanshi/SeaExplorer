import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class AddDieselRecord extends StatefulWidget {
  const AddDieselRecord({Key? key}) : super(key: key);

  @override
  State<AddDieselRecord> createState() => _AddDieselRecordState();
}

class _AddDieselRecordState extends State<AddDieselRecord> {
  final _formKey = GlobalKey<FormState>();
  final _database = FirebaseDatabase.instance.ref("DieselRecords");

  final TextEditingController _litersController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Diesel Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Date Field with Calendar Picker
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                        ? 'Date'
                        : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // liter
              TextFormField(
                controller: _litersController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  labelText: 'Liters',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter liters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              // price
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),

              // button 
             ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && _selectedDate != null) {
                    final record = {
                      'date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
                      'liters': double.parse(_litersController.text),
                      'price': double.parse(_priceController.text),
                    };

                    await _database.push().set(record);
                    Navigator.pop(context);
                  } else if (_selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a date')),
                    );
                  }
                },
                // style: constButtonStyle(
                //   minimumSize: ,
                // ),
                child: const Text('Add Record'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
