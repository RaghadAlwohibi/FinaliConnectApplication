import 'package:iconnect/core/services/post_service.dart';
import 'package:iconnect/core/view_models/base_model.dart';
import 'package:iconnect/locator.dart';
import 'package:iconnect/models/post.dart';

class FeedModel extends BaseModel {
  var postService = locator<PostService>();
  List<Post> get posts => postService.posts;
  List<Post> get userPosts => postService.userPosts;
  Future getPosts() async {
    setState(ModelState.Busy);
    await postService.fetchPosts();
    setState(ModelState.Idle);
  }

  Future deletePost(String postId) async {
    setState(ModelState.Busy);
    await postService.deletePost(postId);
    setState(ModelState.Idle);
  }

  Future getUserPosts() async {
    setState(ModelState.Busy);
    await postService.fetchUserPosts();
    setState(ModelState.Idle);
  }
}
