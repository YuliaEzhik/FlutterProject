import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late SharedPreferences _prefs;
  late List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    getFavorites();
  }

  void getFavorites() {
    setState(() {
      favorites = _prefs.getStringList('favorites') ?? [];
    });
  }

  void removeFromFavorites(String recipeName) async {
    setState(() {
      favorites.remove(recipeName);
    });
    await _prefs.setStringList('favorites', favorites);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        String recipeName = favorites[index];
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('recipes').where('Name', isEqualTo: recipeName).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List recipesList = snapshot.data!.docs;
              if (recipesList.isNotEmpty) {
                DocumentSnapshot document = recipesList.first;
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String recipeDesc = data['Description'];
                String recipeImg = data['img'];

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
                    child: recipeImg.isNotEmpty
                        ? ClipOval(
                      child: Image.network(
                        recipeImg,
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
                        onPressed: () => removeFromFavorites(recipeName),
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              } else {
                return const Text("there is nothing here yet");
              }
            } else {
              return const Text("there is nothing here yet");
            }
          },
        );
      },
    );
  }
}
