import 'dart:async';

import 'package:emombti/data/services/pocketbase/pocketbase_service.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/result.dart';

import 'chat_repository.dart';

/// [ChatRepository] implementation using PocketBase.
class ChatRepositoryDev implements ChatRepository {
  ChatRepositoryDev({required PocketBaseService pbService})
    : _pbService = pbService;

  final PocketBaseService _pbService;

  @override
  Future<Result<List<Room>>> getRooms(String userId) async {
    try {
      final records = await _pbService.client
          .collection('rooms')
          .getFullList(filter: 'room_members_via_room_id.user_id = "$userId"');
      final rooms = records
          .map((record) => Room.fromJson(record.toJson()))
          .toList();
      return Result.ok(rooms);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<Room>> getRoomById(String id) async {
    try {
      final record = await _pbService.client.collection('rooms').getOne(id);
      return Result.ok(Room.fromJson(record.toJson()));
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Room>>> getRoomsPaginated({
    required String userId,
    required int page,
    required int perPage,
  }) async {
    try {
      // Fetches a paginated list of rooms.
      // Expands room members (with user details) and messages.
      final result = await _pbService.client
          .collection('rooms')
          .getList(
            page: page,
            perPage: perPage,
            sort: '-updated',
            filter: 'room_members_via_room_id.user_id = "$userId"',
            expand: 'room_members_via_room_id.user_id,messages_via_room_id',
          );
      final rooms = result.items
          .map((record) => Room.fromJson(record.toJson()))
          .toList();
      return Result.ok(rooms);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<Message?>> getLatestMessageForRoom(String roomId) async {
    try {
      final result = await _pbService.client
          .collection('messages')
          .getList(
            page: 1,
            perPage: 1,
            filter: 'room_id = "$roomId"',
            sort: '-created',
          );
      if (result.items.isEmpty) {
        return const Result.ok(null);
      }
      return Result.ok(Message.fromJson(result.items.first.toJson()));
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<RoomMember>>> getRoomMembers(String roomId) async {
    try {
      final records = await _pbService.client
          .collection('room_members')
          .getFullList(filter: 'room_id = "$roomId"', expand: 'user_id');
      final members = records
          .map((record) => RoomMember.fromJson(record.toJson()))
          .toList();
      return Result.ok(members);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Message>>> getMessages(String roomId) async {
    try {
      final records = await _pbService.client
          .collection('messages')
          .getFullList(filter: 'room_id = "$roomId"', sort: 'created');
      final messages = records
          .map((record) => Message.fromJson(record.toJson()))
          .toList();
      return Result.ok(messages);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<Message>> sendMessage(Message message) async {
    try {
      final Map<String, dynamic> body = message.toJson();

      // Remove system-managed fields to let PocketBase generate them
      body.remove('id');
      body.remove('created');
      body.remove('updated');

      // Ensure necessary fields like createdAt are populated
      body['createdAt'] ??= DateTime.now().toIso8601String();

      final record = await _pbService.client
          .collection('messages')
          .create(body: body);
      return Result.ok(Message.fromJson(record.toJson()));
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Stream<Message> subscribeToMessages(String roomId) {
    final controller = StreamController<Message>();

    _pbService.client.collection('messages').subscribe('*', (e) {
      if (e.action == 'create' && e.record != null) {
        final message = Message.fromJson(e.record!.toJson());
        if (message.roomId == roomId) {
          controller.add(message);
        }
      }
    });

    controller.onCancel = () {
      _pbService.client.collection('messages').unsubscribe('*');
    };

    return controller.stream;
  }
}
