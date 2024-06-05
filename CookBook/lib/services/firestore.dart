import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // GET collection
  final CollectionReference recipes =
  FirebaseFirestore.instance.collection('recipes');

  final CollectionReference categories =
  FirebaseFirestore.instance.collection('categories');

  // CREATE
  Future<void> addRecipe(String Name, String Description, String img, String Ingredients, String Cooking_History,
      String Category_tag) {
    return recipes.add({
      'Name': Name,
      'Description': Description,
      'img': img,
      'Ingredients': Ingredients,
      'Cooking_History': Cooking_History,
      'Category_tag': Category_tag,
      'timestamp': Timestamp.now(),
    });
  }

  // READ
  Stream<QuerySnapshot> getCategoriesStream() {
    final categoriesStream = categories.orderBy('category_id', descending: true).snapshots();
    return categoriesStream;
  }
  Stream<QuerySnapshot> getRecipesStream() {
    final recipesStream = recipes.orderBy('timestamp' ,descending: true).snapshots();
    return recipesStream;
  }

  // NEW METHOD: GET single recipe document by ID
  Future<DocumentSnapshot> getRecipeDocument(String docID) {
    return recipes.doc(docID).get();
  }

  // UPDATE
  Future<void> updateRecipe(String docID, String newName, String newDesc) {   //String newIng
    return recipes.doc(docID).update({
      'Name': newName,
      'Description': newDesc,
      // 'Ingredients': newIng,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE
  Future<void> deleteRecipe(String docID) {
    return recipes.doc(docID).delete();
  }

}
