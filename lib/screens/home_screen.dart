import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logout() async {
    try {
      await _auth.signOut();
      setState(() {});
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ListView(
        children: const [
          // Add your list items here
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your floating action button logic here
          logout();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
