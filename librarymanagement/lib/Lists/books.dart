import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:librarymanagement/Manage/Crud/add_book.dart'; // Import your AddBook page

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List<Map<String, dynamic>> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final url = Uri.parse(
        "https://library-management-7f396-default-rtdb.firebaseio.com/books.json");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        List<Map<String, dynamic>> loadedBooks = [];
        data.forEach((key, value) {
          loadedBooks.add({
            'id': key,
            'title': value['title'],
            'isbn': value['isbn'],
            'date': value['date'],
          });
        });

        setState(() {
          _books = loadedBooks;
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load books");
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

  Future<void> _deleteBook(String id) async {
    final url = Uri.parse(
        "https://library-management-7f396-default-rtdb.firebaseio.com/books/$id.json");

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        setState(() {
          _books.removeWhere((book) => book['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Book deleted successfully!')),
        );
      } else {
        throw Exception("Failed to delete book");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  void _modifyBook(Map<String, dynamic> book) {
    // ... (Modify book dialog code - same as before)
    // ... (Make sure to use _isbnController and _dateController correctly)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddBook()));
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                textStyle: const TextStyle(fontSize: 18),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Add Book'),
            ),
          ),
          _isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : _books.isEmpty
                  ? const Expanded(
                      child: Center(child: Text("No books found")))
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.7, // Adjust this value as needed
                            mainAxisExtent: 200, // Adjust this value as needed
                          ),
                          itemCount: _books.length,
                          itemBuilder: (context, index) {
                            final book = _books[index];
                            return Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Title: ${book['title']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('ISBN: ${book['isbn']}'),
                                    Text('Date: ${book['date']}'),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () => _modifyBook(book),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () => _deleteBook(book['id']),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}