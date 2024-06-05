import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopList extends StatefulWidget {
  const ShopList({Key? key}) : super(key: key);

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  List<String> ingredients = [];

  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadIngredients();
  }

  void loadIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // read from local data
      ingredients = prefs.getStringList('ingredients') ?? [];
    });
  }

  void saveIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    // save to local data
    prefs.setStringList('ingredients', ingredients);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('The shopping list'),
    ),
    body: ListView.builder(
    itemCount: ingredients.length,
    itemBuilder: (context, index) {
    String ingredient = ingredients[index];
    return ListTile(
    title: Text(
    ingredient,
    ),
    onTap: () {
    // Edit or Delete ingredient
    showDialog(
    context: context,
    builder: (context) => AlertDialog(
    title: const Text('Choose an action'),
    actions: [
    TextButton(
    onPressed: () {
    Navigator.pop(context);
    showDialog(
    context: context,
    builder: (context) => AlertDialog(
    title: const Text('Edit'),
    content: TextField(
    controller: TextEditingController(text: ingredient),
    onChanged: (value) {
    ingredient = value;
    },
    ),
    actions: [
    TextButton(
    onPressed: () {
    Navigator.pop(context);
    },
    child: const Text('Cancel'),
    ),
    TextButton(
    onPressed: () {
    setState(() {
    ingredients[index] = ingredient;
    saveIngredients();
    });
    Navigator.pop(context);
    },
    child: const Text('OK'),
    ),
    ],
    ),
    );
    },
    child: const Text('Edit'),
    ),
    TextButton(
    onPressed: () {
    setState(() {
    ingredients.removeAt(index);
    saveIngredients();
    });
    Navigator.pop(context);
    },
    child: const Text('Delete'),
    ),
    ],
    ),
    );
    },
    );
    },
    ),


      // make new ingredient
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add an ingredient'),
              content: TextField(
                controller: _textFieldController,
                onChanged: (value) {
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      String newIngredient = _textFieldController.text;
                      if (!ingredients.contains(newIngredient)) {
                        ingredients.add(newIngredient);
                        saveIngredients();
                      }
                      _textFieldController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}

