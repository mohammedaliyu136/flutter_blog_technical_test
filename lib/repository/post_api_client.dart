import 'package:flutter_blog_tech_test/post/model/post.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PostAPIClient{
  Future<List<Post>> fetchPosts() async {
    final response =
    await http.get(Uri.https('60585b2ec3f49200173adcec.mockapi.io', '/api/v1/blogs'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Post> posts = List<Post>.from(l.map((model)=> Post.fromJson(model)));
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> fetchPost(Post post) async {
    final response =
    await http.get(Uri.https('60585b2ec3f49200173adcec.mockapi.io', '/api/v1/blogs/${post.id}', ));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  login(email, password) async {
    final response =
    await http.post(Uri.http('60585b2ec3f49200173adcec.mockapi.io', '/api/v1/login/'),
        body: jsonEncode(<String, String>{
          'email': email,
          'password':password
        }),
    );


    if (response.statusCode == 201) {
      return jsonDecode(response.body)["token"];
    } else {
      throw Exception('Failed to load postkkk');
    }
  }
}