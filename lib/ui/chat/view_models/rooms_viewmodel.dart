import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class RoomsViewModel extends ChangeNotifier {
  RoomsViewModel({
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
  }) : _authRepository = authRepository,
       _chatRepository = chatRepository;

  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;

  List<Room> _rooms = [];
  List<Room> get rooms => _rooms;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadRooms() async {
    final user = _authRepository.user;
    if (user == null) {
      _errorMessage = 'User not authenticated';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _chatRepository.getRooms(user.id);

    switch (result) {
      case Ok<List<Room>>():
        _rooms = result.value;
      case Error<List<Room>>():
        _errorMessage = result.error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
