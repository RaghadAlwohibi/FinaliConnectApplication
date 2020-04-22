import 'package:iconnect/core/services/database.dart';
import 'package:iconnect/locator.dart';
import 'package:iconnect/models/ads.dart';
import 'package:iconnect/models/post.dart';

class PostService {
  var database = locator<Database>();

  List<Post> _posts;
  List<Post> _userPosts;
  List<Post> get posts => _posts;
  List<Post> get userPosts => _userPosts;


  Future fetchPosts() async {
    this._posts = await database.fetchPosts();
  }


  Future deletePost(String postId) async {
    await database.deletePost(postId);
    if (this._posts != null) this._posts.removeWhere((p) => p.id == postId);
    if (this._userPosts != null)
      this._userPosts.removeWhere((p) => p.id == postId);
  }

  Future fetchUserPosts() async {
    this._userPosts = await database.fetchUserPosts();
  }

  void likePost(
    String postId,
  ) {
    var isLiked = this
        ._posts
        .firstWhere((p) => p.id == postId)
        .likes
        .contains(database.userId);
    if (isLiked) {
      this
          ._posts
          .firstWhere((p) => p.id == postId)
          .likes
          .remove(database.userId);
    } else {
      this._posts.firstWhere((p) => p.id == postId).likes.add(database.userId);
    }

    database.likePost(postId, !isLiked);
  }
}
