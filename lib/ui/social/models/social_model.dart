import 'package:emombti/domain/models/social/social.dart';
import 'package:flutter/foundation.dart';

class SocialModel extends ValueNotifier<SocialMeta?> {
  SocialModel([SocialMeta? initialValue]) : super(initialValue);

  void setMetrics(SocialMeta? meta) {
    if (value == null) {
      value = meta;
    } else if (meta != null) {
      value = value!.copyWith(
        likesCount: meta.likesCount,
        commentsCount: meta.commentsCount,
        favoritesCount: meta.favoritesCount,
        isLiked: meta.isLiked,
        isFavorited: meta.isFavorited,
      );
    }
  }

  void addComment(Comment comment) {
    final currentMeta = value;
    if (currentMeta != null) {
      value = currentMeta.copyWith(
        commentsCount: currentMeta.commentsCount + 1,
        comments: [comment, ...currentMeta.comments],
      );
    }
  }

  void setComments(List<Comment> comments) {
    final currentMeta = value;
    if (currentMeta != null) {
      value = currentMeta.copyWith(comments: comments);
    }
  }

  void toggleLike(bool isLiked) {
    final currentMeta = value;
    if (currentMeta != null) {
      value = currentMeta.copyWith(
        isLiked: isLiked,
        likesCount: isLiked
            ? currentMeta.likesCount + 1
            : currentMeta.likesCount - 1,
      );
    }
  }

  void toggleFavorite(bool isFavorited) {
    final currentMeta = value;
    if (currentMeta != null) {
      value = currentMeta.copyWith(
        isFavorited: isFavorited,
        favoritesCount: isFavorited
            ? currentMeta.favoritesCount + 1
            : currentMeta.favoritesCount - 1,
      );
    }
  }
}
