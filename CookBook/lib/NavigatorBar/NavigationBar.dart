// import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'SettingsPage.dart';
import 'MenuPage.dart';
import 'FavoritesPage.dart';
import 'ShopListPage.dart';
import 'package:cookbook/services/theme_services.dart';
// class NavigatorExample extends StatelessWidget {
//   const NavigatorExample({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MyNavigationBar(),
//     );
//   }
// }
class NavigatorExample extends StatefulWidget {
  const NavigatorExample({Key? key}) : super(key: key);

  @override
  State<NavigatorExample> createState() => _NavigatorExampleState();
}

class _NavigatorExampleState extends State<NavigatorExample> {
  //Initialialze firebase App
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const MyNavigationBar();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

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
        leading: GestureDetector(onTap: () {
          ThemeService().switchTheme();
        }),
        title: const Row(
          children: [
            Text('CookBook'),
            Icon(Icons.nightlight_round, size: 20),
          ],
        ),
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
