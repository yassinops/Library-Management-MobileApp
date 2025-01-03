import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:librarymanagement/Manage/Crud/add_author.dart';

class Authors extends StatefulWidget {
  const Authors({super.key});

  @override
  State<Authors> createState() => _AuthorsState();
}

class _AuthorsState extends State<Authors> {
  List<Map<String, dynamic>> _authors = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAuthors();
  }

  // Function to fetch authors from Firebase
  Future<void> _fetchAuthors() async {
    final url = Uri.parse(
        "https://library-management-7f396-default-rtdb.firebaseio.com/authors.json");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        List<Map<String, dynamic>> loadedAuthors = [];
        data.forEach((key, value) {
          loadedAuthors.add({
            'id': key,
            'firstName': value['firstName'],
            'lastName': value['lastName'],
            'telephone': value['telephone'],
          });
        });

        setState(() {
          _authors = loadedAuthors;
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load authors");
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  // Function to delete an author
  Future<void> _deleteAuthor(String id) async {
    final url = Uri.parse(
        "https://library-management-7f396-default-rtdb.firebaseio.com/authors/$id.json");

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        setState(() {
          _authors.removeWhere((author) => author['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Author deleted successfully!')),
        );
      } else {
        throw Exception("Failed to delete author");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  // Function to show a dialog for modifying an author
  void _modifyAuthor(Map<String, dynamic> author) {
    final _firstNameController =
        TextEditingController(text: author['firstName']);
    final _lastNameController = TextEditingController(text: author['lastName']);
    final _telephoneController =
        TextEditingController(text: author['telephone']);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Modify Author"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _telephoneController,
              decoration: const InputDecoration(labelText: 'Telephone'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedAuthor = {
                'firstName': _firstNameController.text,
                'lastName': _lastNameController.text,
                'telephone': _telephoneController.text,
              };

              final url = Uri.parse(
                  "https://library-management-7f396-default-rtdb.firebaseio.com/authors/${author['id']}.json");

              try {
                final response = await http.patch(
                  url,
                  body: jsonEncode(updatedAuthor),
                );

                if (response.statusCode == 200) {
                  setState(() {
                    int index = _authors
                        .indexWhere((element) => element['id'] == author['id']);
                    _authors[index] = {
                      'id': author['id'],
                      ...updatedAuthor,
                    };
                  });
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Author modified successfully!')),
                  );
                } else {
                  throw Exception("Failed to modify author");
                }
              } catch (error) {
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $error')),
                );
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text("List of Authors",style: TextStyle(color: Colors.white, fontSize: 24),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add TextButton at the top of the page
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddAuthor()));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, // Foreground color (text color)
              backgroundColor: Colors.black, // Background color
              textStyle: const TextStyle(fontSize: 18), // Existing text style
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0), // Add some padding
              shape: RoundedRectangleBorder(
                // Add rounded corners if you want
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('Add Author'),
          ),
          // Show loading or list of authors
          _isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : _authors.isEmpty
                  ? const Expanded(
                      child: Center(child: Text("No authors found")))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _authors.length,
                        itemBuilder: (context, index) {
                          final author = _authors[index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                  '${author['firstName']} ${author['lastName']}'),
                              subtitle: Text('Tel: ${author['telephone']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () => _modifyAuthor(author),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        _deleteAuthor(author['id']),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
