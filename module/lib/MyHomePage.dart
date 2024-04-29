import 'package:flutter/material.dart';
import 'package:module/Card/Card.dart';
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _currentIndex = 0;

  final List<Map<String, String>> programLanguageData = [
    {
      'image': 'assets/images/python.jpg',
      'title': 'Python',
      'description': 'Python is an interpreted, object-oriented, high-level programming language with dynamic semantics developed by Guido van Rossum',
    },
    {
      'image': 'assets/images/csharp.jpg',
      'title': 'C#',
      'description' : 'C# is a general-purpose high-level programming language supporting multiple paradigms',
    },
    {
      'image': 'assets/images/javascript.jpg',
      'title': 'JavaScript',
      'description' : 'It is the only programming language that can run natively in a browser, making it an instrumental part of web development.',
    },
    {
      'image': 'assets/images/php.jpg',
      'title': 'PHP',
      'description' : 'PHP is a widely-used open source general-purpose scripting language that is especially suited for web development and can be embedded into HTML.',
    }
  ];

  void _nextCard() {
    setState(() {
      _currentIndex = ((_currentIndex + 1) % programLanguageData.length) as int;
    });
  }

  void _prevCard() {
    setState(() {
      _currentIndex = ((_currentIndex - 1 + programLanguageData.length) % programLanguageData.length) as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
          title: const Text(
              'My Stateful Widget',
              ),
          backgroundColor: Colors.blue,
          centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyCard(
              image: programLanguageData[_currentIndex]['image']!,
              cardTitle: programLanguageData[_currentIndex]['title']!,
              cardDescription: programLanguageData[_currentIndex]['description']!,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _prevCard,
                  child: Text('Назад'),
                ),
                ElevatedButton(
                  onPressed: _nextCard,
                  child: Text('Далі'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
