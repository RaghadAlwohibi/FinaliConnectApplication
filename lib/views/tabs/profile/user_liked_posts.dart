import 'package:flutter/material.dart';
import 'package:iconnect/models/post.dart';
import 'package:iconnect/views/tabs/search/course/course_post.dart';

class UserLikedPosts extends StatelessWidget {
  final List<Post> posts;
  UserLikedPosts({this.posts});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (ctx, index) {
          return GenericPost(
            post: posts[index],
          );
        });
  }
}
