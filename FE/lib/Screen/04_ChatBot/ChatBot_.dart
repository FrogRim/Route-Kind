// import 'package:flutter/material.dart';
//
// import 'package:dart_findy/Constant/Constants.dart';
// import './response_option.dart';
//
//
// class ChatBotPage extends StatefulWidget {
//   @override
//   State<ChatBotPage> createState() => _ChatBotPage();
// }
//
// class _ChatBotPage extends State<ChatBotPage> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController(); // ScrollController 추가
//
//   List<Map<String, dynamic>> messages = [
//     {'sender': 'bot', 'text': '무엇을 도와드릴까요?'}
//   ];
//
//   // 현재 선택지
//   List<String> responseOptions = [];
//
//   // 선택된 라벨 임시 저장 리스트
//   List<String> selectedLabels = [];
//
//   @override
//   void initState() {
//     super.initState();
//     responseOptions = ResponseOptions.initialOptions;
//   }
//
//   void _handleUserInput(String text) {
//     setState(() {
//       messages.add({'sender': 'user', 'text': text});
//
//       // 선택된 답변에 따라 새로운 선택지 제공
//       Map<String, dynamic> responseData = ResponseOptions.getResponseAndLabels(text);
//       selectedLabels.add(responseData['label']);
//       responseOptions = List<String>.from(responseData['options']);
//       messages.add({'sender': 'bot', 'text': responseData['response']});
//
//       // 만약 최종 선택이 끝난 경우 추천 메시지를 생성 (여기서는 추천 알고리즘 연결 가능)
//       if (responseOptions.isEmpty) {
//         //var apiData = await getData(name);
//         messages.add({
//           'sender': 'bot',
//           'text': '여행지 추천',
//           'widget': SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 _buildDestinationCard(
//                     '제주도',
//                     'https://media.istockphoto.com/id/579410588/ko/%EC%82%AC%EC%A7%84/%EC%A0%9C%EC%A3%BC%EB%A5%BC-%EB%8F%84%EC%84%9C%EC%A7%80%EC%97%AD.jpg?s=612x612&w=is&k=20&c=Vx4JwsR4j-IMLMGylQXw7_BrvRadMjDhZVwY1geEjy4=',
//                     ['자연', '힐링', '액티비티'],
//                     35,  // 35만원
//                     4    // 4일 여행
//                 ),
//               ],
//             ),
//           )
//         });
//         // messages.add({
//         //   'sender': 'bot',
//         //   'text': '"여행지 추천"'
//         // });
//         // 선택한 모든 라벨들 출력 (추천 알고리즘과 연동될 예정)
//         print('Selected Labels: $selectedLabels');
//       }
//     });
//
//     _scrollToBottom(); // 메시지를 추가한 후 스크롤을 아래로 이동
//   }
//
//   Widget _buildDestinationCard(String name, String imageUrl, List<String> keywords, double price, int days) {
//     return Container(
//       width: 330,
//       height: 220,
//       margin: EdgeInsets.fromLTRB(60, 10, 10, 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           )
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Stack(
//           children: [
//             // 배경 이미지
//             Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//             ),
//
//             // 그라데이션 오버레이
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.transparent,
//                       Colors.black.withOpacity(0.8),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             // 하단 정보 영역
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // 여행지 이름
//                     Text(
//                       name,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         shadows: [
//                           Shadow(
//                             blurRadius: 10,
//                             color: Colors.black,
//                             offset: Offset(1, 1),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 8),
//
//                     // 키워드 칩
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 4,
//                       children: keywords.map((keyword) =>
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.2),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(
//                               keyword,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10,
//                               ),
//                             ),
//                           )
//                       ).toList(),
//                     ),
//                     SizedBox(height: 12),
//
//                     // 가격 및 기간 정보
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // 가격 정보
//                         Row(
//                           children: [
//                             Icon(Icons.attach_money, color: Colors.greenAccent, size: 18),
//                             Text(
//                               '${price.toStringAsFixed(0)}만원',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         // 여행 기간
//                         Row(
//                           children: [
//                             Icon(Icons.calendar_today, color: Colors.white, size: 16),
//                             SizedBox(width: 5),
//                             Text(
//                               '$days일',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 3000),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   void _resetChat() {
//     setState(() {
//       messages = [
//         {'sender': 'bot', 'text': '무엇을 도와드릴까요?'}
//       ];
//       responseOptions = ResponseOptions.initialOptions;
//       selectedLabels.clear();
//     });
//     _scrollToBottom();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Route&Kind Chatbot'),
//       // ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Chat(messages: messages, scrollController: _scrollController),
//               Divider(height: 0.3),
//               if (responseOptions.isNotEmpty)
//                 Expanded(
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Answer(
//                       responseOptions: responseOptions,
//                       onOptionSelected: _handleUserInput,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           if (responseOptions.isEmpty)
//             Positioned(
//               bottom: 65,
//               right: 16,
//               child: FloatingActionButton(
//                 onPressed: _resetChat,
//                 child: Icon(Icons.refresh, color: BaseColorWhite),
//                 backgroundColor: BaseColorCharcoal,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class Chat extends StatelessWidget {
//   const Chat({super.key, required this.messages, required this.scrollController});
//   final List<Map<String, dynamic>> messages; // dynamic으로 변경
//   final ScrollController scrollController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.675,
//       padding: EdgeInsets.fromLTRB(2, 12, 2, 0),
//       decoration: Style.chatContainerDecoration,
//       margin: EdgeInsets.fromLTRB(2, 12, 2, 0),
//       child: ListView.builder(
//         controller: scrollController,
//         reverse: false,
//         itemCount: messages.length,
//         itemBuilder: (context, index) {
//           final message = messages[index];
//           bool isUserMessage = message['sender'] == 'user';
//
//           // 위젯이 있는 경우 위젯 렌더링
//           if (message.containsKey('widget')) {
//             return Padding(
//               padding: EdgeInsets.all(8.0),
//               child: message['widget'],
//             );
//           }
//
//           return Container(
//             margin: Style.messageMargin,
//             alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
//             child: Row(
//               mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
//               children: [
//                 if (!isUserMessage) ...[
//                   CircleAvatar(
//                     child: Icon(Icons.android),
//                     backgroundColor: Colors.grey[300],
//                   ),
//                   SizedBox(width: 20),
//                 ],
//                 Flexible(
//                   child: Container(
//                     padding: Style.paddingAll12,
//                     decoration: BoxDecoration(
//                       color: isUserMessage ? Colors.blueAccent : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       message['text']!,
//                       style: TextStyle(
//                         color: isUserMessage ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (isUserMessage) ...[
//                   SizedBox(width: 8),
//                   CircleAvatar(
//                     child: Icon(Icons.person),
//                     backgroundColor: Colors.blueAccent,
//                   ),
//                 ],
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class Answer extends StatelessWidget {
//   const Answer({
//     super.key,
//     required this.responseOptions,
//     required this.onOptionSelected,
//   });
//
//   final List<String> responseOptions;
//   final Function(String) onOptionSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: GridView.count(
//         shrinkWrap: true,
//         crossAxisCount: 3,
//         children: responseOptions.map((option) {
//           return Container(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 shape: BeveledRectangleBorder(),
//                 backgroundColor: (responseOptions.indexOf(option) % 2 == 0)
//                     ? Color(0xfffCCC4B2)
//                     : Color(0xfffB5AE9E),
//               ),
//               onPressed: () => onOptionSelected(option),
//               child: Text(
//                 option,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }