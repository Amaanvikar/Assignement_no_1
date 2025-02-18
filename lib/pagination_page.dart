// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class _PaginationPagState extends StatefulWidget {
//   const _PaginationPagState({super.key});

//   @override
//   State<_PaginationPagState> createState() => __PaginationPagStateState();
// }

// class __PaginationPagStateState extends State<_PaginationPagState> {
//   List posts = [];
//   @override
//   void initState() {
//     super.initState();
//     fetchPost();
//   }

//   Future<void> fetchPost() async {
//     var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

//     try {
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body) as List;
//         setState(() {
//           posts = json;
//         });
//         print('Response Data: $json');
//       } else {
//         print('Response failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FetchPost'),
//       ),
//       body: ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           final id = posts[index];
//           final title = post['title'];
//           final body = post['body'];
//           return ListTile(
//             title: Text('$title'),
//             subtitle: Text('$body'),
//           );
//         },
//       ),
//     );
//   }
// }
