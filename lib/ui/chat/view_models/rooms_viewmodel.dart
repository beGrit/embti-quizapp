import 'package:emombti/app_state/chat_state.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class RoomsViewModel extends ChangeNotifier {
  RoomsViewModel({
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
    required ChatState chatState,
  }) : _authRepository = authRepository,
       _chatRepository = chatRepository,
       _chatState = chatState {
    loadRoomsCommand = Command0<void>(_loadRoomsInternal);
  }

  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;
  final ChatState _chatState;

  late final Command0<void> loadRoomsCommand;

  Future<Result<void>> _loadRoomsInternal() async {
    final user = _authRepository.user;
    if (user == null) {
      return Result.error(Exception('User not authenticated'));
    }

    final result = await _chatRepository.getRooms(user.id ?? '');

    if (result is Ok<List<Room>>) {
      _chatState.setRooms(result.value);
      return Result.ok(null);
    }
    return Result.error((result as Error).error);
  }
}
