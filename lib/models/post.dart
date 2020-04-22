import 'package:iconnect/utils/utils.dart';

class Post {
  String id;
  int createdAt;
  String title;
  String userId;
  String body;

  // List<Comment> comments;
  List<String> likes;
  String location;
  String
      imageUrl; //provide an image url from the remote server. I have added local images for test and demonstration purposes.
  PostType type;
  Post(
      {this.id,
      this.createdAt,
      this.body,
      this.userId,
      this.title,
      this.type,
      this.location,
      // this.comments,
      this.imageUrl,
      this.likes});

  factory Post.fromJson(Map<String, dynamic> json) {
    List<dynamic> likesJson = json['likes'];

    var post = Post(
        id: json['id'],
        createdAt: json['createdAt'],
        userId: json['creator'],
        type: PostType.values[json['type']],
        title: json['title'],
        likes: likesJson.map((like) => like.toString()).toList(),
        body: json['body'],
        location: json['location'],
        imageUrl: json['imageUrl']);

    return post;
  }

  static Map<String, dynamic> toJson(Post post) {
    return {
      'id': post.id,
      'createdAt': post.createdAt,
      'creator': post.userId,
      'title': post.title,
      'type': post.type.index,
      'likes': post.likes,
      'location': post.location,
      'body': post.body,
      'imageUrl': post.imageUrl
    };
  }
}

final List<Post> posts = [
  Post(
      id: 'asdasd',
      title: 'Found this airpods',
      // comments: comments,
      body: 'I have found this glasses. Does it belong to anybody?',
      createdAt: DateTime.now().millisecondsSinceEpoch,
      userId: 'asdasd',
      imageUrl: AvailableImages.lostItemImage2,
      likes: [],
      location: 'IT department B blok'),
  Post(
      id: 'asdsad',
      //  comments: comments,
      title: 'Found this ring',
      body: 'I have found this glasses. Does it belong to anybody?',
      createdAt: DateTime.now().millisecondsSinceEpoch,
      userId: 'asdasd',
      imageUrl: AvailableImages.lostItemImage3,
      likes: [],
      location: 'IT department B blok'),
];
enum PostType { LostItem, Normal, Club, Course, Event }

String mapTypeToString(PostType type) {
  if (type == PostType.Club)
    return 'Club';
  else if (type == PostType.Course)
    return 'Course';
  else if (type == PostType.LostItem)
    return 'Lost Item';
  else if (type == PostType.Event)
    return 'Event';
  else
    return '';
}
