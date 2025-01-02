import 'package:flutter/material.dart';

class Authors extends StatefulWidget {
  const Authors({super.key});

  @override
  State<Authors> createState() => _AuthorsState();
}

class _AuthorsState extends State<Authors> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("list of authors"),
    );
  }
}