import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/social/social_meta_api_model.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _socialMetas =>
      _firestore.collection('social_metas');

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
}
