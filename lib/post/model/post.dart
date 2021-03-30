class Post{
  String id;
  String createdAt;
  String title;
  String imageUrl;

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = json['createdAt'],
        title = json['title'],
        imageUrl = json['imageUrl'];
}