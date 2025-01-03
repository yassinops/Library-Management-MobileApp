import 'package:flutter/material.dart';
import 'package:librarymanagement/ui/library_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: SizedBox(
          width: double.infinity,
          child: Container(
            color: const Color.fromARGB(255, 255, 254, 254),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/publibrary.jpg",
                    height: 300, width: 250),
                const SizedBox(height: 20),
                const Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Get ready to explore the world!",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "By learning Books..",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LibraryPage()));
                  },
                  child:const Text(
                    "Your Library",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: 50),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: "By checking your library, You have to Agreed to ",
                    style:  TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: [
                       TextSpan(
                        text: " the terms And conditions ",
                        style:TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                       TextSpan(
                          text: " And ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )),
                       TextSpan(
                          text: " Privacy Policy ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
