import 'package:iconnect/core/services/post_service.dart';
import 'package:iconnect/core/view_models/base_model.dart';
import 'package:iconnect/locator.dart';
import 'package:iconnect/models/post.dart';

class LostItemModel extends BaseModel {
  var postService = locator<PostService>();
  List<Post> get lostItems =>
      postService.posts.where((p) => p.type == PostType.LostItem).toList();

  Future getLostItems() async {
    setState(ModelState.Busy);
    await postService.fetchPosts();
    setState(ModelState.Idle);
  }
}
