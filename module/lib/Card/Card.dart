import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {

  final String image;
  final String cardTitle;
  final String cardDescription;

  const MyCard({
    super.key,
    required this.image,
    required this.cardTitle,
    required this.cardDescription,
  });

  @override
  Widget build(BuildContext context) {
      return Card(
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(image),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cardTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                  ),
                ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    cardDescription,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                ),
            ),
          ],
        ),
      );
  }
}
