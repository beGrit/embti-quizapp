import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emombti/data/services/persistence/api/model/chat/chat_api_model.dart';
import 'package:emombti/data/services/persistence/api/model/quiz/quiz_api_model.dart';

import 'model/social/social_meta_api_model.dart';
import 'model/user/user_api_model.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  String generateFirestoreId() {
    return _firestore.collection('any_collection').doc().id;
  }

  CollectionReference<Map<String, dynamic>> get _socialMetas =>
      _firestore.collection('social_metas');

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  CollectionReference<Map<String, dynamic>> _userSurveyFlows(String userId) =>
      _users.doc(userId).collection('survey_flows');

  CollectionReference<Map<String, dynamic>> get _chats =>
      _firestore.collection('chats');

  CollectionReference<Map<String, dynamic>> _userChats(String userId) =>
      _users.doc(userId).collection('chats');

  CollectionReference<Map<String, dynamic>> _chatMessages(String chatId) =>
      _chats.doc(chatId).collection('messages');

  CollectionReference<Map<String, dynamic>> _userRobot(String userId) =>
      _users.doc(userId).collection('robots');

  /// Save or update user profile data at /users/{uid}
  Future<UserFirestoreApiModel> saveUser(UserFirestoreApiModel user) async {
    final docRef = _users.doc(user.id);
    await docRef.set(
      user.toJson()..removeWhere((key, value) => value == null),
      SetOptions(merge: true),
    );
    return user;
  }

  /// Search users by name or email keyword.
  Future<List<UserFirestoreApiModel>> searchUsers(
    String keyword, {
    int limit = 20,
    String? excludeUserId,
  }) async {
    final query = keyword.trim();
    if (query.isEmpty) {
      return [];
    }

    final lowerQuery = query.toLowerCase();
    final end = '$query\uf8ff';
    final candidates = <String, UserFirestoreApiModel>{};

    Future<void> addFromQuery(
      Query<Map<String, dynamic>> firestoreQuery,
    ) async {
      final snapshot = await firestoreQuery.limit(limit).get();
      for (final doc in snapshot.docs) {
        if (excludeUserId != null && doc.id == excludeUserId) {
          continue;
        }

        try {
          candidates[doc.id] = UserFirestoreApiModel.fromJson({
            ...doc.data(),
            'id': doc.id,
          });
        } catch (_) {}
      }
    }

    await Future.wait([
      addFromQuery(
        _users
            .where('name', isGreaterThanOrEqualTo: query)
            .where('name', isLessThanOrEqualTo: end),
      ),
      addFromQuery(
        _users
            .where('email', isGreaterThanOrEqualTo: query)
            .where('email', isLessThanOrEqualTo: end),
      ),
    ]);

    return candidates.values
        .where((user) {
          final name = user.name?.toLowerCase() ?? '';
          final email = user.email?.toLowerCase() ?? '';
          return name.contains(lowerQuery) || email.contains(lowerQuery);
        })
        .take(limit)
        .toList();
  }

  /// Fetch user profile data from /users/{uid}
  Future<UserFirestoreApiModel?> getUser(String uid) async {
    final snapshot = await _users.doc(uid).get();
    final data = snapshot.data();

    if (!snapshot.exists || data == null) {
      return null;
    }

    try {
      final apiModel = UserFirestoreApiModel.fromJson(data);
      return apiModel;
    } catch (_) {
      return null;
    }
  }

  /// Get social meta by related ID (e.g., PocketBase post ID)
  Future<SocialMetaApiModel?> getSocialMetaByRelatedId(String relatedId) async {
    final query = await _socialMetas
        .where('relatedId', isEqualTo: relatedId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return SocialMetaApiModel.fromJson(doc.data()).copyWith(id: doc.id);
  }

  /// Create a new social meta for a related ID
  Future<SocialMetaApiModel> createSocialMeta(String relatedId) async {
    final docRef = _socialMetas.doc();
    final now = DateTime.now();

    final socialMeta = SocialMetaApiModel(
      relatedId: relatedId,
      metrics: const SocialMetricsApiModel(),
      created: now,
      updated: now,
    );

    final data = socialMeta.toJson();
    // Use server timestamps for accuracy
    data['created'] = FieldValue.serverTimestamp();
    data['updated'] = FieldValue.serverTimestamp();

    await docRef.set(data);

    return socialMeta.copyWith(id: docRef.id);
  }

  /// Toggle like status for a user
  Future<void> toggleLike({
    required String socialMetaId,
    required String userId,
    required bool shouldLike,
  }) async {
    final docRef = _socialMetas.doc(socialMetaId);
    final likeRef = docRef.collection('likes').doc(userId);

    await _firestore.runTransaction((transaction) async {
      final likeSnapshot = await transaction.get(likeRef);
      final exists = likeSnapshot.exists;

      if (shouldLike && !exists) {
        transaction.set(likeRef, {
          'userId': userId,
          'created': FieldValue.serverTimestamp(),
        });
        transaction.update(docRef, {
          'metrics.likes': FieldValue.increment(1),
          'updated': FieldValue.serverTimestamp(),
        });
      } else if (!shouldLike && exists) {
        transaction.delete(likeRef);
        transaction.update(docRef, {
          'metrics.likes': FieldValue.increment(-1),
          'updated': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  /// Toggle favorite status for a user
  Future<void> toggleFavorite({
    required String socialMetaId,
    required String userId,
    required bool shouldFavorite,
  }) async {
    final docRef = _socialMetas.doc(socialMetaId);
    final favRef = docRef.collection('favorites').doc(userId);

    await _firestore.runTransaction((transaction) async {
      final favSnapshot = await transaction.get(favRef);
      final exists = favSnapshot.exists;

      if (shouldFavorite && !exists) {
        transaction.set(favRef, {
          'userId': userId,
          'created': FieldValue.serverTimestamp(),
        });
        transaction.update(docRef, {
          'metrics.favorites': FieldValue.increment(1),
          'updated': FieldValue.serverTimestamp(),
        });
      } else if (!shouldFavorite && exists) {
        transaction.delete(favRef);
        transaction.update(docRef, {
          'metrics.favorites': FieldValue.increment(-1),
          'updated': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  /// Add a comment
  Future<CommentApiModel> addComment({
    required String socialMetaId,
    required CommentApiModel comment,
  }) async {
    final docRef = _socialMetas.doc(socialMetaId);
    final commentRef = docRef.collection('comments').doc();

    final data = comment.toJson();
    data['createdAt'] = FieldValue.serverTimestamp();

    await _firestore.runTransaction((transaction) async {
      transaction.set(commentRef, data);
      transaction.update(docRef, {
        'metrics.comments': FieldValue.increment(1),
        'updated': FieldValue.serverTimestamp(),
      });
    });

    return comment.copyWith(id: commentRef.id);
  }

  /// Get comments for a social meta
  Future<List<CommentApiModel>> getComments(String socialMetaId) async {
    final query = await _socialMetas
        .doc(socialMetaId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs
        .map((doc) => CommentApiModel.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  /// Get comments for a social meta using pagination (Cursor-based)
  ///
  /// Pass [lastDocument] from the previous page's result to load the next page.
  /// If [lastDocument] is null, it fetches the very first page.
  Future<({List<CommentApiModel> comments, DocumentSnapshot? lastDocument})>
  getCommentsByPage({
    required String socialMetaId,
    required int limit,
    DocumentSnapshot? lastDocument,
  }) async {
    // 1. Build the base query ordered by creation time
    var query = _socialMetas
        .doc(socialMetaId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .limit(limit);

    // 2. If a cursor document exists, instruct the query to start after it
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    // 3. Fetch the documents from Firestore
    final querySnapshot = await query.get();

    // 4. Map snapshots to your data model
    final comments = querySnapshot.docs.map((doc) {
      return CommentApiModel.fromJson(doc.data()).copyWith(id: doc.id);
    }).toList();

    // 5. Identify the new cursor document (last item fetched) to pass back to the UI
    final newLastDocument = querySnapshot.docs.isNotEmpty
        ? querySnapshot.docs.last
        : null;

    // Returns a Dart Record containing both the models and the cursor snapshot
    return (comments: comments, lastDocument: newLastDocument);
  }

  /// Check user interaction status
  Future<Map<String, bool>> getUserStatus({
    required String socialMetaId,
    required String userId,
  }) async {
    final docRef = _socialMetas.doc(socialMetaId);

    final results = await Future.wait([
      docRef.collection('likes').doc(userId).get(),
      docRef.collection('favorites').doc(userId).get(),
    ]);

    return {'isLiked': results[0].exists, 'isFavorited': results[1].exists};
  }

  Future<void> saveSurveyFlow(
    String userId,
    SurveyFlowApiModel surveyFlow,
  ) async {
    try {
      if (surveyFlow.id == null) {
        surveyFlow = surveyFlow.copyWith(id: generateFirestoreId());
      }

      final DocumentReference docRef = _userSurveyFlows(
        userId,
      ).doc(surveyFlow.id);

      await _firestore.runTransaction((transaction) async {
        transaction.set(docRef, surveyFlow.toJson(), SetOptions(merge: true));
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<SurveyFlowApiModel?> getSurveyFlow(
    String userId,
    String flowId,
  ) async {
    final doc = await _userSurveyFlows(userId).doc(flowId).get();
    if (!doc.exists || doc.data() == null) return null;
    final model = SurveyFlowApiModel.fromJson(doc.data()!);
    if (model.deleted == true) return null;
    return model;
  }

  Future<List<SurveyFlowApiModel>> getSurveyFlows(String userId) async {
    final query = await _userSurveyFlows(
      userId,
    ).where('deleted', isNotEqualTo: true).get();
    return query.docs
        .map((doc) => SurveyFlowApiModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> deleteSurveyFlow(String userId, String flowId) async {
    final DocumentReference docRef = _userSurveyFlows(userId).doc(flowId);

    await _firestore.runTransaction((transaction) async {
      transaction.update(docRef, {'deleted': true});
    });
  }

  Future<void> saveAssessmentResult(
    String userId,
    String surveyFlowId,
    AssessmentResultApiModel result,
  ) async {
    try {
      final DocumentReference docRef = _userSurveyFlows(
        userId,
      ).doc(surveyFlowId).collection('contents').doc('result');

      await _firestore.runTransaction((transaction) async {
        transaction.set(docRef, result.toJson());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<AssessmentResultApiModel?> getAssessmentResult(
    String userId,
    String surveyFlowId,
  ) async {
    final doc = await _userSurveyFlows(
      userId,
    ).doc(surveyFlowId).collection('contents').doc('result').get();
    if (!doc.exists || doc.data() == null) return null;
    return AssessmentResultApiModel.fromJson(doc.data()!);
  }

  Future<List<AssessmentResultApiModel>> getAllAssessmentResults(
    String userId,
  ) async {
    final flows = await getSurveyFlows(userId);
    final results = await Future.wait(
      flows.map((flow) => getAssessmentResult(userId, flow.id!)),
    );
    return results.whereType<AssessmentResultApiModel>().toList();
  }

  UserChatFirestoreApiModel _parseUserChatDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = Map<String, dynamic>.from(doc.data() ?? {});
    data.putIfAbsent('chatId', () => doc.id);
    return UserChatFirestoreApiModel.fromJson(data);
  }

  ChatFirestoreApiModel _parseChatDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = Map<String, dynamic>.from(doc.data() ?? {});
    data.putIfAbsent('chatId', () => doc.id);
    return ChatFirestoreApiModel.fromJson(data);
  }

  ChatMessageFirestoreApiModel _parseMessageDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = Map<String, dynamic>.from(doc.data() ?? {});
    data.putIfAbsent('messageId', () => doc.id);
    return ChatMessageFirestoreApiModel.fromJson(data).copyWith(id: doc.id);
  }

  /// Fetch all chat metadata for a user from /users/{userId}/chats.
  Future<List<UserChatFirestoreApiModel>> getUserChats(String userId) async {
    final query = await _userChats(userId).get();
    return query.docs.map(_parseUserChatDoc).toList();
  }

  /// Paginate chat metadata for a user ordered by latest activity.
  Future<
    ({List<UserChatFirestoreApiModel> chats, DocumentSnapshot? lastDocument})
  >
  getUserChatsPaginated({
    required String userId,
    required int limit,
    DocumentSnapshot? lastDocument,
  }) async {
    var query = _userChats(
      userId,
    ).orderBy('lastMessageSentAt', descending: true).limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    final chats = querySnapshot.docs.map(_parseUserChatDoc).toList();
    final newLastDocument = querySnapshot.docs.isNotEmpty
        ? querySnapshot.docs.last
        : null;

    return (chats: chats, lastDocument: newLastDocument);
  }

  /// Fetch chat documents from /chats/{chatId}.
  Future<List<ChatFirestoreApiModel>> getChatsByIds(
    List<String> chatIds,
  ) async {
    if (chatIds.isEmpty) {
      return [];
    }

    final snapshots = await Future.wait(
      chatIds.map(_chats.doc).map((ref) => ref.get()),
    );

    return snapshots
        .where((snapshot) => snapshot.exists)
        .map(_parseChatDoc)
        .toList();
  }

  /// Find an existing 1:1 chat between two users.
  Future<ChatFirestoreApiModel?> findDirectChat({
    required String userId1,
    required String userId2,
  }) async {
    final query = await _chats
        .where('isGroup', isEqualTo: false)
        .where('members', arrayContains: userId1)
        .get();

    for (final doc in query.docs) {
      final chat = _parseChatDoc(doc);
      if (chat.members.contains(userId2)) {
        return chat;
      }
    }
    return null;
  }

  /// Creates or returns an existing 1:1 chat between two users.
  Future<ChatFirestoreApiModel> createDirectChat({
    required String currentUserId,
    required String otherUserId,
    String? otherUserName,
  }) async {
    final chatId = generateFirestoreId();
    final members = [currentUserId, otherUserId];
    final chatData = <String, dynamic>{
      'chatId': chatId,
      'isGroup': false,
      'chatName': otherUserName ?? 'Chat',
      'createdAt': FieldValue.serverTimestamp(),
      'members': members,
    };

    final batch = _firestore.batch();
    batch.set(_chats.doc(chatId), chatData);

    for (final memberId in members) {
      batch.set(_userChats(memberId).doc(chatId), {
        'chatId': chatId,
        'unreadCount': 0,
        'isPinned': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();

    final created = await getChat(chatId);
    if (created == null) {
      throw Exception('Failed to create chat');
    }

    return created;
  }

  /// Delete a chat from the user's active chats subcollection and remove the user from chat members.
  Future<void> deleteUserChat({
    required String userId,
    required String chatId,
  }) async {
    final batch = _firestore.batch();
    batch.delete(_userChats(userId).doc(chatId));
    batch.update(_chats.doc(chatId), {
      'members': FieldValue.arrayRemove([userId]),
    });
    await batch.commit();
  }

  /// Delete the chat document entirely and remove the chat from all members' user-chats.
  Future<void> deleteChat({
    required String chatId,
    required List<String> members,
  }) async {
    await _chats.doc(chatId).delete();
    final batch = _firestore.batch();
    batch.delete(_chats.doc(chatId));
    for (final memberId in members) {
      batch.delete(_userChats(memberId).doc(chatId));
    }
    await batch.commit();
  }

  /// Fetch a single chat document from /chats/{chatId}.
  Future<ChatFirestoreApiModel?> getChat(String chatId) async {
    final snapshot = await _chats.doc(chatId).get();
    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }

    return _parseChatDoc(snapshot);
  }

  /// Fetch messages from /chats/{chatId}/messages ordered by sentAt descending.
  Future<List<ChatMessageFirestoreApiModel>> getChatMessages(
    String chatId, {
    int? limit,
    DocumentSnapshot? lastDocument,
  }) async {
    var query = _chatMessages(chatId).orderBy('sentAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map(_parseMessageDoc).toList();
  }

  /// Fetch the latest message for a chat.
  Future<ChatMessageFirestoreApiModel?> getLatestChatMessage(
    String chatId,
  ) async {
    final messages = await getChatMessages(chatId, limit: 1);
    if (messages.isEmpty) {
      return null;
    }
    return messages.first;
  }

  /// Create a message and update chat/user chat metadata.
  Future<ChatMessageFirestoreApiModel> sendChatMessage({
    required String chatId,
    required ChatMessageFirestoreApiModel message,
  }) async {
    final chatRef = _chats.doc(chatId);
    final chatSnapshot = await chatRef.get();
    if (!chatSnapshot.exists || chatSnapshot.data() == null) {
      throw Exception('Chat not found');
    }

    final chat = _parseChatDoc(chatSnapshot);
    final messageRef = message.messageId.isNotEmpty
        ? _chatMessages(chatId).doc(message.messageId)
        : _chatMessages(chatId).doc();
    final messageId = messageRef.id;
    final sentAt = message.sentAt;

    final messageData = message
        .copyWith(messageId: messageId, sentAt: sentAt)
        .toJson();
    messageData['sentAt'] = FieldValue.serverTimestamp();

    final batch = _firestore.batch();
    batch.set(messageRef, messageData);
    batch.set(chatRef, {
      'lastMessage': {
        'text': message.content,
        'senderId': message.senderId,
        'sentAt': FieldValue.serverTimestamp(),
      },
    }, SetOptions(merge: true));

    for (final memberId in chat.members) {
      final userChatRef = _userChats(memberId).doc(chatId);
      final userChatUpdates = <String, dynamic>{
        'chatId': chatId,
        'lastMessageText': message.content,
        'lastMessageSenderId': message.senderId,
        'lastMessageSentAt': FieldValue.serverTimestamp(),
      };

      if (memberId != message.senderId) {
        userChatUpdates['unreadCount'] = FieldValue.increment(1);
      }

      batch.set(userChatRef, userChatUpdates, SetOptions(merge: true));
    }

    await batch.commit();

    return message.copyWith(
      messageId: messageId,
      id: messageId,
      sentAt: sentAt,
    );
  }

  /// Subscribe to newly created messages in a chat.
  Stream<ChatMessageFirestoreApiModel> subscribeToChatMessages(
    String chatId,
  ) async* {
    var isFirstSnapshot = true;

    await for (final snapshot in _chatMessages(
      chatId,
    ).orderBy('sentAt', descending: true).snapshots()) {
      if (isFirstSnapshot) {
        isFirstSnapshot = false;
        continue;
      }

      for (final change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          yield _parseMessageDoc(change.doc);
        }
      }
    }
  }

  /// Subscribe to newly created messages across all chats for a user.
  Stream<({String chatId, ChatMessageFirestoreApiModel message})>
  subscribeToUserChatMessages(String userId) {
    final controller =
        StreamController<
          ({String chatId, ChatMessageFirestoreApiModel message})
        >();
    final messageSubscriptions =
        <String, StreamSubscription<ChatMessageFirestoreApiModel>>{};
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
    userChatsSubscription;
    var isFirstUserChatsSnapshot = true;

    void listenToChat(String chatId) {
      if (messageSubscriptions.containsKey(chatId)) {
        return;
      }

      messageSubscriptions[chatId] = subscribeToChatMessages(chatId).listen(
        (message) => controller.add((chatId: chatId, message: message)),
        onError: controller.addError,
      );
    }

    userChatsSubscription = _userChats(userId).snapshots().listen((snapshot) {
      if (isFirstUserChatsSnapshot) {
        isFirstUserChatsSnapshot = false;
        for (final doc in snapshot.docs) {
          listenToChat(doc.id);
        }
        return;
      }

      for (final change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          listenToChat(change.doc.id);
        }
      }
    }, onError: controller.addError);

    controller.onCancel = () async {
      await userChatsSubscription?.cancel();
      for (final subscription in messageSubscriptions.values) {
        await subscription.cancel();
      }
    };

    return controller.stream;
  }
}
