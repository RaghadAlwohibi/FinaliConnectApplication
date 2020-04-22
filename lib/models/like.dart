class Like {
  String userId;
  bool liked;

  Like({this.liked, this.userId});

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(liked: json['liked'], userId: json['userId']);
  }
}
