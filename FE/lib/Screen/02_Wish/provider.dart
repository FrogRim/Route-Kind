import 'package:flutter/material.dart';

import 'package:dart_findy/Screen/01_Search/product.dart';


class WishlistProvider extends ChangeNotifier {
  final Set<int> _likedProducts = {};

  bool isLiked(int productId) => _likedProducts.contains(productId);
  List<Product> get wishlistItems =>
      productList.where((product) => _likedProducts.contains(product.packageId)).toList();

  void toggleLike(int productId) {
    if (_likedProducts.contains(productId)) {
      _likedProducts.remove(productId);
    } else {
      _likedProducts.add(productId);
    }
    notifyListeners();
  }
}