import 'package:flutter/material.dart';
import '../Services/theme_services.dart';
import 'SettingsPage.dart';
import 'MenuPage.dart';
import 'FavoritesPage.dart';
import 'ShopListPage.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Settings(),
    Menu(),
    Favorites(),
    ShopList(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Row(
          children: [
            Text('CookBook'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              onchangeThem();
            },
            icon: const Icon(Icons.nightlight_round),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            backgroundColor: Color(0xffc5c9cb),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Color(0xffc5c9cb),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xffc5c9cb),
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            backgroundColor: Color(0xffc5c9cb),
            label: 'Shop List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
