import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/Services/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({Key? key}) : super(key: key);

  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class Ingredient {
  String name;
  String quantity;

  Ingredient({required this.name, required this.quantity});
}

class _AdminMenuState extends State<AdminMenu> {
  final FirestoreService firestoreService = FirestoreService();
  late List<String> categoryList = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() {
    firestoreService.getCategoriesStream().listen((snapshot) {
      setState(() {
        categoryList = snapshot.docs
            .map((doc) =>
        (doc.data() as Map<String, dynamic>)['category_name']
        as String? ?? '')
            .toList();
      });
    });
  }

  String? selectedCategory;
  List<Ingredient> ingredients = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController historyController = TextEditingController();
  String imageUrl = '';

  late String Name,
      Description,
      img,
      Ingredients,
      Cooking_History,
      Category_tag;

  late TextEditingController ingredientNameController = TextEditingController();
  late TextEditingController ingredientQuantityController =
  TextEditingController();

  void addIngredientToList() {
    String name = ingredientNameController.text;
    String quantity = ingredientQuantityController.text;
    if (name.isNotEmpty && quantity.isNotEmpty) {
      setState(() {
        ingredients.add(Ingredient(name: name, quantity: quantity));
      });
      ingredientNameController.clear();
      ingredientQuantityController.clear();
    }
  }

  Future<void> openRecipeBox({String? docID}) async {
    String? recipeName;
    String? recipeDesc;
    String? recipeCategory;
    String? recipeHistory;

    if (docID != null) {
      // Отримання інформації про рецепт для редагування
      DocumentSnapshot document = await firestoreService.getRecipeDocument(docID);
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      recipeName = data['Name'];
      recipeDesc = data['Description'];
      recipeCategory = data['Category_tag'];
      recipeHistory = data['Cooking_History'];
    }

    // Відображення діалогового вікна з заповненими полями
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
      content: SingleChildScrollView(
      child: Column(
      children: [
      TextField(
      controller: nameController..text = recipeName ?? '',
      decoration: const InputDecoration(
        labelText: 'Name of the recipe',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
      ),
    ),

    const SizedBox(height: 16),
    TextFormField(
    controller: descriptionController..text = recipeDesc ?? '',
    decoration: const InputDecoration(
    labelText: 'Description of the recipe',
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
    ),
    ),


        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: recipeCategory ?? selectedCategory,
          onChanged: (String? newValue) {
            setState(() {
              selectedCategory = newValue;
            });
          },
          items: categoryList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: const InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
          ),
        ),

        const SizedBox(height: 16),
        TextFormField(
          controller: historyController..text = recipeHistory ?? '',
          minLines: 1,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            labelText: 'Enter history (how to cook)',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
          ),
        ),

        const SizedBox(height: 16),
        // Додаткові поля та кнопки
        TextField(
          controller: ingredientNameController,
          decoration: const InputDecoration(
            labelText: 'Name of ingredient',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
          ),
        ),

        TextField(
          controller: ingredientQuantityController,
          decoration: const InputDecoration(
            labelText: 'Amount of ingredient',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: addIngredientToList,
          child: const Text('Add ingredient'),
        ),

        // Image Picker
        const SizedBox(height: 16),
        Center(
          child: IconButton(
            onPressed: () async {
              // Чекаємо картинку з галереї
              final file = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (file == null) return;

              String fileName = DateTime.now().microsecondsSinceEpoch.toString();
              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDireImages = referenceRoot.child('images');
              Reference referenceImagesToUpload = referenceDireImages.child(fileName);
              try {
                await referenceImagesToUpload.putFile(File(file.path));
                imageUrl = await referenceImagesToUpload.getDownloadURL();
              } catch (error) {}
            },
            icon: const Icon(Icons.camera_alt),
          ),
        ),
      ],
      ),
      ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (docID == null) {
                  firestoreService.addRecipe(
                    Name = nameController.text,
                    Description = descriptionController.text,
                    img = imageUrl,
                    Ingredients = ingredients.map((ingredient) => '${ingredient.name}\$${ingredient.quantity}').join('|'),
                    Cooking_History = historyController.text,
                    Category_tag = selectedCategory ?? '',
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Menu Page")),
      floatingActionButton: FloatingActionButton(
        onPressed: openRecipeBox,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                        onPressed: () => openRecipeBox(docID: docID),
                        icon: const Icon(Icons.settings),
                      ),
                      IconButton(
                        onPressed: () => firestoreService.deleteRecipe(docID),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("Ще немає рецептів"));
          }
        },
      ),
    );
  }
}
