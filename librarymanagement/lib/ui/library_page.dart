import 'package:flutter/material.dart';
import 'package:librarymanagement/Component/menu.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "MyLibrary",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      drawer: const Menu(),
    );
  }
}
