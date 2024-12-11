import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dart_findy/Constant/Constants.dart';
import './provider.dart';


class WishPage extends StatelessWidget {
  const WishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      // appBar: AppBar(
      //   title: const Text('위시리스트'),
      // ),
      body: Consumer<WishlistProvider>(
        builder: (context, wishlistProvider, child) {
          final wishlistItems = wishlistProvider.wishlistItems;

          if (wishlistItems.isEmpty) {
            return const Center(
              child: Text('위시리스트가 비어있습니다'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              final product = wishlistItems[index];
              return Card(
                color: BaseColorWhite,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // 상품 이미지
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          product.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // 상품 정보
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.keyword,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 삭제 버튼
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () =>
                            wishlistProvider.toggleLike(product.packageId),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class WishlistItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  bool isFavorite;

  WishlistItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isFavorite = true,
  });
}