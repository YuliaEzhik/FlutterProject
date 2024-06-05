import 'package:cookbook/Services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final FirestoreService firestoreService = FirestoreService();
  late SharedPreferences _prefs;

  void addToFavorites(String recipeName) async {
    List<String> favorites = _prefs.getStringList('favorites') ?? [];
    if (!favorites.contains(recipeName)) {
      favorites.add(recipeName);
      await _prefs.setStringList('favorites', favorites);
    }
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getRecipesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List recipesList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: recipesList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = recipesList[index];
              String docID = document.id;
              Map<String, dynamic> data =
              document.data() as Map<String, dynamic>;
              String recipeName = data['Name'];
              String recipeDesc = data['Description'];

              List<String> descLines = recipeDesc.split('\n');
              String trimmedDesc = descLines.take(3).join('\n');

              return ListTile(
                title: Text(recipeName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trimmedDesc),
                  ],
                ),
                leading: CircleAvatar(
                  radius: 27,
                  child: data.containsKey('img')
                      ? ClipOval(
                    child: Image.network(
                      "${data['img']}",
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    ),
                  )
                      : const CircleAvatar(),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => addToFavorites(recipeName),
                      icon: const Icon(Icons.star),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Text("No recipes yet");
        }
      },
    );
  }
}
