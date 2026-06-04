// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/user/user_api_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

import '../../../domain/models/common/common.dart';
import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';
import 'auth_repository.dart';

class AuthRepositoryFirebase extends AuthRepository {
  AuthRepositoryFirebase({
    required FirestoreService apiStroage,
    fb.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn.instance,
       _apiStroage = apiStroage;

  final fb.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirestoreService _apiStroage;

  User? _user;

  @override
  User? get user => _user;

  @override
  Future<bool> get isAuthenticated async {
    return _user != null;
  }

  Future<void> _initUser(fb.User? firebaseUser) async {
    if (firebaseUser == null) {
      updateAuthenticatedUser(null);
    } else {
      UserFirestoreApiModel? apiModel = await _apiStroage.getUser(
        firebaseUser.uid,
      );
      User? user;
      if (apiModel == null) {
        user = User(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          name: firebaseUser.displayName,
          avatar: firebaseUser.photoURL != null
              ? AppFile(uri: Uri.parse(firebaseUser.photoURL!), name: 'avatar')
              : null,
        );
        UserFirestoreApiModel apiModel = UserFirestoreApiModel(
          id: user.id ?? '',
          email: user.email,
          name: user.name,
          mbtiType: user.mbtiType,
          introduce: user.introduce,
          avatar: user.avatar?.uri.toString(),
          created: DateTime.now(),
          updated: DateTime.now(),
        );
        await _apiStroage.saveUser(apiModel);
      } else {
        user = User(
          id: apiModel.id,
          email: apiModel.email,
          name: apiModel.name,
          mbtiType: apiModel.mbtiType,
          introduce: apiModel.introduce,
          avatar: apiModel.avatar != null
              ? AppFile(uri: Uri.parse(apiModel.avatar ?? ''), name: '')
              : null,
        );
      }
      updateAuthenticatedUser(user);
    }
  }

  @override
  void updateAuthenticatedUser(User? newUser) {
    _user = newUser;
    notifyListeners();
  }

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _initUser(_firebaseAuth.currentUser);
      return const Result.ok(null);
    } on fb.FirebaseAuthException catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await _firebaseAuth.signInWithCredential(credential);
      await _initUser(_firebaseAuth.currentUser);
      return const Result.ok(null);
    } on fb.FirebaseAuthException catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> loginWithWechat() async {
    return Result.error(Exception('Wechat login not implemented'));
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
      updateAuthenticatedUser(null);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
