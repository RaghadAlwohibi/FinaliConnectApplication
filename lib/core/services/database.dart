import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iconnect/models/ad_request.dart';
import 'package:iconnect/models/ads.dart';
import 'package:iconnect/models/post.dart';
import 'package:iconnect/models/user.dart';
import 'package:uuid/uuid.dart';

class Database {
  String userId;
  final usersRef = Firestore.instance.collection('users');
  final postRef = Firestore.instance.collection('posts');
  final adRequestsRef = Firestore.instance.collection('Ad_Requests');


  Database({this.userId});

  Future<User> createUserAccount(
      FirebaseUser firebaseUser, String username, String name) async {
    var ref = FirebaseStorage.instance.ref().child('default.jpg');
    var downloadUrl = await ref.getDownloadURL();
    await usersRef.document(firebaseUser.uid).setData({
      'id': firebaseUser.uid,
      'username': username,
      'email': firebaseUser.email,
      'bio': '',
      'isAdmin': false,
      'photo': downloadUrl,
      'name': name
    });

    var doc = await usersRef.document(firebaseUser.uid).get();
    return User.fromJson(doc.data);
  }

  Stream<QuerySnapshot> postsSnapshot() {
    return postRef.snapshots();
  }

  List<Post> convertToPostModel(QuerySnapshot snap) {
    return snap.documents.map((DocumentSnapshot doc) {
      return Post.fromJson(doc.data);
    }).toList();
  }


  Future<List<AdRequest>> getAllAdRequests() async {
    var docsSnap =
        await adRequestsRef.where('state', isEqualTo: 'waiting').getDocuments();
    var list = docsSnap.documents
        .map(((doc) => AdRequest.fromMap(doc.data, doc.documentID)))
        .toList();

    return list;
  }

  Future<List<Post>> fetchPosts() async {
    var snap =
        await postRef.orderBy('createdAt', descending: true).getDocuments();
    return convertToPostModel(snap);
  }


  Future changeAdRequestState(String newState, String id) async {
    await adRequestsRef.document(id).updateData({'state': newState});
  }

  Future<List<Post>> fetchUserPosts() async {
    var snap = await postRef
        .orderBy('createdAt', descending: true)
        .where('creator', isEqualTo: this.userId)
        .getDocuments();
    return convertToPostModel(snap);
  }

  Future<User> getUserInfo(String userId) async {
    var userJson = await usersRef.document(userId).get();
    return User.fromJson(userJson.data);
  }

  Future<String> uploadImage(File file) async {
    var ref = FirebaseStorage.instance.ref().child(Uuid().v4());
    await ref.putFile(file).onComplete;
    return await ref.getDownloadURL();
  }

  Future<void> updateProfileImage(File file) async {
    var url = await uploadImage(file);
    await usersRef.document(userId).updateData({'photo': url});

    return Future.value();
  }

  Future<void> likePost(String postId, bool liked) async {
    if (liked) {
      await postRef.document(postId).updateData({
        'likes': FieldValue.arrayUnion([userId])
      });
    } else {
      await postRef.document(postId).updateData({
        'likes': FieldValue.arrayRemove([userId])
      });
    }
  }

  Future<User> updateUserInfo(data) async {
    await usersRef.document(userId).updateData(data);
    return await getSignedInUserInfo(userId);
  }

  Future<User> getSignedInUserInfo(String id) async {
    var doc = await usersRef.document(id).get();
    if (doc == null || !doc.exists)
      return null;
    else
      return User.fromJson(doc.data);
  }

  Future deletePost(String postId) async {
    await postRef.document(postId).delete();
  }

  Future<void> uploadPost(Post post) async {
    await postRef.document(post.id).setData(Post.toJson(post));
  }
}
