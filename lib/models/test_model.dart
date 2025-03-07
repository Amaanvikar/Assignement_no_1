import 'package:assignment/common/api_helper.dart';
import 'package:flutter/material.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  // Factory constructor to create an instance from a JSON map
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  // Method to convert the object back to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

class ApiTestPage extends StatefulWidget {
  @override
  _ApiTestPageState createState() => _ApiTestPageState();
}

class _ApiTestPageState extends State<ApiTestPage> {
  // Variable to hold the fetched post data
  List<dynamic> posts = [];

  // Function to fetch post data
  Future<void> fetchPostData() async {
    Map<String, dynamic>? response =
        await ApiHelper.getRequest("/posts", params: {"userId": "1"});

    if (response != null) {
      // Check if the response contains the expected data
      print("Post data fetched successfully:");
      print(response);

      // If the response contains an array of posts, update the state
      if (response is List && response.isNotEmpty) {
        setState(() {
          posts = response['data'];
        });
      }
    } else {
      print("Failed to fetch post data.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fetchPostData,
              child: Text("Fetch Post Data"),
            ),
            // Displaying the posts in a ListView
            if (posts.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return Card(
                      child: ListTile(
                        title: Text(post['title']),
                        subtitle: Text(post['body']),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
