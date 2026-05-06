// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../config/assets.dart';
import '../../../domain/models/content/content.dart';

class LocalDataService {
  Future<List<Content>> getMockFeed() async {
    final articles = await getArticleContents();
    final videos = await getVideoContents();
    final knowledge = await getKnowledgeContents();
    final banners = await getBannerContents();
    final combined = [...articles, ...videos, ...knowledge, ...banners];
    combined.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return combined;
  }

  Future<List<ArticleContent>> getArticleContents() async {
    final json = await _loadStringAsset(AppAssets.articlesJson);
    return json.map<ArticleContent>((e) => ArticleContent.fromJson(e)).toList();
  }

  Future<ArticleContent?> getArticleContentById(String id) async {
    final articles = await getArticleContents();

    try {
      return articles.firstWhere((article) => article.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<VideoContent>> getVideoContents() async {
    final json = await _loadStringAsset(AppAssets.videosJson);
    return json.map<VideoContent>((e) => VideoContent.fromJson(e)).toList();
  }

  Future<List<KnowledgeContent>> getKnowledgeContents() async {
    final json = await _loadStringAsset(AppAssets.knowledgeJson);
    return json
        .map<KnowledgeContent>((e) => KnowledgeContent.fromJson(e))
        .toList();
  }

  Future<List<BannerContent>> getBannerContents() async {
    final json = await _loadStringAsset(AppAssets.bannersJson);
    return json.map<BannerContent>((e) => BannerContent.fromJson(e)).toList();
  }

  Future<List<Map<String, dynamic>>> _loadStringAsset(String asset) async {
    final localData = await rootBundle.loadString(asset);
    return (jsonDecode(localData) as List).cast<Map<String, dynamic>>();
  }
}
