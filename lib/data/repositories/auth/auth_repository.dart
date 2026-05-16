// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';

abstract class AuthRepository extends ChangeNotifier {
  /// The currently authenticated user.
  User? get user;

  /// Returns true when the user is logged in
  /// Returns [Future] because it will load a stored auth state the first time.
  Future<bool> get isAuthenticated;

  /// Perform login
  Future<Result<void>> login({required String email, required String password});

  Future<Result<void>> loginWithWechat();

  /// Perform logout
  Future<Result<void>> logout();
}
