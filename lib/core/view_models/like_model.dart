import 'package:flutter/cupertino.dart';
import 'package:iconnect/core/services/database.dart';
import 'package:iconnect/core/services/post_service.dart';
import 'package:iconnect/locator.dart';

class LikeModel extends ChangeNotifier {
  var postService = locator<PostService>();

  bool isLiked(String postId) {
    return postService.posts
        .firstWhere((p) => p.id == postId)
        .likes
        .contains(locator<Database>().userId);
  }

  void likePost(
    String postId,
  ) {
    postService.likePost(postId);
    notifyListeners();
  }
}
