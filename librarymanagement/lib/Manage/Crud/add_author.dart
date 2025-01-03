import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddAuthor extends StatefulWidget {
  const AddAuthor({super.key});

  @override
  State<AddAuthor> createState() => _AddAuthorState();
}

class _AddAuthorState extends State<AddAuthor> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  Future<void> _AddAuthor() async {
    if (_formkey.currentState!.validate()) {
      final url = Uri.parse(
          "https://library-management-7f396-default-rtdb.firebaseio.com/authors.json");

      try {
        final response = await http.post(
          url,
          body: jsonEncode({
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'telephone': _telephoneController.text
          }),
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('author added successfully!')),
          );
          _formkey.currentState!.reset();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to add author. Please try again.')),
          );
        }
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $err')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("First Name"),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter you FirstName"
                        : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Last name"),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter you Name"
                        : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Numero Telephone"),
                  TextFormField(
                    controller: _telephoneController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter you Name"
                        : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(320, 49),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      _AddAuthor();
                    },
                    child: Text("Add Author"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
