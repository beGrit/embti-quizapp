import 'dart:async';

import 'package:emombti/data/services/persistence/api/pocketbase_service.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/result.dart';

import 'chat_repository.dart';

class ChatRepositoryDev implements ChatRepository {
  ChatRepositoryDev({required PocketBaseService pbService})
    : _pbService = pbService;

  final PocketBaseService _pbService;

  @override
  Future<Result<List<Room>>> getRooms(String userId) async {
    try {
      final memberRecords = await _pbService.client
          .collection('room_members')
          .getFullList(filter: 'user_id = "$userId"');

      if (memberRecords.isEmpty) {
        return const Result.ok([]);
      }

      final roomIds = memberRecords
          .map((record) => record.getStringValue('room_id'))
          .where((id) => id.isNotEmpty)
          .toSet()
          .toList();

      if (roomIds.isEmpty) {
        return const Result.ok([]);
      }

      final filterExpression = roomIds.map((id) => 'id = "$id"').join(' || ');

      final roomRecords = await _pbService.client
          .collection('rooms')
          .getFullList(filter: filterExpression);

      final rooms = roomRecords
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
          .getFullList(filter: 'room_id = "$roomId"', sort: '-created');
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

      body.remove('id');
      body.remove('created');
      body.remove('updated');

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
      if (e.action == 'create') {
        final message = Message.fromJson(e.record!.toJson());
        if (message.roomId == roomId) {
          controller.add(message);
        }
      }
    }, filter: 'room_id = "$roomId"');

    controller.onCancel = () {
      _pbService.client.collection('messages').unsubscribe('*');
    };

    return controller.stream;
  }

  @override
  Stream<Message> subscribeToMessagesInUserScope(String userId) {
    final controller = StreamController<Message>();

    _pbService.client.collection('messages').subscribe('*', (e) {
      if (e.action == 'create') {
        final message = Message.fromJson(e.record!.toJson());
        controller.add(message);
      }
    }, filter: 'room_id.room_members_via_room_id.user_id ?= "$userId"');

    controller.onCancel = () {
      _pbService.client.collection('messages').unsubscribe('*');
    };

    return controller.stream;
  }
}
