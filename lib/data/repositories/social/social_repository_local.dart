import 'dart:math';

import 'package:emombti/domain/models/social/social.dart';

import 'social_repository.dart';

class SocialRepositoryLocal implements SocialRepository {
  @override
  Future<List<Comment>> getComments(String relatedId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final random = Random();

    final List<String> mbtiTypes = [
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

    final List<String> names = [
      'Shengfeng',
      'Alex',
      'Jordan',
      'Taylor',
      'Morgan',
      'Casey',
    ];

    final List<String> randomText = [
      "This Flutter + Rust combo is blazing fast! 🦀",
      "I love the rounded corners on this sheet.",
      "Can we filter comments by MBTI type?",
      "The outlineVariant border looks very subtle and clean.",
      "Wait, how did you handle the sliver overlap?",
      "Nice work on the Material 3 surface colors.",
    ];

    return List.generate(15, (index) {
      return Comment(
        id: 'local_$index',
        userId: 'user_${random.nextInt(5)}',
        authorName: names[random.nextInt(names.length)],
        authorMbti: mbtiTypes[random.nextInt(mbtiTypes.length)],
        // Use a placeholder service for avatars
        authorAvatarUrl:
            'https://i.pravatar.cc/150?u=${index + random.nextInt(100)}',
        content: randomText[random.nextInt(randomText.length)],
        createdAt: DateTime.now().subtract(Duration(minutes: index * 10)),
        likesCount: random.nextInt(50),
        isLiked: random.nextBool(),
      );
    });
  }

  @override
  Future<void> postComment(String relatedId, String content) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Simulation of local persistence logic
  }
}
