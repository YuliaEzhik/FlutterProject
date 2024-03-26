import 'package:flutter/material.dart';

class AdminMenu extends StatefulWidget {
  final String adminEmail;

  const AdminMenu({Key? key, required this.adminEmail}) : super(key: key);

  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Menu Page")),
      body: Center(
        child: Text(
          "Hello, ${widget.adminEmail}!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
