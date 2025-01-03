import 'package:flutter/material.dart';
import 'package:librarymanagement/Lists/authors.dart';
import 'package:librarymanagement/Lists/books.dart';
import 'package:librarymanagement/Manage/Crud/add_author.dart';
import 'package:librarymanagement/Manage/Crud/add_book.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 234, 228, 228),
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            accountName: Text(
              "Ala Eddine Ezzine",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            accountEmail: Text(
              "Aladin@cloud.net",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/aladin.jpg"),
            ),
          ),
          ListTile(
            title: const Text(
              "List of Books",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: const Icon(Icons.menu_book_sharp, color: Colors.black),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const Books()),
              );
            },
          ),
          ListTile(
            title: const Text(
              "List of Authors",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: const Icon(Icons.people, color: Colors.black),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Authors()),
              );
            },
          ),
          ListTile(
            title: const Text(
              "search for author",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: const Icon(
              Icons.person_search,
              color: Colors.black,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
