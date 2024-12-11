import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dart_findy/Constant/Constants.dart';
import 'package:dart_findy/Screen/02_Wish/provider.dart';

import './product.dart';
import './SearchDetail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TravelFilter _activeFilter = const TravelFilter();
  late List<Product> _filteredProductsCache;
  TravelFilter? _lastFilter;

  List<Product> get filteredProducts {
    if (_lastFilter != _activeFilter) {
      _filteredProductsCache = productList
          .where((product) => _activeFilter.matches(product.category))
          .toList();
      _lastFilter = _activeFilter;
    }
    return _filteredProductsCache;
  }

  @override
  void initState() {
    super.initState();
    _filteredProductsCache = productList;
    _lastFilter = _activeFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterSection(),
            if (filteredProducts.isEmpty)
              const Expanded(
                child: Center(
                  child: Text('검색 결과가 없습니다'),
                ),
              )
            else
              Expanded(child: _buildProductGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.category),
          // Text(
          //   "Category",
          //   style: Theme.of(context).textTheme.titleLarge,
          // ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  label: "All",
                  selected: _activeFilter.theme == TravelConstants.THEME_ALL || _activeFilter.theme == null,
                  onSelected: (selected) => _updateFilter(
                    theme: selected ? TravelConstants.THEME_ALL : null,
                  ),
                ),
                _buildFilterChip(
                  label: "Nature",
                  selected: _activeFilter.theme == TravelConstants.THEME_NATURE,
                  onSelected: (selected) => _updateFilter(
                    theme: selected ? TravelConstants.THEME_NATURE : TravelConstants.THEME_ALL,
                  ),
                ),
                _buildFilterChip(
                  label: "City",
                  selected: _activeFilter.theme == TravelConstants.THEME_CITY,
                  onSelected: (selected) => _updateFilter(
                    theme: selected ? TravelConstants.THEME_CITY : TravelConstants.THEME_ALL,
                  ),
                ),
                _buildFilterChip(
                  label: "Food",
                  selected: _activeFilter.theme == TravelConstants.THEME_FOOD,
                  onSelected: (selected) => _updateFilter(
                    theme: selected ? TravelConstants.THEME_FOOD : TravelConstants.THEME_ALL,
                  ),
                ),
                _buildFilterChip(
                  label: "Culture",
                  selected: _activeFilter.theme == TravelConstants.THEME_CULTURE,
                  onSelected: (selected) => _updateFilter(
                    theme: selected ? TravelConstants.THEME_CULTURE : TravelConstants.THEME_ALL,
                  ),
                ),
                _buildFilterChip(
                  label: "Activity",
                  selected: _activeFilter.theme == TravelConstants.THEME_ACTIVITY,
                  onSelected: (selected) => _updateFilter(
                    theme: selected ? TravelConstants.THEME_ACTIVITY : TravelConstants.THEME_ALL,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required Function(bool) onSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: onSelected,
        backgroundColor: Colors.grey[200],
        selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
        tooltip: '$label filter',
      ),
    );
  }

  Widget _buildProductGrid() {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.0,
            mainAxisSpacing: 28,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return _ProductCard(
              product: product,
              isLiked: wishlistProvider.isLiked(product.packageId),
              onLikeToggle: () => wishlistProvider.toggleLike(product.packageId),
              onTap: () => _navigateToDetail(product),
            );
          },
        );
      },
    );
  }

  void _updateFilter({
    int? theme,
  }) {
    setState(() {
      _activeFilter = TravelFilter(theme: theme);
    });
  }

  // void _toggleLike(int productId) {
  //   setState(() {
  //     if (_likedProducts.contains(productId)) {
  //       _likedProducts.remove(productId);
  //     } else {
  //       _likedProducts.add(productId);
  //     }
  //   });
  // }

  Future<void> _navigateToDetail(Product product) async {
    try {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchDetailPage(product: product),
        ),
      );
    } catch (e) {
      debugPrint('Error navigating to detail page: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('상세 페이지를 불러올 수 없습니다'),
          ),
        );
      }
    }
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final bool isLiked;
  final VoidCallback onLikeToggle;
  final VoidCallback onTap;

  const _ProductCard({
    required this.product,
    required this.isLiked,
    required this.onLikeToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          color: BaseColorWhite,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // 이미지 섹션
            SizedBox(
            height: 180,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    product.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 200),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: _LikeButton(
                    isLiked: isLiked,
                    onTap: onLikeToggle,
                  ),
                ),
              ],
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24, left: 20, right: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 280,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(right: 40),
                      child: Text(
                        product.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(right: 40),
                      child: Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          color: BaseColorTaupe
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(right: 40),
                      child: Text(
                        product.keyword,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14,
                            color: BaseColorTaupe,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onTap;

  const _LikeButton({
    required this.isLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.8),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.grey,
            size: 20,
          ),
        ),
      ),
    );
  }
}
