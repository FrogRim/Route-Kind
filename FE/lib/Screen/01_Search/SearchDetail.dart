import 'package:flutter/material.dart';

import 'package:dart_findy/Constant/Constants.dart';
import 'package:dart_findy/Screen/02_Wish/Wish.dart';
import './product.dart';
import './Search.dart';

class SearchDetailPage extends StatelessWidget {
  final Product product;

  const SearchDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColorWhite,
      appBar: AppBar(
        backgroundColor: AppBarStyle.backgroundColor,
        //title: Text(_name, style: AppBarStyle.titleTextStyle),
        elevation: AppBarStyle.elevation,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                //borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 200),
                ),
              ),
              Container(
                //margin: EdgeInsets.all(4),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: BaseColorPale,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: BaseColorCharcoal,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Text(
                    //   'Price: \$${product.price.toStringAsFixed(2)}',
                    //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    //     color: Theme.of(context).primaryColor,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],

                )
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(18),
                child: Row(
                  children: [
                    Text(
                      'Price: \$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => _ToWish(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaseColorCharcoal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Wish Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _ToWish(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WishPage()),
    );
  }
}
