import 'package:flutter/material.dart';

/// 书籍数据模型
class Book {
  final int id;
  final String name;
  final String author;
  final List<Color> cover;
  final int progress;
  final String badge;
  final String category;
  final String description;
  final List<String> tags;
  final String words;

  const Book({
    required this.id,
    required this.name,
    required this.author,
    required this.cover,
    required this.progress,
    required this.badge,
    required this.category,
    required this.description,
    required this.tags,
    required this.words,
  });

  Gradient get coverGradient => LinearGradient(
        colors: cover,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}

/// 章节
class Chapter {
  final String title;
  final List<String> paragraphs;
  const Chapter({required this.title, required this.paragraphs});
}

/// AI 模型提供商
class AiModel {
  final String name;
  final String provider;
  final Color color;
  final String icon;
  const AiModel({
    required this.name,
    required this.provider,
    required this.color,
    required this.icon,
  });
}

/// AI 消息
class AiMessage {
  final bool isUser;
  final String text;
  final Book? recommendCard;
  const AiMessage({required this.isUser, required this.text, this.recommendCard});
}
