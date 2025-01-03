import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddBook extends StatefulWidget {
  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBook> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();
  final TextEditingController _authorIdController = TextEditingController();

  // Method to send POST request
  Future<void> _addBook() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse(
          'https://library-management-7f396-default-rtdb.firebaseio.com/books.json');

      try {
        final response = await http.post(
          url,
          body: jsonEncode({
            'title': _titleController.text,
            'isbn': _isbnController.text,
            'date': _dateController.text,
            'photoUrl': _photoUrlController.text,
            'authorId': _authorIdController.text,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Book added successfully!')),
          );
          _formKey.currentState!.reset();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to add book. Please try again.')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Book'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text(
                'Book Title',
                style:  TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter book title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'ISBN',
                style:  TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _isbnController,
                decoration: const InputDecoration(
                  hintText: 'Enter ISBN',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ISBN';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Date',
                style:  TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  hintText: 'Enter Date',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Photo URL',
                style:  TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _photoUrlController,
                decoration: const InputDecoration(
                  hintText: 'Enter Photo URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a photo URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Author ID',
                style:  TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _authorIdController,
                decoration: const InputDecoration(
                  hintText: 'Enter Author ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _addBook,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Add Book'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}