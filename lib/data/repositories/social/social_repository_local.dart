import 'dart:math';

import 'package:emombti/domain/models/social/social.dart';

import 'social_repository.dart';

class SocialRepositoryLocal implements SocialRepository {
  // Shared mock data constants
  final List<String> _mbtiTypes = [
    'INTJ',
    'INTP',
    'ENTJ',
    'ENTP',
    'INFJ',
    'INFP',
    'ENFJ',
    'ENFP',
    'ISTJ',
    'ISFJ',
    'ESTJ',
    'ESFJ',
    'ISTP',
    'ISFP',
    'ESTP',
    'ESFP',
  ];

  final List<String> _names = [
    'Shengfeng',
    'Alex',
    'Jordan',
    'Taylor',
    'Morgan',
    'Casey',
  ];

  final List<String> _randomTexts = [
    "This Flutter + Rust combo is blazing fast! 🦀",
    "I love the rounded corners on this sheet.",
    "Can we filter comments by MBTI type?",
    "The outlineVariant border looks very subtle and clean.",
    "Wait, how did you handle the sliver overlap?",
    "Nice work on the Material 3 surface colors.",
  ];

  /// Helper to generate a single consistent comment based on an index
  Comment _generateMockComment(int index) {
    final random = Random(
      index,
    ); // Use index as seed for consistent-ish data per ID
    return Comment(
      id: 'local_$index',
      userId: 'user_${random.nextInt(100)}',
      authorName: _names[random.nextInt(_names.length)],
      authorMbti: _mbtiTypes[random.nextInt(_mbtiTypes.length)],
      authorAvatarUrl: 'https://i.pravatar.cc/150?u=user_$index',
      content: _randomTexts[random.nextInt(_randomTexts.length)],
      createdAt: DateTime.now().subtract(Duration(minutes: index * 10)),
      likesCount: random.nextInt(100),
      isLiked: random.nextBool(),
    );
  }

  @override
  Future<List<Comment>> getComments(String relatedId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.generate(15, (index) => _generateMockComment(index));
  }

  @override
  Future<List<Comment>> getCommentsByPage(
    String relatedId, {
    int page = 1,
    int pageSize = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    const int totalMockComments = 50;
    int start = (page - 1) * pageSize;

    if (start >= totalMockComments) return [];

    int end = min(start + pageSize, totalMockComments);
    int countToGenerate = end - start;

    return List.generate(countToGenerate, (index) {
      // Offset by the 'start' index to ensure unique IDs across pages
      return _generateMockComment(start + index);
    });
  }

  @override
  Future<void> postComment(String relatedId, String content) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulation logic here...
  }

  @override
  Future<void> toggleLike(String relatedId, bool shouldLike) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> toggleFavorite(String relatedId, bool shouldFavorite) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<SocialMeta> getSocialMeta(String relatedId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return SocialMeta(
      isLiked: false,
      isFavorited: false,
      likesCount: 420000000,
      favoritesCount: 12,
      commentsCount: 5000,
      id: '',
      relatedId: '',
    );
  }
}
