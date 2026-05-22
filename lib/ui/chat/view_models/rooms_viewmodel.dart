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
  }) : _authRepository = authRepository,
       _chatRepository = chatRepository {
    loadRoomsCommand = Command0<List<Room>>(_loadRoomsInternal);
  }

  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;

  List<Room> _rooms = [];
  List<Room> get rooms => _rooms;

  late final Command0<List<Room>> loadRoomsCommand;

  Future<Result<List<Room>>> _loadRoomsInternal() async {
    final user = _authRepository.user;
    if (user == null) {
      return Result.error(Exception('User not authenticated'));
    }

    final result = await _chatRepository.getRooms(user.id ?? '');

    if (result is Ok<List<Room>>) {
      _rooms = result.value;
    }
    return result;
  }
}
