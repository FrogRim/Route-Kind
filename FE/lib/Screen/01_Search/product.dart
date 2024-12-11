import 'package:flutter/material.dart';

// Models
class Product {
  final int packageId;  //
  final String title;
  final String description; //
  final String keyword;
  final double price;
  final int duration;
  final int category;   //
  final String imageUrl;  //

  const Product({
    required this.packageId,
    required this.title,
    required this.description,
    required this.keyword,
    required this.price,
    required this.duration,
    required this.category,
    required this.imageUrl,
  });
}

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

// 카테고리 상수 추가
class TravelConstants {
  static const int THEME_ALL = 0;
  static const int THEME_NATURE = 1;
  static const int THEME_CITY = 2;
  static const int THEME_FOOD = 3;
  static const int THEME_CULTURE = 4;
  static const int THEME_ACTIVITY = 5;
}

class TravelFilter {
  final int? theme;

  const TravelFilter({
    this.theme,
  });

  bool matches(int category) {
    if (theme == null || theme == TravelConstants.THEME_ALL) {
      return true;
    }
    return theme == category;
  }
}

final List<Product> productList = [
  Product(
    packageId: 1,
    title: 'Jeju',
    description: '제주의 아름다운 자연을 탐험하세요'
        '\n\n"첫째 날. 가볍게 제주 서쪽 둘러보기"\n'
        '제주시를 시작으로 서귀포로 향하는 일정.'
        '공항 근처에서 고기 국수로 배를 채우고 애월 해안 도로로 달리면, 제주에 왔다는 게 실감 난다.'
        '카멜리아 힐, 오설록 티 뮤지엄 등 주요 관광지도 놓치지 말자.'
        '\n\n"둘째 날. 우도 완전 정복하기"\n'
        '자연이 아름다운 우도를 온전히 즐기는 것만으로 충분한 하루.'
        '여유롭게 우도를 한 바퀴 돌아보자. 바람이 많이 부니 옷은'
        '두둑이 챙기는 걸 추천.'
        '\n',
    keyword: '#국내여행 #힐링여행',
    price: 129.43,
    duration: 2,
    category: TravelConstants.THEME_NATURE,
    imageUrl: 'assets/product/jeju.jpg',
  ),
  Product(
    packageId: 2,
    title: 'Austria',
    description: '호주로 떠나는 여행',
    keyword: '#해외여행 #새로운모험 #새로운사람',
    price: 299.99,
    duration: 3,
    category: TravelConstants.THEME_ACTIVITY,
    imageUrl: 'assets/product/austria.jpg',
  ),
  Product(
    packageId: 3,
    title: 'Estonia',
    description: '눈 내리는 여행길',
    keyword: '#해외여행 #눈덮인도시',
    price: 419.99,
    duration: 7,
    category: TravelConstants.THEME_NATURE,
    imageUrl: 'assets/product/estonia.jpg',
  ),
  Product(
    packageId: 4,
    title: 'French',
    description: '프랑스의 야경을 함께합시다',
    keyword: '#해외여행 #커플여행 #신혼여행',
    price: 322.43,
    duration: 4,
    category: TravelConstants.THEME_CULTURE,
    imageUrl: 'assets/product/french.jpg',
  ),
];

// class Product {
//   final int packageId;  // Changed to camelCase naming convention
//   final int guideId;
//   final String title;
//   final String description;  // Fixed typo
//   final double price;
//   final int duration;
//   final int category;
//   final String imageUrl;
//
//   Product({
//     required this.packageId,
//     required this.guideId,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.duration,
//     required this.category,
//     required this.imageUrl,
//   });
// }
//
// final productList = [  // Changed to camelCase and made non-const due to complex objects
//   Product(
//     packageId: 0000,
//     guideId: 0001,
//     title: 'Austria',
//     description: '가족같은 여행',
//     price: 232.0,
//     duration: 24110405,
//     category: 0011,
//     imageUrl: 'assets/product/austria.jpg',
//   ),
//   Product(
//     packageId: 0001,
//     guideId: 0001,
//     title: 'Estonia',
//     description: '친구같은 여행',
//     price: 422.0,
//     duration: 0,  // Added missing required parameter
//     category: 0,  // Added missing required parameter
//     imageUrl: 'assets/product/estonia.jpg',
//   ),
//   Product(
//     packageId: 0002,
//     guideId: 0002,
//     title: 'French',
//     description: 'I들의 여행',
//     price: 242.0,
//     duration: 0,  // Added missing required parameter
//     category: 0,  // Added missing required parameter
//     imageUrl: 'assets/product/french.jpg',
//   ),
// ];
//
// class ProductRoute {
//   static const splash = '/';
//   static const detailView = '/detailView';
//
//   var namedRoutes = {
//     ProductRoute.splash: (context) => SearchPage(),
//     ProductRoute.detailView: (context) => SearchDetailPage,
//   };
// }