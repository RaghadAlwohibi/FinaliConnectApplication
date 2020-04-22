import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:iconnect/core/services/database.dart';
import 'package:iconnect/locator.dart';
import 'package:iconnect/models/auth_result.dart';
import 'package:iconnect/models/user.dart';

class Auth extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User currentUser;

  Future<User> trySignIn() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      setupDatbaseSingleton(user.uid);
      currentUser = await locator<Database>().getSignedInUserInfo(user.uid);
      if (currentUser == null) {
        unregisterDatabase();
      }
      return currentUser;
    }
    return null;
  }

  Future updatePhoto(File f) async {
    await locator<Database>().updateProfileImage(f);
    currentUser = await locator<Database>().getSignedInUserInfo(currentUser.id);
    notifyListeners();
  }

  Future<Map<String, Object>> registerWithAccount(
      String name, String email, String password, String username) async {
    AuthResult result;
    Map<String, Object> mapResult = {};
    try {
      result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      setupDatbaseSingleton(result.user.uid);
      currentUser = await locator<Database>()
          .createUserAccount(result.user, username, name);

      mapResult['result'] = true;
      mapResult['message'] = 'Success';
      mapResult['isAdmin'] = currentUser.isAdmin;
    } on PlatformException catch (error) {
      var errorMessage;
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "Your password is weak.";
          break;

        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "An account with this email already exists.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      mapResult['result'] = false;
      mapResult['message'] = errorMessage;
    }
    //notifyListeners();
    return mapResult;
  }

  Future<Map<String, Object>> signInWithAccount(
      String email, String password) async {
    Map<String, Object> mapResult = {};
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      setupDatbaseSingleton(result.user.uid);

      currentUser =
          await locator<Database>().getSignedInUserInfo(result.user.uid);

      mapResult['result'] = true;
      mapResult['message'] = 'Success';
      mapResult['isAdmin'] = currentUser.isAdmin;
    } on PlatformException catch (error) {
      String errorMessage;
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      mapResult['result'] = false;
      mapResult['message'] = errorMessage;
    }
    //notifyListeners();
    return mapResult;
  }

  Future signOut() async {
    removeDatabaseSingleton();

    await _auth.signOut();

    //notifyListeners();
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<CustomAuthResult> updateUserInfo(
      String name,
      String username,
      String newEmail,
      String newPassword,
      String bio,
      String oldPassword,
      String major) async {
    Map<String, String> dataToUpdate = {
      'name': name,
      'username': username,
      'bio': bio,
      'major': major,
    };

    if (newEmail.isNotEmpty || newPassword.isNotEmpty) {
      var user = await _auth.currentUser();

      var result = await user.reauthenticateWithCredential(
          EmailAuthProvider.getCredential(
              email: user.email, password: oldPassword));
      var newUser = result.user;
      if (newUser == null) {
        //failed
        return CustomAuthResult(
            result: false,
            message: 'Invalid credentials. Please check your information.');
      } else {
        if (newEmail.isNotEmpty) {
          var result = await updateEmail(newEmail);
          if (!result.result)
            return result;
          else
            dataToUpdate.putIfAbsent('email', () => newEmail);
        }
        if (newPassword.isNotEmpty) {
          var result = await updatePassword(newPassword);
          if (!result.result)
            return result;
          else
            dataToUpdate.putIfAbsent('password', () => newPassword);
        }
      }
    }

    currentUser = await locator<Database>().updateUserInfo(dataToUpdate);
    notifyListeners();
    return CustomAuthResult(result: true, message: 'Information updated.');
  }

  Future<CustomAuthResult> updateEmail(String newEmail) async {
    try {
      var user = await _auth.currentUser();
      await user.updateEmail(newEmail);
      return CustomAuthResult(message: 'success', result: true);
    } on PlatformException catch (error) {
      var result = CustomAuthResult(result: false);
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          result.message = "User with this email doesn't exist.";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          result.message = "An account with this email already exists.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          result.message = "Signing in with Email and Password is not enabled.";
          break;
        default:
          result.message = "An undefined Error happened.";
      }
      return result;
    }
  }

  Future<CustomAuthResult> updatePassword(String newPassword) async {
    try {
      var user = await _auth.currentUser();
      await user.updatePassword(newPassword);
      return CustomAuthResult(message: 'success', result: true);
    } on PlatformException catch (error) {
      var result = CustomAuthResult(result: false);
      if (error.code == 'ERROR_WEAK_PASSWORD') {
        result.message = 'Password is weak';
      } else {
        result.message = 'Password is invalid';
      }
      return result;
    }
  }
}
