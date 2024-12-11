import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiData {
  final String package_id;
  final String title;
  final int keyword;
  final int price;
  final int duration;

  ApiData({
    required this.package_id,
    required this.title,
    required this.keyword,
    required this.price,
    required this.duration,
  });

  // Factory method to create an ApiData object from JSON
  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      package_id: json['package_id'],
      title: json['title'],
      keyword: json['keyword'],
      price: json['price'],
      duration: json['duration'],
    );
  }
}

// //getData 함수
// Future<ApiData?> getData(String itemData) async {
//   // 기본 URL
//   var url = Uri.parse('http://222.96.204.41:8000/drug-info/?item_name=');
//
//   // URL에 itemData 추가
//   var completeUrl = Uri.parse('${url.toString()}$itemData');
//
//   try {
//     // API 요청: GET 메서드로 itemName 전송
//     var response = await http.get(completeUrl);
//
//     if (response.statusCode == 200) {
//       // 응답 성공: JSON 데이터를 ApiData 객체로 변환
//       var decodedBody = utf8.decode(response.bodyBytes);
//       var data = jsonDecode(decodedBody);
//       print(response.body);
//       return ApiData.fromJson(data);
//
//     } else {
//       print('Failed to load data. Status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error occurred: $e');
//   }
//   return null; // 실패 시 null 반환
// }


Future<List<ApiData>> fetchRecommendations(String binaryString) async {
  final String serverUrl = 'http://172.28.0.12:5000/recommend';

  final response = await http.post(
    Uri.parse(serverUrl),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"binary_string": binaryString}),
  );

  if (response.statusCode == 200) {
    // JSON 배열을 ApiData 객체 리스트로 변환
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => ApiData.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch recommendations');
  }
}

