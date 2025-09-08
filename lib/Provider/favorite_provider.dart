import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';



class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> get favorites => _favoriteIds;
  FavoriteProvider() {
    loadFavorites();
  }

  void toggleFavorite(DocumentSnapshot product) async {
    String prodectId = product.id;
    if (_favoriteIds.contains(prodectId)) {
      _favoriteIds.remove(prodectId);
      await _removeFavorite(prodectId);
    } else {
      _favoriteIds.add(prodectId);
      await _addFavorite(prodectId);
    }
    notifyListeners();
  }

  bool isFavorite(DocumentSnapshot product) {
    return _favoriteIds.contains(product.id);
  }

  //Add favorite to firebase//
  Future<void> _addFavorite(String productId) async {
    try {
      await _firestore.collection('favorites').doc(productId).set({
        'isFavorite': true,
      }
      );
    }
    catch (e) {
      print(e.toString());
    }
  }

  //Remove favorite from firebase//
  Future<void> _removeFavorite(String productId) async {
    try {
      await _firestore.collection('favorites').doc(productId).delete();
    }
    catch (e) {
      print(e.toString());
    }
  }

  //Load favorites from firebase//
  Future<void> loadFavorites() async {
    try{
      QuerySnapshot snapshot = await _firestore.collection('favorites').get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
      notifyListeners();
    }catch(e){
      print(e.toString());
    }
  }

  //Static method to access the provider from any context//
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(
        context,
        listen: listen
    );
  }


}